/**
 * Sitemap — /sitemap.xml
 *
 * Generated via the Next.js App Router built-in sitemap convention.
 * No additional dependencies required.
 *
 * Coverage:
 *   Static routes    — /, /career, /courses, /guides
 *   Dynamic routes   — /career/[slug]  from published career paths (DB)
 *                      /courses/[slug] from published courses (DB)
 *                      /guides/[slug]  from static guide content
 *
 * URL base is controlled by NEXT_PUBLIC_SITE_URL via siteUrl().
 * Excluded: /admin, /auth, /api, /quiz (not public indexable pages).
 */
import type { MetadataRoute } from 'next'
import { siteUrl } from '@/lib/seo/site-url'
import { getPublishedCareerPathSlugs } from '@/lib/data/career-paths'
import { getPublishedCourseSlugs } from '@/lib/data/courses'
import { getAllGuideSlugs } from '@/lib/content/guides'

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const [careerSlugs, courseSlugs] = await Promise.all([
    getPublishedCareerPathSlugs(),
    getPublishedCourseSlugs(),
  ])

  const guideSlugs = getAllGuideSlugs()

  const staticRoutes: MetadataRoute.Sitemap = [
    {
      url:             siteUrl('/'),
      changeFrequency: 'weekly',
      priority:        1.0,
    },
    {
      url:             siteUrl('/career'),
      changeFrequency: 'weekly',
      priority:        0.7,
    },
    {
      url:             siteUrl('/courses'),
      changeFrequency: 'weekly',
      priority:        0.7,
    },
    {
      url:             siteUrl('/guides'),
      changeFrequency: 'weekly',
      priority:        0.7,
    },
  ]

  const careerRoutes: MetadataRoute.Sitemap = careerSlugs.map((slug) => ({
    url:             siteUrl(`/career/${slug}`),
    changeFrequency: 'weekly',
    priority:        0.9,
  }))

  const courseRoutes: MetadataRoute.Sitemap = courseSlugs.map((slug) => ({
    url:             siteUrl(`/courses/${slug}`),
    changeFrequency: 'weekly',
    priority:        0.7,
  }))

  const guideRoutes: MetadataRoute.Sitemap = guideSlugs.map((slug) => ({
    url:             siteUrl(`/guides/${slug}`),
    changeFrequency: 'monthly',
    priority:        0.8,
  }))

  return [
    ...staticRoutes,
    ...careerRoutes,
    ...courseRoutes,
    ...guideRoutes,
  ]
}
