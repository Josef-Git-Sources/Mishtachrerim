/**
 * Server-side Supabase client.
 *
 * Use this in Server Components, layouts, and API route handlers.
 * This client reads and writes session cookies, making it cookie-aware
 * and suitable for authenticated server-side requests.
 *
 * The function is async because Next.js 15 cookies() returns a Promise.
 * Always await the result: const supabase = await createServerClient()
 */
import { createServerClient as createSupabaseServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import { clientEnv } from '@/lib/env/client'

export async function createServerClient() {
  const cookieStore = await cookies()

  return createSupabaseServerClient(
    clientEnv.NEXT_PUBLIC_SUPABASE_URL,
    clientEnv.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll()
        },
        setAll(cookiesToSet) {
          try {
            cookiesToSet.forEach(({ name, value, options }) =>
              cookieStore.set(name, value, options)
            )
          } catch {
            // setAll called from a Server Component where cookies are read-only.
            // Session refresh is handled by middleware.ts instead.
          }
        },
      },
    }
  )
}
