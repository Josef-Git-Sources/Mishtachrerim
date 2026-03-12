/**
 * Data-access: career paths and associated courses.
 *
 * Server-side only. Do not import in Client Components.
 *
 * Used by:
 *   - app/(public)/career/[slug]/page.tsx (generateStaticParams, generateMetadata, page)
 *
 * All queries filter to is_published = true.
 * Unpublished career paths are never exposed through these functions.
 */
import { createServerClient } from '@/lib/supabase/server'
import type { CareerPath, CareerCourse, CareerPathWithCourses } from '@/types'

// ─── Local DB row types ────────────────────────────────────────────────────────

type DbCareerPath = {
  id: string
  slug: string
  page_type: string
  title: string
  short_description: string | null
  long_description: string | null
  salary_range: string | null
  training_time: string | null
  difficulty_level: string | null
  example_roles: string | null
  is_published: boolean
  created_at: string
  updated_at: string
}

type DbCourseRow = {
  courses: {
    id: string
    slug: string
    title: string
    provider_name: string | null
    duration: string | null
    learning_mode: string | null
    price_range: string | null
    deposit_eligible: boolean
    editorial_rating: number | null
    is_published: boolean
  } | null
}

// ─── Mapper ───────────────────────────────────────────────────────────────────

function mapCareerPath(row: DbCareerPath): CareerPath {
  return {
    id:              row.id,
    slug:            row.slug,
    pageType:        row.page_type as CareerPath['pageType'],
    title:           row.title,
    shortDescription: row.short_description,
    longDescription:  row.long_description,
    salaryRange:     row.salary_range,
    trainingTime:    row.training_time,
    difficultyLevel: row.difficulty_level,
    exampleRoles:    row.example_roles,
    isPublished:     row.is_published,
    createdAt:       row.created_at,
    updatedAt:       row.updated_at,
  }
}

// ─── Queries ──────────────────────────────────────────────────────────────────

/**
 * Returns slugs for all published career paths (both page_type values).
 * Used by generateStaticParams — returns [] safely when nothing is published.
 */
export async function getPublishedCareerPathSlugs(): Promise<string[]> {
  const supabase = await createServerClient()

  const { data, error } = await supabase
    .from('career_paths')
    .select('slug')
    .eq('is_published', true)
    .order('slug', { ascending: true })

  if (error) {
    throw new Error(`Failed to load career path slugs: ${error.message}`)
  }

  return (data ?? []).map((row: { slug: string }) => row.slug)
}

/**
 * Returns a single published career path by slug.
 * Returns null for unknown or unpublished slugs.
 * Used by generateMetadata — lightweight, no course join.
 */
export async function getCareerPathBySlug(slug: string): Promise<CareerPath | null> {
  const supabase = await createServerClient()

  const { data, error } = await supabase
    .from('career_paths')
    .select(`
      id, slug, page_type, title,
      short_description, long_description,
      salary_range, training_time, difficulty_level, example_roles,
      is_published, created_at, updated_at
    `)
    .eq('slug', slug)
    .eq('is_published', true)
    .single()

  if (error) {
    if (error.code === 'PGRST116') return null
    throw new Error(`Failed to load career path: ${error.message}`)
  }

  return mapCareerPath(data as unknown as DbCareerPath)
}

/**
 * Returns a published career path with its associated published courses.
 * Courses are fetched via the course_career_paths junction table.
 * Returns null for unknown or unpublished slugs.
 * Used by the page component.
 */
export async function getCareerPathWithCourses(
  slug: string
): Promise<CareerPathWithCourses | null> {
  const supabase = await createServerClient()

  // Query 1: fetch the career path
  const { data: cpData, error: cpError } = await supabase
    .from('career_paths')
    .select(`
      id, slug, page_type, title,
      short_description, long_description,
      salary_range, training_time, difficulty_level, example_roles,
      is_published, created_at, updated_at
    `)
    .eq('slug', slug)
    .eq('is_published', true)
    .single()

  if (cpError) {
    if (cpError.code === 'PGRST116') return null
    throw new Error(`Failed to load career path: ${cpError.message}`)
  }

  const careerPath = mapCareerPath(cpData as unknown as DbCareerPath)

  // Query 2: fetch associated courses via junction table
  // is_published is selected and filtered in JS since Supabase JS does not
  // support filtering on nested relation columns in a standard .select() call.
  const { data: junctionData, error: coursesError } = await supabase
    .from('course_career_paths')
    .select(`
      courses (
        id, slug, title,
        provider_name, duration, learning_mode,
        price_range, deposit_eligible, editorial_rating,
        is_published
      )
    `)
    .eq('career_path_id', careerPath.id)

  if (coursesError) {
    throw new Error(`Failed to load courses for career path: ${coursesError.message}`)
  }

  const courses: CareerCourse[] = ((junctionData ?? []) as unknown as DbCourseRow[])
    .map((row) => row.courses)
    .filter((c): c is NonNullable<typeof c> => c !== null && c.is_published === true)
    .map((c) => ({
      id:              c.id,
      slug:            c.slug,
      title:           c.title,
      providerName:    c.provider_name,
      duration:        c.duration,
      learningMode:    c.learning_mode,
      priceRange:      c.price_range,
      depositEligible: c.deposit_eligible,
      editorialRating: c.editorial_rating,
    }))

  return { ...careerPath, courses }
}
