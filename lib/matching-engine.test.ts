/**
 * Unit tests for the career matching engine.
 *
 * These tests use synthetic data and do not require a database connection.
 *
 * Test coverage:
 *   - Correct score accumulation
 *   - Correct ranking order
 *   - Correct top-N slicing (caller's responsibility, but output ordering verified)
 *   - Tie-break priority: identical scores resolve by fixed priority
 *   - Only positive-score careers are returned
 *   - Answers with no matching score entry produce no output for that career
 *   - Deterministic: same input always same output
 */
import { calculateResults } from './matching-engine'
import type { SubmittedAnswer, QuizAnswerScore } from '@/types'

// Minimal synthetic careers used across tests
const CAREER_A = { careerPathId: 'id-full-stack', careerPathSlug: 'full-stack-developer', careerPathName: 'Full Stack Developer' }
const CAREER_B = { careerPathId: 'id-data',       careerPathSlug: 'data-analyst',         careerPathName: 'Data Analyst'         }
const CAREER_C = { careerPathId: 'id-qa',         careerPathSlug: 'qa-tester',            careerPathName: 'QA Tester'            }
const CAREER_D = { careerPathId: 'id-ux',         careerPathSlug: 'ux-ui-designer',       careerPathName: 'UX/UI Designer'       }

function makeScore(answerId: string, career: typeof CAREER_A, scoreValue: number): QuizAnswerScore {
  return { answerId, ...career, scoreValue }
}

// Synthetic answer scores for tests
const ANSWER_SCORES: QuizAnswerScore[] = [
  // answer-1a gives: full-stack +3, data-analyst +3
  makeScore('answer-1a', CAREER_A, 3),
  makeScore('answer-1a', CAREER_B, 3),
  // answer-2a gives: full-stack +3, qa-tester +2
  makeScore('answer-2a', CAREER_A, 3),
  makeScore('answer-2a', CAREER_C, 2),
  // answer-3b gives: qa-tester +3
  makeScore('answer-3b', CAREER_C, 3),
  // answer-4c gives: ux-ui-designer +2
  makeScore('answer-4c', CAREER_D, 2),
]

describe('calculateResults', () => {
  test('accumulates scores correctly and returns positive-score careers only', () => {
    const answers: SubmittedAnswer[] = [
      { questionId: 'q1', answerId: 'answer-1a' }, // full-stack +3, data +3
      { questionId: 'q2', answerId: 'answer-2a' }, // full-stack +3, qa +2
    ]
    const results = calculateResults(answers, ANSWER_SCORES)

    expect(results.find((r) => r.careerPathSlug === 'full-stack-developer')?.score).toBe(6)
    expect(results.find((r) => r.careerPathSlug === 'data-analyst')?.score).toBe(3)
    expect(results.find((r) => r.careerPathSlug === 'qa-tester')?.score).toBe(2)
    // ux-ui-designer had no matching answers → not in results
    expect(results.find((r) => r.careerPathSlug === 'ux-ui-designer')).toBeUndefined()
  })

  test('returns results sorted by score descending', () => {
    const answers: SubmittedAnswer[] = [
      { questionId: 'q1', answerId: 'answer-1a' }, // full-stack +3, data +3
      { questionId: 'q2', answerId: 'answer-2a' }, // full-stack +3, qa +2
    ]
    const results = calculateResults(answers, ANSWER_SCORES)

    expect(results[0].careerPathSlug).toBe('full-stack-developer') // score 6
    expect(results[1].careerPathSlug).toBe('data-analyst')         // score 3
    expect(results[2].careerPathSlug).toBe('qa-tester')            // score 2
  })

  test('assigns 1-based ranks', () => {
    const answers: SubmittedAnswer[] = [
      { questionId: 'q1', answerId: 'answer-1a' },
      { questionId: 'q2', answerId: 'answer-2a' },
    ]
    const results = calculateResults(answers, ANSWER_SCORES)

    expect(results[0].rank).toBe(1)
    expect(results[1].rank).toBe(2)
    expect(results[2].rank).toBe(3)
  })

  test('applies tie-break priority when scores are equal', () => {
    // answer-1a gives full-stack +3, data-analyst +3 — a tie
    const answers: SubmittedAnswer[] = [
      { questionId: 'q1', answerId: 'answer-1a' },
    ]
    const results = calculateResults(answers, ANSWER_SCORES)
    const slugs = results.map((r) => r.careerPathSlug)

    // full-stack-developer (priority 1) should beat data-analyst (priority 2)
    expect(slugs.indexOf('full-stack-developer')).toBeLessThan(slugs.indexOf('data-analyst'))
  })

  test('excludes zero-score careers', () => {
    // Only answer-4c is submitted, which scores ux-ui-designer +2
    const answers: SubmittedAnswer[] = [
      { questionId: 'q4', answerId: 'answer-4c' },
    ]
    const results = calculateResults(answers, ANSWER_SCORES)

    // Only ux-ui-designer should be present
    expect(results).toHaveLength(1)
    expect(results[0].careerPathSlug).toBe('ux-ui-designer')
    expect(results[0].score).toBe(2)
  })

  test('returns empty array when no answers match any score entry', () => {
    const answers: SubmittedAnswer[] = [
      { questionId: 'q99', answerId: 'unknown-answer-id' },
    ]
    const results = calculateResults(answers, ANSWER_SCORES)
    expect(results).toHaveLength(0)
  })

  test('is deterministic: same input produces same output', () => {
    const answers: SubmittedAnswer[] = [
      { questionId: 'q1', answerId: 'answer-1a' },
      { questionId: 'q2', answerId: 'answer-2a' },
      { questionId: 'q3', answerId: 'answer-3b' },
    ]
    const first  = calculateResults(answers, ANSWER_SCORES)
    const second = calculateResults(answers, ANSWER_SCORES)

    expect(first.map((r) => r.careerPathSlug)).toEqual(second.map((r) => r.careerPathSlug))
    expect(first.map((r) => r.score)).toEqual(second.map((r) => r.score))
  })

  test('handles empty answers array without error', () => {
    const results = calculateResults([], ANSWER_SCORES)
    expect(results).toHaveLength(0)
  })

  test('handles empty answerScores without error', () => {
    const answers: SubmittedAnswer[] = [
      { questionId: 'q1', answerId: 'answer-1a' },
    ]
    const results = calculateResults(answers, [])
    expect(results).toHaveLength(0)
  })
})
