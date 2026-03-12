/**
 * Shared utility functions.
 *
 * SEO-related utilities (URLs, metadata, canonical) belong in lib/seo/ — not here.
 * Environment variables belong in lib/env/ — not here.
 */

/**
 * Converts a URL slug into a human-readable title.
 * Example: 'qa-tester' → 'Qa Tester'
 * Used as a fallback before real data is loaded.
 */
export function slugToTitle(slug: string): string {
  return slug
    .split('-')
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ')
}

/**
 * Formats an ISO date string for display in the Hebrew locale.
 */
export function formatDate(dateString: string): string {
  return new Date(dateString).toLocaleDateString('he-IL')
}

/**
 * Returns a truncated string with an ellipsis if it exceeds maxLength.
 */
export function truncate(text: string, maxLength: number): string {
  if (text.length <= maxLength) return text
  return `${text.slice(0, maxLength).trimEnd()}…`
}
