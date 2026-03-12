/**
 * Client-side environment variables.
 *
 * All variables here are NEXT_PUBLIC_ and safe to expose to the browser.
 * This is the only place in the codebase that reads process.env directly
 * for client-accessible variables.
 *
 * Throws at module initialization if any required variable is missing,
 * so misconfiguration fails loudly at startup rather than silently at runtime.
 */

function requireClientEnv(name: string): string {
  const value = process.env[name]
  if (!value) {
    throw new Error(
      `Missing required environment variable: ${name}\n` +
        `Check .env.local.example for the full list of required variables.`
    )
  }
  return value
}

export const clientEnv = {
  NEXT_PUBLIC_SUPABASE_URL: requireClientEnv('NEXT_PUBLIC_SUPABASE_URL'),
  NEXT_PUBLIC_SUPABASE_ANON_KEY: requireClientEnv('NEXT_PUBLIC_SUPABASE_ANON_KEY'),
  NEXT_PUBLIC_SITE_URL: requireClientEnv('NEXT_PUBLIC_SITE_URL'),
} as const
