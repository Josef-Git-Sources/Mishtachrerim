/**
 * Guides index — /guides
 *
 * Directory of SEO informational guides.
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'מדריכים',
  description: 'מדריכים מקיפים למשתחררי צבא — קריירה, הכשרות, והשוק הפתוח.',
  path: '/guides',
})

export default function GuidesIndexPage() {
  return (
    <section>
      <h1>מדריכים</h1>
      <p>placeholder — guide list will be loaded from the database</p>
    </section>
  )
}
