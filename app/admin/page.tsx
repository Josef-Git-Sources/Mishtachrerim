/**
 * Admin dashboard — /admin
 *
 * Internal content management overview.
 * Not part of the public SEO structure.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'Admin',
  noIndex: true,
})

export default function AdminPage() {
  return (
    <section>
      <h1>Admin</h1>
      <p>placeholder — admin dashboard will be added in Phase 2</p>
    </section>
  )
}
