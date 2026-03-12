/**
 * Dashboard layout — authenticated users only.
 *
 * Authorization: checks for a valid Supabase session.
 * Any unauthenticated request is redirected to /login.
 *
 * This guard covers all routes in the (dashboard) group:
 *   /dashboard
 *   /dashboard/results
 *   /dashboard/courses
 *   /dashboard/checklist
 *   /dashboard/profile
 *
 * Important: this layout handles AUTHENTICATION (is the user logged in?).
 * Admin AUTHORIZATION (does the user have the admin role?) is a separate
 * concern handled exclusively in app/admin/layout.tsx.
 * These two layouts must never share an auth guard.
 */
import { redirect } from 'next/navigation'
import { createServerClient } from '@/lib/supabase/server'

export default async function DashboardLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createServerClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  return <>{children}</>
}
