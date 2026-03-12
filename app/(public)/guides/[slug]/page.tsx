/**
 * Guide detail page — /guides/[slug]
 *
 * SEO informational content page. Statically generated at build time.
 * Each guide captures broad informational search queries and leads
 * users into the quiz or career exploration flow.
 *
 * Phase 1: generateStaticParams returns an empty array (no content yet).
 *          The page renders a placeholder for any slug.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

interface Props {
  params: Promise<{ slug: string }>
}

export async function generateStaticParams() {
  // TODO: Query published guide slugs from the database
  // const guides = await fetchPublishedGuides()
  // return guides.map((g) => ({ slug: g.slug }))
  return []
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  // TODO: Fetch guide by slug and use real title/description
  return buildMetadata({
    title: slug,
    path: `/guides/${slug}`,
  })
}

export default async function GuideDetailPage({ params }: Props) {
  const { slug } = await params
  // TODO: Fetch guide content by slug from the database
  return (
    <article>
      <h1>{slug}</h1>
      <p>placeholder — guide content will be loaded from the database</p>
    </article>
  )
}
