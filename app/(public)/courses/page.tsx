/**
 * Courses browse page — /courses
 *
 * Curated browse layer for training programs.
 * Secondary entry point — courses are primarily discovered via career pages.
 * This page remains small and curated, not a marketplace catalog.
 *
 * ISR: revalidated hourly. Newly published courses appear on first request
 * without requiring a full rebuild.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import { getPublishedCourses } from '@/lib/data/courses'
import { CoursesHubContent } from './_components/CoursesHubContent'

export const revalidate = 3600

export const metadata: Metadata = buildMetadata({
  title: 'קורסים',
  description: 'קורסים מומלצים למשתחררי צבא — הכשרות מקצועיות קצרות ומעשיות.',
  path: '/courses',
})

export default async function CoursesIndexPage() {
  const courses = await getPublishedCourses()
  return <CoursesHubContent courses={courses} />
}
