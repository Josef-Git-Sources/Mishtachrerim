/**
 * Career / Intent page — /career/[slug]
 *
 * This single route serves two content variants:
 *
 *   page_type = 'career'
 *     Full career path page. SEO landing page, trust page, course hub.
 *     Examples: /career/qa-tester, /career/data-analyst
 *
 *   page_type = 'intent'
 *     Focused intent page targeting a specific search query.
 *     Links back to the parent career page.
 *     Examples: /career/how-to-become-qa, /career/qa-salary
 *
 * Both types are stored in the career_paths table and distinguished
 * by the page_type field. generateStaticParams returns slugs for both.
 * No separate route or file is needed for intent pages.
 *
 * Phase 1: generateStaticParams returns an empty array. Placeholder rendered.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

interface Props {
  params: Promise<{ slug: string }>
}

export async function generateStaticParams() {
  // TODO: Query ALL published career_paths (page_type 'career' AND 'intent')
  // const paths = await fetchPublishedCareerPaths()
  // return paths.map((p) => ({ slug: p.slug }))
  return []
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  // TODO: Fetch career path by slug; use page_type to build appropriate metadata
  return buildMetadata({
    title: slug,
    path: `/career/${slug}`,
  })
}

export default async function CareerPage({ params }: Props) {
  const { slug } = await params
  // TODO: Fetch career path record by slug from the database
  // Branch on page_type:
  //   'career' → render full CareerPageLayout
  //   'intent' → render IntentPageLayout
  return (
    <article>
      <h1>{slug}</h1>
      <p>placeholder — career/intent content will be loaded from the database</p>
    </article>
  )
}
