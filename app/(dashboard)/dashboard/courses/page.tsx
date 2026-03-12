/**
 * Saved courses — /dashboard/courses
 *
 * Lists training programs saved by the user.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'קורסים שמורים',
  noIndex: true,
})

export default function DashboardCoursesPage() {
  return (
    <section>
      <h1>קורסים שמורים</h1>
      <p>placeholder — saved courses will be loaded from the database</p>
    </section>
  )
}
