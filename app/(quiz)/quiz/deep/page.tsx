/**
 * Deep quiz entry — /quiz/deep
 *
 * Dedicated route for the 10-question deep quiz.
 * Equivalent to /quiz?mode=deep — uses the same QuizShell with mode="deep".
 *
 * noIndex: interactive tool, not an SEO page.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import { getQuizQuestions } from '@/lib/data/questions'
import { QuizShell } from '../_components/QuizShell'

export const metadata: Metadata = buildMetadata({
  title: 'שאלון מעמיק',
  noIndex: true,
})

export default async function DeepQuizPage() {
  const questions = await getQuizQuestions('deep')
  return <QuizShell questions={questions} mode="deep" />
}
