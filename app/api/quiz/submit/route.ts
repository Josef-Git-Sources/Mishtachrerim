/**
 * Quiz submission endpoint — POST /api/quiz/submit
 *
 * Receives a completed quiz, calculates career recommendations,
 * persists the top 3 results, and returns the result ID.
 *
 * Anonymous users: user_id is null in quiz_results.
 * Authenticated users: user_id is attached from the session.
 *
 * Request body: { mode: 'quick' | 'deep', answers: { questionId: string, answerId: string }[] }
 * Response:     { resultId: string }
 */
import { NextRequest, NextResponse } from 'next/server'
import { createServerClient } from '@/lib/supabase/server'
import { getAnswerScores } from '@/lib/data/answer-scores'
import { calculateResults } from '@/lib/matching-engine'
import type { QuizMode, SubmittedAnswer } from '@/types'

const VALID_MODES: QuizMode[] = ['quick', 'deep']
const TOP_N = 3

function validationError(message: string) {
  return NextResponse.json({ error: message }, { status: 400 })
}

export async function POST(request: NextRequest) {
  // Parse body
  let body: unknown
  try {
    body = await request.json()
  } catch {
    return validationError('Request body must be valid JSON')
  }

  if (typeof body !== 'object' || body === null) {
    return validationError('Request body must be an object')
  }

  const { mode, answers } = body as Record<string, unknown>

  // Validate mode
  if (!VALID_MODES.includes(mode as QuizMode)) {
    return validationError(`mode must be one of: ${VALID_MODES.join(', ')}`)
  }

  // Validate answers array
  if (!Array.isArray(answers) || answers.length === 0) {
    return validationError('answers must be a non-empty array')
  }

  for (let i = 0; i < answers.length; i++) {
    const a = answers[i]
    if (typeof a !== 'object' || a === null) {
      return validationError(`answers[${i}] must be an object`)
    }
    const { questionId, answerId } = a as Record<string, unknown>
    if (typeof questionId !== 'string' || questionId.trim() === '') {
      return validationError(`answers[${i}].questionId must be a non-empty string`)
    }
    if (typeof answerId !== 'string' || answerId.trim() === '') {
      return validationError(`answers[${i}].answerId must be a non-empty string`)
    }
  }

  const submittedAnswers = answers as SubmittedAnswer[]

  // Load score data and run the matching engine
  const answerScores = await getAnswerScores()
  const ranked = calculateResults(submittedAnswers, answerScores)
  const top3 = ranked.slice(0, TOP_N)

  // Attach authenticated user if present (anonymous is fine)
  const supabase = await createServerClient()
  const { data: { user } } = await supabase.auth.getUser()
  const userId = user?.id ?? null

  // Persist the quiz result
  const { data: resultRow, error: resultError } = await supabase
    .from('quiz_results')
    .insert({
      user_id:      userId,
      quiz_type:    mode,
      quiz_version: 1,
    })
    .select('id')
    .single()

  if (resultError || !resultRow) {
    console.error('Failed to insert quiz_results:', resultError)
    return NextResponse.json({ error: 'Failed to save result' }, { status: 500 })
  }

  // Persist top-3 ranked careers
  if (top3.length > 0) {
    // We need to look up career_path_id by slug for each top career
    const slugs = top3.map((c) => c.careerPathSlug)
    const { data: careerPaths, error: cpError } = await supabase
      .from('career_paths')
      .select('id, slug')
      .in('slug', slugs)

    if (cpError || !careerPaths) {
      console.error('Failed to fetch career_paths for result:', cpError)
      return NextResponse.json({ error: 'Failed to save result careers' }, { status: 500 })
    }

    const slugToId = new Map(careerPaths.map((cp: { id: string; slug: string }) => [cp.slug, cp.id]))

    const careerInserts = top3.map((career) => ({
      quiz_result_id: resultRow.id,
      career_path_id: slugToId.get(career.careerPathSlug),
      score:          career.score,
      rank:           career.rank,
    }))

    const { error: careersError } = await supabase
      .from('quiz_result_careers')
      .insert(careerInserts)

    if (careersError) {
      console.error('Failed to insert quiz_result_careers:', careersError)
      return NextResponse.json({ error: 'Failed to save result careers' }, { status: 500 })
    }
  }

  return NextResponse.json({ resultId: resultRow.id }, { status: 201 })
}
