/**
 * Server-only environment variables.
 *
 * Import this module ONLY in:
 *   - Server Components
 *   - API route handlers
 *   - middleware.ts
 *
 * Never import in Client Components or any file with 'use client'.
 * These variables are never exposed to the browser.
 *
 * Add server-only variables here as they are introduced.
 * Each variable should use requireServerEnv() so misconfiguration
 * is caught at startup.
 */

function requireServerEnv(name: string): string {
  const value = process.env[name]
  if (!value) {
    throw new Error(
      `Missing required server environment variable: ${name}\n` +
        `Check .env.local.example for the full list of required variables.`
    )
  }
  return value
}

export const serverEnv = {
  /**
   * Supabase service role key.
   * Required for admin database operations that bypass Row Level Security.
   * Activate in Phase 2 when admin operations are implemented.
   *
   * To enable: uncomment the line below and add SUPABASE_SERVICE_ROLE_KEY to .env.local
   */
  // SUPABASE_SERVICE_ROLE_KEY: requireServerEnv('SUPABASE_SERVICE_ROLE_KEY'),
} as const

// Suppress unused import warning until the first server var is activated
void requireServerEnv
