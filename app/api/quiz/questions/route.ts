/**
 * Quiz questions endpoint — GET /api/quiz/questions?mode=quick|deep
 *
 * Returns quiz questions with their answer options for the requested mode.
 * Used by external clients and tests. The quiz page loads questions directly
 * via getQuizQuestions() as a Server Component.
 */
import { NextRequest, NextResponse } from 'next/server'
import { getQuizQuestions } from '@/lib/data/questions'
import type { QuizMode } from '@/types'

const VALID_MODES: QuizMode[] = ['quick', 'deep']

export async function GET(request: NextRequest) {
  const mode = request.nextUrl.searchParams.get('mode') as QuizMode | null

  if (!mode || !VALID_MODES.includes(mode)) {
    return NextResponse.json(
      { error: `mode query param must be one of: ${VALID_MODES.join(', ')}` },
      { status: 400 }
    )
  }

  const questions = await getQuizQuestions(mode)
  return NextResponse.json(questions)
}
