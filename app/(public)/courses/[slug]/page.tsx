/**
 * Course detail page — /courses/[slug]
 *
 * Minimal SEO page for a single training course.
 * Statically generated at build time from published course slugs.
 *
 * ISR: revalidated hourly. New published courses appear on first request
 * without requiring a full rebuild.
 */
import { notFound } from 'next/navigation'
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import {
  getPublishedCourseSlugs,
  getCourseBySlug,
  getCoursePageBySlug,
} from '@/lib/data/courses'
import type { CourseWithCareers } from '@/types'
import { CoursePageContent } from '../_components/CoursePageContent'

export const revalidate = 3600

interface Props {
  params: Promise<{ slug: string }>
}

export async function generateStaticParams() {
  const slugs = await getPublishedCourseSlugs()
  return slugs.map((slug) => ({ slug }))
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  const course = await getCourseBySlug(slug)

  if (!course) {
    return buildMetadata({ title: 'דף לא נמצא' })
  }

  return buildMetadata({
    title:       course.title,
    description: course.description ?? undefined,
    path:        `/courses/${slug}`,
    openGraph:   {},
  })
}

export default async function CourseDetailPage({ params }: Props) {
  const { slug } = await params
  const course: CourseWithCareers | null = await getCoursePageBySlug(slug)

  if (!course) notFound()

  return <CoursePageContent course={course} />
}
