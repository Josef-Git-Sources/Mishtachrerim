/**
 * Profile / Account settings — /dashboard/profile
 *
 * Lightweight account settings page.
 * Displays auth-related preferences and basic profile information.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'הפרופיל שלי',
  noIndex: true,
})

export default function DashboardProfilePage() {
  return (
    <section>
      <h1>הפרופיל שלי</h1>
      <p>placeholder — profile settings will be added in Phase 2</p>
    </section>
  )
}
