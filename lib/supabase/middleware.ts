/**
 * Supabase session refresh helper for Next.js middleware.
 *
 * Called from the root middleware.ts on every request to keep
 * the user's session cookie fresh. Without this, sessions expire
 * silently and authenticated users are logged out unexpectedly.
 *
 * This does NOT enforce authentication — it only refreshes the token.
 * Route protection is handled in each layout (dashboard, admin).
 */
import { createServerClient as createSupabaseServerClient } from '@supabase/ssr'
import { type NextRequest, NextResponse } from 'next/server'
import { clientEnv } from '@/lib/env/client'

export async function updateSession(request: NextRequest) {
  let supabaseResponse = NextResponse.next({ request })

  const supabase = createSupabaseServerClient(
    clientEnv.NEXT_PUBLIC_SUPABASE_URL,
    clientEnv.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll()
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) =>
            request.cookies.set(name, value)
          )
          supabaseResponse = NextResponse.next({ request })
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          )
        },
      },
    }
  )

  // Refresh the session. Do not remove — required to keep tokens valid.
  await supabase.auth.getUser()

  return supabaseResponse
}
