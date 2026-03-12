/**
 * Register page — /register
 *
 * Optional separate registration flow.
 * Depending on Supabase Auth UI configuration, a single /login page
 * may handle both login and registration. This page exists as a
 * separate route in case a distinct flow is needed.
 *
 * noIndex: registration pages must not be indexed.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'הרשמה',
  noIndex: true,
})

export default function RegisterPage() {
  return (
    <section>
      <h1>הרשמה</h1>
      <p>placeholder — registration flow will be added in Phase 2</p>
    </section>
  )
}
