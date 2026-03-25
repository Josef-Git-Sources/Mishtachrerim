/**
 * Results page — /results/[id]
 *
 * Displays the top 3 career recommendations for a completed quiz attempt.
 * Each quiz completion creates a persistent record in quiz_results,
 * so results are shareable via URL and can be revisited without login.
 *
 * noIndex: result pages are personal and should not be indexed.
 *
 * Data is loaded via getQuizResult() (lib/data/results.ts) directly —
 * no internal API fetch from a Server Component.
 */
import { notFound } from 'next/navigation'
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import { getQuizResult } from '@/lib/data/results'

interface Props {
  params: Promise<{ id: string }>
}

export async function generateMetadata(_props: Props): Promise<Metadata> {
  return buildMetadata({ title: 'תוצאות שאלון', noIndex: true })
}

export default async function ResultsPage({ params }: Props) {
  const { id } = await params
  const result = await getQuizResult(id)

  if (!result) notFound()

  return (
    <section>
      <h1>התוצאות שלך</h1>
      <p className="results-intro">
        הציון משקף את מידת ההתאמה בין התשובות שלך לכל מסלול — ככל שהציון גבוה יותר, כך ההתאמה גדולה יותר.
        זו רשימה מדורגת, לא ציון עובר/נכשל.
      </p>

      {result.careers.length === 0 ? (
        <p>לא נמצאו תוצאות לשאלון זה.</p>
      ) : (
        <>
          <h2 className="results-rank-heading">המסלולים המתאימים לך ביותר</h2>
          <ol className="results-ol">
            {result.careers.map((career, index) => (
              <li key={career.careerPathSlug}>
                {index === 0 && (
                  <span className="results-best-label">ההתאמה הגבוהה ביותר</span>
                )}
                <a href={`/career/${career.careerPathSlug}`}>
                  {career.careerPathName}
                </a>
                {' '}— {career.score} נקודות
              </li>
            ))}
          </ol>
        </>
      )}

      <section className="cta-box">
        <p>
          רוצים לחקור לעומק?{' '}
          <a href="/career">לכל מסלולי הקריירה</a>
          {' · '}
          <a href="/quiz">לשאלון מחדש</a>
        </p>
      </section>
    </section>
  )
}
