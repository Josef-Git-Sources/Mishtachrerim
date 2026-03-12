/**
 * Courses browse page — /courses
 *
 * Curated browse layer for training programs.
 * Secondary entry point — courses are primarily discovered via career pages.
 * This page remains small and curated, not a marketplace catalog.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'קורסים',
  description: 'קורסים מומלצים למשתחררי צבא — הכשרות מקצועיות קצרות ומעשיות.',
  path: '/courses',
})

export default function CoursesIndexPage() {
  return (
    <section>
      <h1>קורסים</h1>
      <p>placeholder — curated course list will be loaded from the database</p>
    </section>
  )
}
