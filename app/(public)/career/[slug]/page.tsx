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
import type { CareerPath } from '@/types'
import { buildMetadata } from '@/lib/seo/metadata'
import {
  getPublishedCareerPathSlugs,
  getCareerPathBySlug,
  getCareerPathWithCourses,
} from '@/lib/data/career-paths'
import { CareerPageContent } from '../_components/CareerPageContent'
import { IntentPageContent } from '../_components/IntentPageContent'

// ─── Intent page content guardrail ────────────────────────────────────────────
// An intent page must have at least one substantive field beyond title and CTAs.
// Title and CTA links are always present and do not count toward this threshold.
// Failing pages fall back to notFound() — the same pattern used for missing slugs.

function hasMinimumIntentContent(cp: CareerPath): boolean {
  return !!(
    cp.shortDescription ||
    cp.longDescription  ||
    cp.salaryRange      ||
    cp.trainingTime     ||
    cp.difficultyLevel  ||
    cp.exampleRoles
  )
}

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

  const isCareer = careerPath.pageType === 'career'

  const title = isCareer
    ? `${careerPath.title || 'מסלול קריירה'} — שכר, זמן הכשרה והאם זה מתאים לכם`
    : careerPath.title || 'מידע על מסלול'

  const description = isCareer
    ? (careerPath.shortDescription || 'מידע על שכר, זמן הכשרה ותנאי הכניסה למסלול')
    : (careerPath.shortDescription || 'תשובות ומידע על השאלה')

  return buildMetadata({
    title,
    description,
    path:      `/career/${slug}`,
    openGraph: {},
  })
}

export default async function CareerPage({ params }: Props) {
  const { slug } = await params
  const careerPath = await getCareerPathWithCourses(slug)

  if (!careerPath) notFound()

  if (careerPath.pageType === 'intent') {
    if (!hasMinimumIntentContent(careerPath)) notFound()
    return <IntentPageContent careerPath={careerPath} />
  }

  return (
    <>
      <CareerPageContent careerPath={careerPath} />
      <section className="cta-box">
        <h2>הצעד הבא</h2>
        <p>
          אם המסלול הזה מעניין אתכם,{' '}
          <a href="/quiz">השאלון הקצר שלנו</a>{' '}
          עוזר לבדוק אם הכיוון מתאים לכם.
        </p>
      </section>
    </>
  )
}
