/**
 * Personal checklist progress — /dashboard/checklist
 *
 * Displays the user's checklist completion status.
 * Items are stored in user_checklist_items joined with checklist_items.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'הצ׳קליסט שלי',
  noIndex: true,
})

export default function DashboardChecklistPage() {
  return (
    <section>
      <h1>הצ׳קליסט שלי</h1>
      <p>placeholder — personal checklist progress will be loaded from the database</p>
    </section>
  )
}
