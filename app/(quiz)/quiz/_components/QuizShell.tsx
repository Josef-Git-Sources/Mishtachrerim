'use client'

/**
 * QuizShell — interactive quiz runner.
 *
 * Receives pre-loaded questions from the QuizPage Server Component.
 * Manages question progression, answer collection, and submission.
 *
 * On submission: POST /api/quiz/submit → navigate to /results/[id].
 */
import { useState } from 'react'
import { useRouter } from 'next/navigation'
import type { QuizQuestionWithAnswers, QuizMode, SubmittedAnswer } from '@/types'

interface Props {
  questions: QuizQuestionWithAnswers[]
  mode: QuizMode
}

type Status = 'quiz' | 'submitting' | 'error'

export function QuizShell({ questions, mode }: Props) {
  const router = useRouter()
  const [currentIndex, setCurrentIndex] = useState(0)
  const [answers, setAnswers] = useState<SubmittedAnswer[]>([])
  const [status, setStatus] = useState<Status>('quiz')
  const [errorMessage, setErrorMessage] = useState<string | null>(null)

  const currentQuestion = questions[currentIndex]
  const isLastQuestion = currentIndex === questions.length - 1

  function handleBack() {
    setCurrentIndex((i) => i - 1)
    setAnswers((prev) => prev.slice(0, -1))
  }

  async function handleAnswer(answerId: string) {
    const updatedAnswers: SubmittedAnswer[] = [
      ...answers,
      { questionId: currentQuestion.id, answerId },
    ]
    setAnswers(updatedAnswers)

    if (!isLastQuestion) {
      setCurrentIndex((i) => i + 1)
      return
    }

    // All questions answered — submit
    setStatus('submitting')
    try {
      const response = await fetch('/api/quiz/submit', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ mode, answers: updatedAnswers }),
      })

      if (!response.ok) {
        const data = await response.json().catch(() => ({}))
        throw new Error((data as { error?: string }).error ?? `Server error ${response.status}`)
      }

      const { resultId } = await response.json() as { resultId: string }
      router.push(`/results/${resultId}`)
    } catch (err) {
      setStatus('error')
      setErrorMessage(err instanceof Error ? err.message : 'אירעה שגיאה. נסה שוב.')
    }
  }

  if (status === 'submitting') {
    return (
      <section className="quiz-status">
        <p>מחשב תוצאות...</p>
      </section>
    )
  }

  if (status === 'error') {
    return (
      <section className="quiz-status">
        <p>{errorMessage}</p>
        <button className="quiz-retry-btn" onClick={() => { setStatus('quiz'); setErrorMessage(null) }}>
          נסה שוב
        </button>
      </section>
    )
  }

  if (questions.length === 0) {
    return (
      <section className="quiz-status">
        <p>לא נמצאו שאלות. נסה שוב מאוחר יותר.</p>
      </section>
    )
  }

  return (
    <section>
      <p className="quiz-progress">{currentIndex + 1} / {questions.length}</p>
      {currentIndex > 0 && (
        <button className="quiz-back-btn" onClick={handleBack}>← חזרה</button>
      )}
      <h2 className="quiz-question-text">{currentQuestion.questionText}</h2>
      <ul className="quiz-answers">
        {currentQuestion.answers.map((answer) => (
          <li key={answer.id}>
            <button onClick={() => handleAnswer(answer.id)}>
              {answer.answerText}
            </button>
          </li>
        ))}
      </ul>
    </section>
  )
}
