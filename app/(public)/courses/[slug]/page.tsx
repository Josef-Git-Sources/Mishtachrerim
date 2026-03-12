/**
 * Course detail page — /courses/[slug]
 *
 * SEO page and conversion page for a single training program.
 * Displays provider info, duration, mode, price, rating, and a CTA to the provider.
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
  // TODO: Query published course slugs from the database
  // const courses = await fetchPublishedCourses()
  // return courses.map((c) => ({ slug: c.slug }))
  return []
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  // TODO: Fetch course by slug and use real title/description
  return buildMetadata({
    title: slug,
    path: `/courses/${slug}`,
  })
}

export default async function CourseDetailPage({ params }: Props) {
  const { slug } = await params
  // TODO: Fetch course record by slug; join with career paths via course_career_paths
  return (
    <article>
      <h1>{slug}</h1>
      <p>placeholder — course content will be loaded from the database</p>
    </article>
  )
}
