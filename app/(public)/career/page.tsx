/**
 * Career paths index — /career
 *
 * Browse index for all published career paths (page_type = 'career').
 * Secondary entry point for users who prefer to explore manually
 * rather than through the quiz.
 *
 * Uses createPublicClient directly — no bulk-fetch helper exists in
 * lib/data/career-paths.ts, and lib/data/* must not be modified.
 * Follows the same query pattern established in that file.
 *
 * ISR: revalidated hourly.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import { createPublicClient } from '@/lib/supabase/public-client'

export const revalidate = 3600

export const metadata: Metadata = buildMetadata({
  title: 'מסלולי קריירה',
  description: 'גלה מסלולי קריירה מומלצים למשתחררי צבא — תחומים, שכר, והכשרות.',
  path: '/career',
})

type CareerRow = {
  slug: string
  title: string
  salary_range: string | null
  training_time: string | null
}

export default async function CareerIndexPage() {
  const supabase = createPublicClient()
  const { data, error } = await supabase
    .from('career_paths')
    .select('slug, title, salary_range, training_time')
    .eq('is_published', true)
    .eq('page_type', 'career')
    .order('title', { ascending: true })

  if (error) {
    throw new Error(`Failed to load career paths: ${error.message}`)
  }

  const careers = (data ?? []) as CareerRow[]

  return (
    <section>
      <h1>מסלולי קריירה</h1>
      <p>מסלולים מקצועיים למשתחררי צבא — עם מידע על שכר, זמן הכשרה ורשימת קורסים מומלצים.</p>

      {careers.length === 0 ? (
        <p>אין מסלולים זמינים כרגע.</p>
      ) : (
        <ul className="card-list">
          {careers.map((career) => (
            <li key={career.slug}>
              <a href={`/career/${career.slug}`}>{career.title}</a>
              <span className="card-meta">
                {[career.salary_range, career.training_time].filter(Boolean).join(' · ')}
              </span>
            </li>
          ))}
        </ul>
      )}

      <section className="cta-box">
        <p>
          לא בטוחים איזה מסלול מתאים לכם?{' '}
          <a href="/quiz">ענו על כמה שאלות קצרות</a>{' '}
          ונראה איזה כיוון מתאים לפרופיל שלכם.
        </p>
      </section>
    </section>
  )
}
