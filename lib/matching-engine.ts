/**
 * Career matching engine.
 *
 * Converts quiz answers into ranked career recommendations.
 * This is the core of the Decision Engine described in the product docs.
 *
 * Architecture rules (must be maintained in Phase 2 implementation):
 *   - Runs server-side only. Never import in Client Components.
 *   - Pure function: no database calls, no network requests, no side effects.
 *   - Score mappings are loaded by the caller (API route) and passed in.
 *   - Must be deterministic: identical answers must always produce identical output.
 *   - Expected runtime: well below 50ms.
 *
 * Scoring source of truth:
 *   /docs/quiz/QUIZ_QUESTION_BANK.md
 *
 * Algorithm definition:
 *   /docs/quiz/MATCHING_ENGINE_LOGIC.md
 *
 * IMPORTANT: If MATCHING_ENGINE_LOGIC.md examples conflict with score values
 * in QUIZ_QUESTION_BANK.md, the question bank takes precedence.
 *
 * Phase 1: Stub only. Throws NotImplementedError.
 * Phase 2: Replace the body of calculateResults() with full scoring logic.
 *          Do not change the function signature.
 */
import type { SubmittedAnswer, ScoreMapping, RankedCareer } from '@/types'

/**
 * Calculates ranked career recommendations from a set of quiz answers.
 *
 * @param answers  - The submitted question/answer pairs from the quiz.
 * @param mappings - Score mappings loaded from the database before calling.
 *                   Each mapping associates one answer with one career and a point value.
 * @returns Ranked array of career matches, sorted by score descending.
 *          The UI displays only the top 3. The engine may return more for analytics.
 *
 * @throws Error if called before Phase 2 implementation is in place.
 */
export function calculateResults(
  _answers: SubmittedAnswer[],
  _mappings: ScoreMapping[]
): RankedCareer[] {
  // TODO Phase 2: implement scoring logic
  //
  // Algorithm steps (see MATCHING_ENGINE_LOGIC.md):
  //   1. Initialize all career scores to 0
  //   2. For each submitted answer, find matching score mappings
  //   3. Add score values to the corresponding career accumulators
  //   4. Sort careers by accumulated score descending
  //   5. Apply tie-break rules (see MATCHING_ENGINE_LOGIC.md §8)
  //   6. Return ranked results
  //
  // Tie-break fixed priority order (from MATCHING_ENGINE_LOGIC.md §8):
  //   Full Stack Developer → Data Analyst → QA Tester → UX/UI Designer →
  //   Digital Marketing → IT Support → Network Technician →
  //   Project Management → Graphic Design → Ecommerce Manager

  throw new Error(
    'calculateResults is not yet implemented. ' +
      'See /docs/quiz/MATCHING_ENGINE_LOGIC.md for the algorithm ' +
      'and /docs/quiz/QUIZ_QUESTION_BANK.md for score values.'
  )
}
