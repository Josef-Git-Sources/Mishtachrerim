/**
 * Admin — Manage guides — /admin/guides
 *
 * Create, edit, publish, and archive SEO guides.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({ title: 'Admin — Guides', noIndex: true })

export default function AdminGuidesPage() {
  return (
    <section>
      <h1>Admin — Guides</h1>
      <p>placeholder</p>
    </section>
  )
}
