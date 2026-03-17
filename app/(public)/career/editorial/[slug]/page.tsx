/**
 * Career editorial comparison page — /career/editorial/[slug]
 *
 * Static editorial pages comparing two career paths in prose.
 * Targets comparison-intent search queries (e.g. "QA tester vs data analyst").
 *
 * Content is fully static — no database queries.
 * One editorial is served: qa-tester-vs-data-analyst
 *
 * ISR: revalidated hourly, matching the convention across all public pages.
 */
import { notFound } from 'next/navigation'
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import { getCareerEditorial, getAllCareerEditorialSlugs } from '@/lib/content/career-editorials'
import { CareerEditorialContent } from '../_components/CareerEditorialContent'

export const revalidate = 3600

interface Props {
  params: Promise<{ slug: string }>
}

export function generateStaticParams() {
  return getAllCareerEditorialSlugs().map((slug) => ({ slug }))
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  const editorial = getCareerEditorial(slug)

  if (!editorial) {
    return buildMetadata({ title: 'דף לא נמצא' })
  }

  return buildMetadata({
    title:       editorial.title,
    description: editorial.description,
    path:        `/career/editorial/${slug}`,
    openGraph:   {},
  })
}

export default async function CareerEditorialPage({ params }: Props) {
  const { slug } = await params
  const editorial = getCareerEditorial(slug)

  if (!editorial) notFound()

  return <CareerEditorialContent editorial={editorial} />
}
