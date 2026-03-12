/**
 * Saved quiz results — /dashboard/results
 *
 * Lists quiz results saved to the user's account.
 * Each entry links back to /results/[id] for the full result view.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'תוצאות שמורות',
  noIndex: true,
})

export default function DashboardResultsPage() {
  return (
    <section>
      <h1>תוצאות שמורות</h1>
      <p>placeholder — saved quiz results will be loaded from the database</p>
    </section>
  )
}
