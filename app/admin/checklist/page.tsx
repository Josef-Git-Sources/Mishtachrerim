/**
 * Admin — Manage checklist items — /admin/checklist
 *
 * Create, edit, publish, and reorder checklist_items.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({ title: 'Admin — Checklist', noIndex: true })

export default function AdminChecklistPage() {
  return (
    <section>
      <h1>Admin — Checklist</h1>
      <p>placeholder</p>
    </section>
  )
}
