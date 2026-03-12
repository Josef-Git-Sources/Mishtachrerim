/**
 * User and session types.
 *
 * Users are created via Supabase Auth.
 * The public.users table mirrors auth.users with additional profile fields.
 *
 * See: /docs/data/DATA_MODEL.md
 */

export type AuthProvider = 'google' | 'email'

export interface AppUser {
  id: string
  email: string
  authProvider: AuthProvider | null
  createdAt: string
  lastLoginAt: string | null
}

export interface UserSession {
  user: AppUser
  accessToken: string
}
