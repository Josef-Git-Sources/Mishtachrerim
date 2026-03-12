/**
 * Deep quiz entry — /quiz/deep
 *
 * Dedicated entry point for the longer quiz flow (10 questions).
 * Provides a more refined career recommendation than the quick quiz.
 * May display an explanation before starting.
 *
 * noIndex: interactive tool, not an SEO page.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'שאלון מעמיק',
  noIndex: true,
})

export default function DeepQuizPage() {
  return (
    <section>
      <h1>שאלון מעמיק</h1>
      <p>placeholder — deep quiz interface will be added in Phase 2</p>
    </section>
  )
}
