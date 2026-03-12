/**
 * Next.js Edge Middleware.
 *
 * Responsibilities:
 *   1. Refresh Supabase session cookies on every request (via updateSession).
 *      This prevents sessions from expiring silently between page navigations.
 *
 * Route protection (redirect to /login or /) is handled in each layout:
 *   - app/(dashboard)/layout.tsx  — authenticated users only
 *   - app/admin/layout.tsx        — admin role only
 *
 * The matcher excludes static assets and Next.js internals to avoid
 * running session logic on every image or font request.
 */
import { type NextRequest } from 'next/server'
import { updateSession } from '@/lib/supabase/middleware'

export async function middleware(request: NextRequest) {
  return await updateSession(request)
}

export const config = {
  matcher: [
    /*
     * Match all paths except:
     *   - _next/static  (Next.js static files)
     *   - _next/image   (Next.js image optimization)
     *   - favicon.ico
     *   - Static file extensions (images, fonts, etc.)
     */
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp|ico|woff|woff2)$).*)',
  ],
}
