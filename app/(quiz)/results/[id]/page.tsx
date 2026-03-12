/**
 * Results page — /results/[id]
 *
 * Displays the top 3 career recommendations for a completed quiz attempt.
 * Each quiz completion creates a persistent record in quiz_results,
 * so results are shareable via URL and can be revisited without login.
 *
 * Logged-in users can save results to their dashboard from this page.
 *
 * noIndex: result pages are personal and should not be indexed.
 *          They should not appear in search results for other users.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

interface Props {
  params: Promise<{ id: string }>
}

export async function generateMetadata(_props: Props): Promise<Metadata> {
  // TODO Phase 2: use params.id to fetch result-specific title once data layer is wired
  return buildMetadata({
    title: 'תוצאות שאלון',
    noIndex: true,
  })
}

export default async function ResultsPage({ params }: Props) {
  const { id } = await params
  // TODO: Fetch quiz result and top-3 ranked careers by id
  // GET /api/results/[id] or direct Supabase query
  return (
    <section>
      <h1>תוצאות השאלון שלך</h1>
      <p>result id: {id}</p>
      <p>placeholder — career recommendations will be displayed in Phase 2</p>
    </section>
  )
}
