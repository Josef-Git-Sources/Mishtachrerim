/**
 * Data-access: courses.
 *
 * Server-side only. Do not import in Client Components.
 *
 * Used by:
 *   - app/(public)/courses/[slug]/page.tsx (generateStaticParams, generateMetadata, page)
 *
 * All queries filter to is_published = true.
 * Unpublished courses are never exposed through these functions.
 */
import { createPublicClient } from '@/lib/supabase/public-client'
import type { Course, CourseWithCareers } from '@/types'

// ─── Local DB row type ─────────────────────────────────────────────────────────

type DbCourse = {
  id: string
  slug: string
  title: string
  provider_name: string | null
  description: string | null
  duration: string | null
  learning_mode: string | null
  price_range: string | null
  deposit_eligible: boolean
  editorial_rating: number | null
  provider_url: string | null
  is_published: boolean
  created_at: string
  updated_at: string
}

// ─── Mapper ───────────────────────────────────────────────────────────────────

function mapCourse(row: DbCourse): Course {
  return {
    id:              row.id,
    slug:            row.slug,
    title:           row.title,
    providerName:    row.provider_name,
    description:     row.description,
    duration:        row.duration,
    learningMode:    row.learning_mode as Course['learningMode'],
    priceRange:      row.price_range,
    depositEligible: row.deposit_eligible,
    editorialRating: row.editorial_rating,
    providerUrl:     row.provider_url,
    isPublished:     row.is_published,
    createdAt:       row.created_at,
    updatedAt:       row.updated_at,
  }
}

// ─── Queries ──────────────────────────────────────────────────────────────────

/**
 * Returns all published courses ordered alphabetically by title.
 * Used by the courses hub page (/courses).
 */
export async function getPublishedCourses(): Promise<Course[]> {
  const supabase = createPublicClient()

  const { data, error } = await supabase
    .from('courses')
    .select(`
      id, slug, title, provider_name, description,
      duration, learning_mode, price_range,
      deposit_eligible, editorial_rating, provider_url,
      is_published, created_at, updated_at
    `)
    .eq('is_published', true)
    .order('title', { ascending: true })

  if (error) {
    throw new Error(`Failed to load published courses: ${error.message}`)
  }

  return (data ?? []).map((row) => mapCourse(row as unknown as DbCourse))
}

/**
 * Returns slugs for all published courses.
 * Used by generateStaticParams — returns [] safely when nothing is published.
 */
export async function getPublishedCourseSlugs(): Promise<string[]> {
  const supabase = createPublicClient()

  const { data, error } = await supabase
    .from('courses')
    .select('slug')
    .eq('is_published', true)
    .order('slug', { ascending: true })

  if (error) {
    throw new Error(`Failed to load course slugs: ${error.message}`)
  }

  return (data ?? []).map((row: { slug: string }) => row.slug)
}

/**
 * Returns a single published course by slug.
 * Returns null for unknown or unpublished slugs.
 * Used by generateMetadata — lightweight, no joins.
 */
export async function getCourseBySlug(slug: string): Promise<Course | null> {
  const supabase = createPublicClient()

  const { data, error } = await supabase
    .from('courses')
    .select(`
      id, slug, title, provider_name, description,
      duration, learning_mode, price_range,
      deposit_eligible, editorial_rating, provider_url,
      is_published, created_at, updated_at
    `)
    .eq('slug', slug)
    .eq('is_published', true)
    .single()

  if (error) {
    if (error.code === 'PGRST116') return null
    throw new Error(`Failed to load course: ${error.message}`)
  }

  return mapCourse(data as unknown as DbCourse)
}

// ─── Junction row type for course → career paths ──────────────────────────────

type DbCareerPathRow = {
  career_paths: {
    id: string
    slug: string
    title: string
    is_published: boolean
  } | null
}

/**
 * Returns a single published course by slug for full page rendering,
 * including its associated published career paths via the junction table.
 * Returns null for unknown or unpublished slugs.
 */
export async function getCoursePageBySlug(slug: string): Promise<CourseWithCareers | null> {
  const course = await getCourseBySlug(slug)
  if (!course) return null

  const supabase = createPublicClient()

  // Query associated career paths via the junction table.
  // is_published is filtered in JS — Supabase JS does not support filtering
  // on nested relation columns in a standard .select() call (mirrors career-paths.ts pattern).
  const { data: junctionData, error } = await supabase
    .from('course_career_paths')
    .select(`
      career_paths (
        id, slug, title,
        is_published
      )
    `)
    .eq('course_id', course.id)

  if (error) {
    throw new Error(`Failed to load career paths for course: ${error.message}`)
  }

  const careerPaths = ((junctionData ?? []) as unknown as DbCareerPathRow[])
    .map((row) => row.career_paths)
    .filter((cp): cp is NonNullable<typeof cp> => cp !== null && cp.is_published === true)
    .map((cp) => ({ id: cp.id, slug: cp.slug, title: cp.title }))

  return { ...course, careerPaths }
}
