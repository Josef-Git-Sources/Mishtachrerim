/**
 * Course types.
 *
 * Courses have a many-to-many relationship with career paths
 * via the course_career_paths junction table.
 * A single course can appear on multiple career path pages.
 *
 * See: /docs/data/DATA_MODEL.md
 */

export type LearningMode = 'online' | 'in-person' | 'hybrid'

export interface Course {
  id: string
  slug: string
  title: string
  providerName: string | null
  description: string | null
  duration: string | null
  learningMode: LearningMode | null
  priceRange: string | null
  depositEligible: boolean
  editorialRating: number | null
  providerUrl: string | null
  isPublished: boolean
  createdAt: string
  updatedAt: string
}

/** Course with its associated career paths — used on course detail pages. */
export interface CourseWithCareers extends Course {
  careerPaths: Array<{
    id: string
    slug: string
    title: string
  }>
}
