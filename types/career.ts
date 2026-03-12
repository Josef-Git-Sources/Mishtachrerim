/**
 * Career path and intent page types.
 *
 * Both career pages and intent pages are stored in the career_paths table
 * and served by the same /career/[slug] route.
 * The page_type field determines which layout variant is rendered.
 *
 * See: /docs/architecture/ROUTING_AND_PAGE_STRUCTURE.md
 * See: /docs/data/DATA_MODEL.md
 */

/** Distinguishes full career pages from intent (query-targeting) pages. */
export type PageType = 'career' | 'intent'

export interface CareerPath {
  id: string
  slug: string
  pageType: PageType
  title: string
  shortDescription: string | null
  longDescription: string | null
  salaryRange: string | null
  trainingTime: string | null
  difficultyLevel: string | null
  exampleRoles: string | null
  isPublished: boolean
  createdAt: string
  updatedAt: string
}
