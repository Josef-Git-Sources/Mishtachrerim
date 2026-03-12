/**
 * Builds Next.js Metadata objects for page types across the site.
 *
 * Page components call buildMetadata() rather than constructing
 * Metadata objects manually, so SEO logic stays in one place.
 *
 * Absolute URLs (canonical, OG) are generated via the canonical layer
 * which routes through NEXT_PUBLIC_SITE_URL — never hardcoded.
 */
import type { Metadata } from 'next'
import { canonicalUrl } from './canonical'

interface BuildMetadataParams {
  /** Page title — will be formatted as "Title | Mishtachrerim" by the root template */
  title: string
  /** Optional meta description */
  description?: string
  /** Relative path for canonical URL, e.g. '/career/qa-tester' */
  path?: string
  /**
   * Set to true for pages that must not be indexed.
   * Examples: /dashboard/*, /admin/*, /results/[id]
   */
  noIndex?: boolean
  /**
   * When provided, adds Open Graph meta tags.
   * Pass an empty object ({}) to inherit title/description from the page.
   * Absolute og:url is derived from `path` via the canonical layer.
   * OG image is not set in Phase 3 — add in a later phase.
   */
  openGraph?: {
    title?: string
    description?: string
  }
}

export function buildMetadata({
  title,
  description,
  path,
  noIndex = false,
  openGraph,
}: BuildMetadataParams): Metadata {
  const metadata: Metadata = {
    title,
    ...(description && { description }),
    robots: noIndex
      ? { index: false, follow: false }
      : { index: true, follow: true },
  }

  if (path) {
    metadata.alternates = {
      canonical: canonicalUrl(path),
    }
  }

  if (openGraph !== undefined) {
    const ogDescription = openGraph.description ?? description
    metadata.openGraph = {
      title: openGraph.title ?? title,
      ...(ogDescription && { description: ogDescription }),
      ...(path && { url: canonicalUrl(path) }),
    }
  }

  return metadata
}
