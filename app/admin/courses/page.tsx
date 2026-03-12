/**
 * Admin — Manage courses — /admin/courses
 *
 * Create, edit, publish, and archive courses.
 * Manages course-to-career-path associations (many-to-many).
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({ title: 'Admin — Courses', noIndex: true })

export default function AdminCoursesPage() {
  return (
    <section>
      <h1>Admin — Courses</h1>
      <p>placeholder</p>
    </section>
  )
}
