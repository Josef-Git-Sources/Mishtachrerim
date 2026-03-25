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
      <p>שאלון: {result.quizType === 'quick' ? 'מהיר' : 'מעמיק'}</p>

      <ol className="results-ol">
        {result.careers.map((career) => (
          <li key={career.careerPathSlug}>
            <a href={`/career/${career.careerPathSlug}`}>
              {career.careerPathName}
            </a>
            {' '}— {career.score} נקודות
          </li>
        ))}
      </ol>

      {result.careers.length === 0 && (
        <p>לא נמצאו תוצאות לשאלון זה.</p>
      )}

      <section className="cta-box">
        <p>
          <a href="/quiz">לשאלון מחדש</a>
          {' · '}
          <a href="/career">לכל מסלולי הקריירה</a>
        </p>
      </section>
    </section>
  )
}
