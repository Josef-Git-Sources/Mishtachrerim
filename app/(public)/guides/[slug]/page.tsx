/**
 * Guide detail page — /guides/[slug]
 *
 * SEO informational content page. Statically generated at build time.
 * Each guide captures broad informational search queries and leads
 * users into the quiz or career exploration flow.
 *
 * Content is fully static — no database queries.
 * Six guides are served:
 *   - what-to-do-after-army
 *   - how-to-enter-high-tech-without-degree
 *   - high-paying-jobs-without-degree
 *   - what-to-study-after-army
 *   - how-to-choose-career-after-army
 *   - how-to-use-army-deposit
 *
 * ISR: revalidated hourly, matching the convention across all public pages.
 */
import { notFound } from 'next/navigation'
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import { getGuide, getAllGuideSlugs } from '@/lib/content/guides'
import { GuidePageContent } from '../_components/GuidePageContent'

export const revalidate = 3600

interface Props {
  params: Promise<{ slug: string }>
}

export function generateStaticParams() {
  return getAllGuideSlugs().map((slug) => ({ slug }))
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  const guide = getGuide(slug)

  if (!guide) {
    return buildMetadata({ title: 'דף לא נמצא' })
  }

  return buildMetadata({
    title:       guide.title,
    description: guide.description,
    path:        `/guides/${slug}`,
    openGraph:   {},
  })
}

export default async function GuideDetailPage({ params }: Props) {
  const { slug } = await params
  const guide = getGuide(slug)

  if (!guide) notFound()

  return <GuidePageContent guide={guide} />
}
