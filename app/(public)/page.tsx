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
    <>
      <section className="hero">
        <h1>משתחררים</h1>
        <p className="hero-lead">
          פלטפורמת קריירה למשתחררי צבא — גלה מסלולים מקצועיים, קורסים מומלצים
          וכלים לתכנון הדרך שאחרי הצבא.
        </p>
        <div className="hero-actions">
          <a href="/quiz" className="btn-primary">התחל/י את השאלון</a>
          <a href="/career" className="btn-secondary">לכל מסלולי הקריירה</a>
        </div>
      </section>

      <section>
        <h2>מה תמצאו כאן</h2>
        <ul>
          <li>
            <a href="/career">מסלולי קריירה</a>{' '}
            — 10 מסלולים מקצועיים עם שכר, זמן הכשרה ורשימת קורסים מומלצים
          </li>
          <li>
            <a href="/quiz">שאלון קריירה</a>{' '}
            — כמה שאלות שעוזרות לברר איזה כיוון מתאים לך
          </li>
          <li>
            <a href="/courses">קורסים</a>{' '}
            — הכשרות מקצועיות קצרות ומעשיות למשתחררים
          </li>
        </ul>
      </section>
    </>
  )
}
