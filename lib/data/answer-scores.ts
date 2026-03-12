/**
 * Data-access: quiz answer scores.
 *
 * Server-side only. Do not import in Client Components.
 *
 * Loads the full quiz_answer_scores table joined with career_paths
 * to include slug and name. Passed directly to calculateResults()
 * in lib/matching-engine.ts — no further DB calls needed during scoring.
 *
 * Source of truth for score values: /docs/quiz/QUIZ_QUESTION_BANK.md
 */
import { createServerClient } from '@/lib/supabase/server'
import type { QuizAnswerScore } from '@/types'

// Local types matching DB column names
type DbCareerPath = {
  slug: string
  title: string
}

type DbAnswerScore = {
  answer_id: string
  career_path_id: string
  score_value: number
  career_paths: DbCareerPath
}

export async function getAnswerScores(): Promise<QuizAnswerScore[]> {
  const supabase = await createServerClient()

  const { data, error } = await supabase
    .from('quiz_answer_scores')
    .select(`
      answer_id,
      career_path_id,
      score_value,
      career_paths (
        slug,
        title
      )
    `)

  if (error) {
    throw new Error(`Failed to load answer scores: ${error.message}`)
  }

  return (data as unknown as DbAnswerScore[]).map((row) => ({
    answerId:       row.answer_id,
    careerPathId:   row.career_path_id,
    careerPathSlug: row.career_paths.slug,
    careerPathName: row.career_paths.title,
    scoreValue:     row.score_value,
  }))
}
