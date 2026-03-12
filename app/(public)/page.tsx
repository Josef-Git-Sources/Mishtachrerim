/**
 * Homepage — /
 *
 * Primary entry point. Introduces the platform and routes users to:
 *   - /quiz (start planning)
 *   - /checklist (post-discharge actions)
 *   - /guides (informational content)
 *   - /career (browse career paths)
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'משתחררים — מצא את הכיוון המקצועי שלך',
  description: 'פלטפורמת קריירה למשתחררי צבא. גלה מסלולים מקצועיים, קורסים וכלים לתכנון הדרך שאחרי הצבא.',
  path: '/',
})

export default function HomePage() {
  return (
    <section>
      <h1>משתחררים</h1>
      <p>פלטפורמת קריירה למשתחררי צבא — placeholder</p>
    </section>
  )
}
