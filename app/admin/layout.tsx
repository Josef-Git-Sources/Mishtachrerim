/**
 * Admin layout — admin role only.
 *
 * Authorization: checks for a valid session AND admin role.
 * This is a SEPARATE authorization domain from the dashboard layout.
 * These two layouts must never share an auth guard or be combined.
 *
 *   (dashboard)/layout.tsx  → checks: is the user authenticated?
 *   admin/layout.tsx        → checks: is the user authenticated AND an admin?
 *
 * Role enforcement is delegated to isAdminUser() in lib/auth/roles.ts.
 * The implementation of that function is a Phase 2 task.
 * In Phase 1, isAdminUser always returns false, making /admin inaccessible.
 *
 * To enable admin access in Phase 2:
 *   1. Implement isAdminUser() in lib/auth/roles.ts
 *   2. Do NOT change this layout — the architectural boundary stays here
 */
import { redirect } from 'next/navigation'
import { createServerClient } from '@/lib/supabase/server'
import { isAdminUser } from '@/lib/auth/roles'
import type { AppUser } from '@/types'

export default async function AdminLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createServerClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  const appUser: AppUser = {
    id: user.id,
    email: user.email ?? '',
    authProvider: null,
    createdAt: '',
    lastLoginAt: null,
  }

  if (!isAdminUser(appUser)) {
    // Not authorized — redirect to home, not to login
    // (user is authenticated but does not have the admin role)
    redirect('/')
  }

  return <>{children}</>
}
