/**
 * Career paths index — /career
 *
 * Optional browse index for all published career paths.
 * Secondary entry point for users who want to explore manually
 * rather than through the quiz.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'מסלולי קריירה',
  description: 'גלה מסלולי קריירה מומלצים למשתחררי צבא — תחומים, שכר, והכשרות.',
  path: '/career',
})

export default function CareerIndexPage() {
  return (
    <section>
      <h1>מסלולי קריירה</h1>
      <p>placeholder — career path list will be loaded from the database</p>
    </section>
  )
}
