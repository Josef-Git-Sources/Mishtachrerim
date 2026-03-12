/**
 * Results fetch endpoint — GET /api/results/[id]
 *
 * Returns a stored quiz result and its top-3 ranked career matches.
 * No authentication required — results are publicly accessible by ID.
 *
 * Delegates to lib/data/results.ts (shared with the /results/[id] page).
 */
import { NextRequest, NextResponse } from 'next/server'
import { getQuizResult } from '@/lib/data/results'

export async function GET(
  _request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params
  const result = await getQuizResult(id)

  if (!result) {
    return NextResponse.json({ error: 'Result not found' }, { status: 404 })
  }

  return NextResponse.json(result)
}
