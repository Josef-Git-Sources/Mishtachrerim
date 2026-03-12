/**
 * Quiz system types.
 *
 * The quiz supports two modes: quick (5 questions) and deep (10 questions).
 * Score data is sourced from /docs/quiz/QUIZ_QUESTION_BANK.md.
 * The matching algorithm is defined in /docs/quiz/MATCHING_ENGINE_LOGIC.md.
 *
 * IMPORTANT: QUIZ_QUESTION_BANK.md is the canonical source of truth for
 * score values. Any conflicting examples in MATCHING_ENGINE_LOGIC.md
 * do not override the question bank.
 *
 * See: /docs/quiz/QUIZ_SYSTEM_SPEC.md
 */

export type QuizMode = 'quick' | 'deep'

export interface QuizQuestion {
  id: string
  questionKey: string
  questionText: string
  displayOrder: number
  isActive: boolean
}

export interface QuizAnswer {
  id: string
  questionId: string
  answerKey: string
  answerText: string
  displayOrder: number
}

/** A question with its answer options, used by the questions API and quiz page. */
export interface QuizQuestionWithAnswers extends QuizQuestion {
  answers: QuizAnswer[]
}

/**
 * A score mapping from the quiz_answer_scores table.
 * Includes career path metadata (slug, name) loaded via join with career_paths.
 * Passed to calculateResults() in lib/matching-engine.ts.
 */
export interface QuizAnswerScore {
  answerId: string
  careerPathId: string
  careerPathSlug: string
  careerPathName: string
  scoreValue: number
}

/** A single answer submitted by the user during a quiz attempt. */
export interface SubmittedAnswer {
  questionId: string
  answerId: string
}

/** A career path ranked by the matching engine output. */
export interface RankedCareer {
  careerPathSlug: string
  careerPathName: string
  score: number
  rank: number
}

export interface QuizResult {
  id: string
  userId: string | null
  quizType: QuizMode
  quizVersion: number
  createdAt: string
}

export interface QuizResultCareer {
  id: string
  quizResultId: string
  careerPathId: string
  score: number
  rank: number
}

/** A quiz result with its top-3 ranked careers, returned by lib/data/results.ts. */
export interface QuizResultWithCareers extends QuizResult {
  careers: RankedCareer[]
}
