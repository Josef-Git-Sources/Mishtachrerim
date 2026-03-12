/**
 * Results fetch endpoint — GET /api/results/[id]
 *
 * Fetches a stored quiz result and its top-3 ranked career matches.
 * Used by the /results/[id] page to load result data client-side,
 * or can be replaced by a direct server-side Supabase query in the page.
 *
 * Phase 2 implementation steps:
 *   1. Look up quiz_results by id
 *   2. Join quiz_result_careers with career_paths
 *   3. Return ranked careers with career metadata
 *
 * No authentication required — results are publicly accessible by ID.
 *
 * Phase 1: stub — returns 501.
 */
import { NextResponse } from 'next/server'

export async function GET() {
  // TODO Phase 2: implement result fetch
  return NextResponse.json(
    { error: 'Results fetch not yet implemented' },
    { status: 501 }
  )
}
