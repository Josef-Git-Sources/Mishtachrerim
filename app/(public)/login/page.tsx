/**
 * Login page — /login
 *
 * Entry point for authentication.
 * Supports Google OAuth and email login via Supabase Auth.
 * After successful login, Supabase redirects to /auth/callback.
 *
 * noIndex: login pages must not be indexed by search engines.
 *
 * Phase 1: placeholder.
 */
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'

export const metadata: Metadata = buildMetadata({
  title: 'התחברות',
  noIndex: true,
})

export default function LoginPage() {
  return (
    <section>
      <h1>התחברות</h1>
      <p>placeholder — Supabase Auth UI will be added in Phase 2</p>
    </section>
  )
}
