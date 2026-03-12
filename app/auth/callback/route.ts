/**
 * Supabase Auth callback — /auth/callback
 *
 * This route is required for both Google OAuth and magic link flows.
 * Supabase redirects the user here after external authentication.
 * The route exchanges the one-time code for a persistent session cookie.
 *
 * Configure the following in the Supabase project dashboard:
 *   Authentication → URL Configuration → Redirect URLs
 *   Add: <NEXT_PUBLIC_SITE_URL>/auth/callback
 *
 * The `next` query parameter can override the post-login destination.
 * Default redirect on success: /dashboard
 * Redirect on failure: /login?error=auth_callback_failed
 *
 * The redirect target uses the request origin (same domain the user is on),
 * not a hardcoded domain. This ensures staging and production both work
 * without code changes.
 */
import { NextResponse } from 'next/server'
import { createServerClient } from '@/lib/supabase/server'

export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url)
  const code = searchParams.get('code')
  const next = searchParams.get('next') ?? '/dashboard'

  if (code) {
    const supabase = await createServerClient()
    const { error } = await supabase.auth.exchangeCodeForSession(code)

    if (!error) {
      return NextResponse.redirect(`${origin}${next}`)
    }
  }

  return NextResponse.redirect(`${origin}/login?error=auth_callback_failed`)
}
