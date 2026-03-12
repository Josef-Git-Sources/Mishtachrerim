/**
 * Data-access: quiz questions with answers.
 *
 * Server-side only. Do not import in Client Components.
 *
 * Returns questions filtered by quiz mode:
 *   quick → q1–q5
 *   deep  → q1–q10
 *
 * Source of truth for question content: /docs/quiz/QUIZ_QUESTION_BANK.md
 */
import { createServerClient } from '@/lib/supabase/server'
import type { QuizMode, QuizQuestionWithAnswers } from '@/types'

const QUICK_KEYS = ['q1', 'q2', 'q3', 'q4', 'q5']
const DEEP_KEYS  = ['q1', 'q2', 'q3', 'q4', 'q5', 'q6', 'q7', 'q8', 'q9', 'q10']

// Local types matching the DB column names returned by Supabase
type DbAnswer = {
  id: string
  question_id: string
  answer_key: string
  answer_text: string
  display_order: number
}

type DbQuestion = {
  id: string
  question_key: string
  question_text: string
  display_order: number
  is_active: boolean
  quiz_answers: DbAnswer[]
}

export async function getQuizQuestions(mode: QuizMode): Promise<QuizQuestionWithAnswers[]> {
  const supabase = await createServerClient()
  const keys = mode === 'quick' ? QUICK_KEYS : DEEP_KEYS

  const { data, error } = await supabase
    .from('quiz_questions')
    .select(`
      id,
      question_key,
      question_text,
      display_order,
      is_active,
      quiz_answers (
        id,
        question_id,
        answer_key,
        answer_text,
        display_order
      )
    `)
    .eq('is_active', true)
    .in('question_key', keys)
    .order('display_order', { ascending: true })

  if (error) {
    throw new Error(`Failed to load quiz questions: ${error.message}`)
  }

  return (data as unknown as DbQuestion[]).map((row) => ({
    id:           row.id,
    questionKey:  row.question_key,
    questionText: row.question_text,
    displayOrder: row.display_order,
    isActive:     row.is_active,
    answers: (row.quiz_answers ?? [])
      .sort((a, b) => a.display_order - b.display_order)
      .map((a) => ({
        id:           a.id,
        questionId:   a.question_id,
        answerKey:    a.answer_key,
        answerText:   a.answer_text,
        displayOrder: a.display_order,
      })),
  }))
}
