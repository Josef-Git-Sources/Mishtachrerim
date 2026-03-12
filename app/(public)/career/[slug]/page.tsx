/**
 * Career / Intent page — /career/[slug]
 *
 * Single route serving two content variants, distinguished by page_type:
 *
 *   page_type = 'career'
 *     Full career path page. SEO landing page, key facts, associated courses.
 *     Examples: /career/qa-tester, /career/data-analyst
 *
 *   page_type = 'intent'
 *     Focused intent page targeting a specific search query.
 *     Examples: /career/how-to-become-qa, /career/qa-salary
 *
 * Both types are stored in career_paths and served by this route.
 * generateStaticParams returns slugs for both types.
 *
 * ISR: revalidated hourly. New published paths appear on first request
 * without requiring a full rebuild.
 */
import { notFound } from 'next/navigation'
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import {
  getPublishedCareerPathSlugs,
  getCareerPathBySlug,
  getCareerPathWithCourses,
} from '@/lib/data/career-paths'
import { CareerPageContent } from '../_components/CareerPageContent'
import { IntentPageContent } from '../_components/IntentPageContent'

export const revalidate = 3600

interface Props {
  params: Promise<{ slug: string }>
}

export async function generateStaticParams() {
  const slugs = await getPublishedCareerPathSlugs()
  return slugs.map((slug) => ({ slug }))
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  const careerPath = await getCareerPathBySlug(slug)

  if (!careerPath) {
    return buildMetadata({ title: 'דף לא נמצא' })
  }

  return buildMetadata({
    title:       careerPath.title,
    description: careerPath.shortDescription ?? undefined,
    path:        `/career/${slug}`,
    openGraph:   {},
  })
}

export default async function CareerPage({ params }: Props) {
  const { slug } = await params
  const careerPath = await getCareerPathWithCourses(slug)

  if (!careerPath) notFound()

  if (careerPath.pageType === 'intent') {
    return <IntentPageContent careerPath={careerPath} />
  }

  return <CareerPageContent careerPath={careerPath} />
}
