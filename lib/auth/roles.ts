/**
 * Authorization role helpers.
 *
 * This module is the single location for role-based access logic.
 * Route guards (admin layout, future API middleware) call these functions
 * rather than embedding authorization logic directly.
 *
 * Phase 1: isAdminUser returns false for all users.
 * The architectural boundary is established so no refactoring is needed
 * when real role enforcement is introduced in Phase 2.
 *
 * Phase 2 implementation options (choose one):
 *   - Add a `role` column to public.users and check it here
 *   - Use Supabase custom JWT claims set via a database function
 *   - Maintain a separate admin_users table
 *
 * Do not hardcode email addresses or any user-specific values here.
 */
import type { AppUser } from '@/types'

/**
 * Returns true if the user has admin privileges.
 *
 * Phase 1 stub — always returns false.
 * Replace the body of this function when role enforcement is implemented.
 * The function signature must not change.
 */
export function isAdminUser(_user: AppUser): boolean {
  // TODO Phase 2: implement role check
  // Example: return _user.role === 'admin'
  return false
}
