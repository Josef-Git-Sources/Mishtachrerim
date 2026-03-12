/**
 * Generates canonical URLs for page metadata.
 *
 * Canonical URLs must always be absolute.
 * They are used in <link rel="canonical"> tags and Next.js Metadata.alternates.
 *
 * All canonical URLs route through siteUrl() so the domain
 * is controlled entirely by NEXT_PUBLIC_SITE_URL.
 */
import { siteUrl } from './site-url'

/**
 * Returns the canonical absolute URL for a given path.
 *
 * @param path - A relative path, e.g. '/guides/what-to-do-after-army'
 * @returns Canonical absolute URL
 */
export function canonicalUrl(path: string): string {
  return siteUrl(path)
}
