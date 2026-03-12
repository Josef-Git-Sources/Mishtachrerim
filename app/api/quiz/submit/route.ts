/**
 * Quiz submission endpoint — POST /api/quiz/submit
 *
 * Receives a completed quiz, calculates career recommendations,
 * persists the result, and returns the result ID for redirect to /results/[id].
 *
 * Phase 2 implementation steps:
 *   1. Parse and validate submitted answers
 *   2. Load score mappings from the database (quiz_answer_scores)
 *   3. Call calculateResults() from lib/matching-engine.ts
 *   4. Insert a record into quiz_results
 *   5. Insert ranked careers into quiz_result_careers
 *   6. Return { resultId } — client navigates to /results/[resultId]
 *
 * Anonymous users: user_id is null in quiz_results.
 * Authenticated users: attach user_id from the session.
 *
 * Phase 1: stub — returns 501.
 */
import { NextResponse } from 'next/server'

export async function POST() {
  // TODO Phase 2: implement quiz submission
  // See lib/matching-engine.ts for the scoring function signature
  return NextResponse.json(
    { error: 'Quiz submission not yet implemented' },
    { status: 501 }
  )
}
