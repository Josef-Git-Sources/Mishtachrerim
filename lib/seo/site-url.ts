/**
 * Builds absolute URLs for use in canonical tags, sitemaps,
 * Open Graph metadata, and structured data.
 *
 * Uses NEXT_PUBLIC_SITE_URL from the env layer as the base domain.
 * This is the single source of truth for the site's domain.
 *
 * For internal navigation links, use relative paths instead.
 * Example: <Link href="/career/qa-tester"> — not siteUrl('/career/qa-tester')
 */
import { clientEnv } from '@/lib/env/client'

/**
 * Returns an absolute URL for the given path.
 *
 * @param path - A relative path, e.g. '/career/qa-tester'
 * @returns Absolute URL, e.g. 'https://hatzaad-haba.co.il/career/qa-tester'
 */
export function siteUrl(path: string = ''): string {
  const base = clientEnv.NEXT_PUBLIC_SITE_URL.replace(/\/$/, '')
  const normalizedPath = path.startsWith('/') ? path : `/${path}`
  return `${base}${normalizedPath}`
}
