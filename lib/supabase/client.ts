/**
 * Browser-side Supabase client.
 *
 * Use this in Client Components ('use client') only.
 * For Server Components, API routes, and middleware use lib/supabase/server.ts.
 *
 * Call createBrowserClient() once per component tree (or use a singleton pattern
 * with React context if needed across many components).
 */
import { createBrowserClient as createSupabaseBrowserClient } from '@supabase/ssr'
import { clientEnv } from '@/lib/env/client'

export function createBrowserClient() {
  return createSupabaseBrowserClient(
    clientEnv.NEXT_PUBLIC_SUPABASE_URL,
    clientEnv.NEXT_PUBLIC_SUPABASE_ANON_KEY
  )
}
