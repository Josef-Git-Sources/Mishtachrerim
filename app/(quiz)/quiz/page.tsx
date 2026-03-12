/**
 * Quiz start / quick quiz — /quiz
 *
 * Entry point for the quiz flow. Presents the mode selection (quick vs deep)
 * and runs the quick quiz (5 questions) in a single Client Component using
 * state-based progression (Option A from the routing spec).
 *
 * On completion, calls POST /api/quiz/submit with the submitted answers.
 * The API returns a result_id and the browser navigates to /results/[id].
 *
 * noIndex: the quiz is an interactive tool, not an SEO page.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'שאלון קריירה',
  noIndex: true,
})

export default function QuizPage() {
  return (
    <section>
      <h1>שאלון קריירה</h1>
      <p>placeholder — quiz interface (QuizShell component) will be added in Phase 2</p>
    </section>
  )
}
