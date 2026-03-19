/**
 * Editorial course comparison page — /courses/editorial/[slug]
 *
 * SEO comparison page targeting commercial-intent queries.
 * Examples: /courses/editorial/best-qa-courses
 *
 * These pages compare multiple curated courses for a specific field
 * and guide users toward training decisions.
 * Statically generated at build time.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

interface Props {
  params: Promise<{ slug: string }>
}

export async function generateStaticParams() {
  // TODO: Query published editorial page slugs from the database (or CMS)
  return []
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  return buildMetadata({
    title:       slug.replace(/-/g, ' ') || 'השוואת קורסים',
    description: 'השוואת קורסים והכשרות מקצועיות',
    path:        `/courses/editorial/${slug}`,
  })
}

export default async function EditorialCoursePage({ params }: Props) {
  const { slug } = await params
  return (
    <article>
      <h1>{slug}</h1>
      <p>placeholder — editorial course comparison content will be added in Phase 2</p>
    </article>
  )
}
