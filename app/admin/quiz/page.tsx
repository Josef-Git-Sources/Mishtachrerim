/**
 * Admin — Manage quiz content — /admin/quiz
 *
 * Create and edit quiz questions, answer options, and score mappings.
 * Score values must remain consistent with /docs/quiz/QUIZ_QUESTION_BANK.md.
 *
 * Changes here affect the matching engine output directly.
 * Any score mapping changes should be tested against known answer sets.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({ title: 'Admin — Quiz', noIndex: true })

export default function AdminQuizPage() {
  return (
    <section>
      <h1>Admin — Quiz</h1>
      <p>placeholder</p>
    </section>
  )
}
