/**
 * Course comparison page — /courses/compare
 *
 * Interactive page allowing users to compare selected courses side-by-side.
 * Comparison attributes: duration, learning mode, difficulty, price range,
 * deposit eligibility, and field salary range.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'השוואת קורסים',
  description: 'השווה קורסים מקצועיים — משך, מחיר, מסלול לימוד וזכאות למענק שחרור.',
  path: '/courses/compare',
})

export default function CourseComparePage() {
  return (
    <section>
      <h1>השוואת קורסים</h1>
      <p>placeholder — course comparison tool will be added in Phase 2</p>
    </section>
  )
}
