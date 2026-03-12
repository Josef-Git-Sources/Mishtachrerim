/**
 * Dashboard overview — /dashboard
 *
 * Logged-in user home. Provides access to saved results, courses,
 * checklist progress, and profile settings.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'האזור שלי',
  noIndex: true,
})

export default function DashboardPage() {
  return (
    <section>
      <h1>האזור שלי</h1>
      <p>placeholder — dashboard overview will be added in Phase 2</p>
    </section>
  )
}
