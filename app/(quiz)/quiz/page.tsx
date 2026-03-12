/**
 * Quiz page — /quiz
 *
 * Server Component entry point. Reads the mode from search params (default: quick),
 * loads questions from the database, and passes them to the QuizShell Client Component.
 *
 * noIndex: the quiz is an interactive tool, not an SEO page.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import { getQuizQuestions } from '@/lib/data/questions'
import { QuizShell } from './_components/QuizShell'
import type { QuizMode } from '@/types'

export const metadata: Metadata = buildMetadata({
  title: 'שאלון קריירה',
  noIndex: true,
})

const VALID_MODES: QuizMode[] = ['quick', 'deep']

interface Props {
  searchParams: Promise<{ mode?: string }>
}

export default async function QuizPage({ searchParams }: Props) {
  const { mode: rawMode } = await searchParams
  const mode: QuizMode = VALID_MODES.includes(rawMode as QuizMode)
    ? (rawMode as QuizMode)
    : 'quick'

  const questions = await getQuizQuestions(mode)

  return <QuizShell questions={questions} mode={mode} />
}
