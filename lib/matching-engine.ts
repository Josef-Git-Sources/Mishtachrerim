/**
 * Career matching engine.
 *
 * Converts quiz answers into ranked career recommendations.
 * This is the core of the Decision Engine described in the product docs.
 *
 * Architecture rules:
 *   - Runs server-side only. Never import in Client Components.
 *   - Pure function: no database calls, no network requests, no side effects.
 *   - Score data is loaded by the caller (API route) and passed in.
 *   - Deterministic: identical answers always produce identical output.
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
 */
import type { SubmittedAnswer, QuizAnswerScore, RankedCareer } from '@/types'

/**
 * Fixed tie-break priority order (MATCHING_ENGINE_LOGIC.md §8).
 * Applied when two careers have equal scores. Lower number = higher priority.
 */
const TIE_BREAK_PRIORITY: Record<string, number> = {
  'full-stack-developer': 1,
  'data-analyst':         2,
  'qa-tester':            3,
  'ux-ui-designer':       4,
  'digital-marketing':    5,
  'it-support':           6,
  'network-technician':   7,
  'project-management':   8,
  'graphic-design':       9,
  'ecommerce-manager':    10,
}

/**
 * Calculates ranked career recommendations from a set of quiz answers.
 *
 * Only careers with a positive accumulated score are returned.
 * The caller is responsible for truncating to top 3 before persistence.
 *
 * @param answers      - The submitted question/answer pairs from the quiz.
 * @param answerScores - Score data loaded from quiz_answer_scores, enriched
 *                       with career slug and name via join with career_paths.
 * @returns Ranked array of careers with positive scores, sorted descending.
 *          Ties resolved by fixed priority order (MATCHING_ENGINE_LOGIC.md §8).
 */
export function calculateResults(
  answers: SubmittedAnswer[],
  answerScores: QuizAnswerScore[]
): RankedCareer[] {
  // Build lookup: answerId → score entries
  const scoreLookup = new Map<string, QuizAnswerScore[]>()
  for (const entry of answerScores) {
    const bucket = scoreLookup.get(entry.answerId) ?? []
    bucket.push(entry)
    scoreLookup.set(entry.answerId, bucket)
  }

  // Accumulate scores per career path
  const accumulated = new Map<string, { slug: string; name: string; score: number }>()

  for (const answer of answers) {
    const mappings = scoreLookup.get(answer.answerId) ?? []
    for (const mapping of mappings) {
      const current = accumulated.get(mapping.careerPathId) ?? {
        slug:  mapping.careerPathSlug,
        name:  mapping.careerPathName,
        score: 0,
      }
      current.score += mapping.scoreValue
      accumulated.set(mapping.careerPathId, current)
    }
  }

  // Keep only careers with a positive score (per product decision)
  const ranked = Array.from(accumulated.values()).filter((c) => c.score > 0)

  // Sort: score descending, then fixed tie-break priority ascending
  ranked.sort((a, b) => {
    if (b.score !== a.score) return b.score - a.score
    const pa = TIE_BREAK_PRIORITY[a.slug] ?? 999
    const pb = TIE_BREAK_PRIORITY[b.slug] ?? 999
    return pa - pb
  })

  return ranked.map((career, index) => ({
    careerPathSlug: career.slug,
    careerPathName: career.name,
    score:          career.score,
    rank:           index + 1,
  }))
}
