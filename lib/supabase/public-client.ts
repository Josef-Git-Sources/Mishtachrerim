/**
 * Cookie-free Supabase client for public read-only data access.
 *
 * Use this in:
 *   - generateStaticParams() functions
 *   - generateMetadata() functions
 *   - sitemap() generation
 *   - Any server-side read of public (is_published = true) data
 *     that does not require a user session.
 *
 * Unlike createServerClient(), this client never calls cookies() and
 * is safe to use outside a request scope (build time, static generation).
 *
 * For authenticated or session-aware server operations use createServerClient()
 * from lib/supabase/server.ts instead.
 */
import { createClient } from '@supabase/supabase-js'
import { clientEnv } from '@/lib/env/client'

export function createPublicClient() {
  return createClient(
    clientEnv.NEXT_PUBLIC_SUPABASE_URL,
    clientEnv.NEXT_PUBLIC_SUPABASE_ANON_KEY
  )
}
