/**
 * Checklist page — /checklist
 *
 * Public utility page listing practical first steps after military discharge.
 * No login required. Logged-in users can save their progress.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'צ׳קליסט לאחר השחרור',
  description: 'רשימת משימות מעשיות למשתחרר — מה לעשות בשבועות הראשונים אחרי הצבא.',
  path: '/checklist',
})

export default function ChecklistPage() {
  return (
    <section>
      <h1>צ׳קליסט לאחר השחרור</h1>
      <p>placeholder — checklist items will be loaded from the database</p>
    </section>
  )
}
