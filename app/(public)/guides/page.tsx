/**
 * Guides index — /guides
 *
 * Static hub listing all SEO informational guides.
 * Content is driven entirely by lib/content/guides.ts — no database queries.
 */
import type { Metadata } from 'next'
import Link from 'next/link'
import { buildMetadata } from '@/lib/seo/metadata'
import { getAllGuides } from '@/lib/content/guides'

export const metadata: Metadata = buildMetadata({
  title: 'מדריכים',
  description: 'מדריכים מקיפים למשתחררי צבא — קריירה, הכשרות, והשוק הפתוח.',
  path: '/guides',
})

export default function GuidesIndexPage() {
  const guides = getAllGuides()

  return (
    <section>
      <h1>מדריכים</h1>
      <ul>
        {guides.map((guide) => (
          <li key={guide.slug}>
            <Link href={`/guides/${guide.slug}`}>{guide.title}</Link>
            <p>{guide.description}</p>
          </li>
        ))}
      </ul>
    </section>
  )
}
