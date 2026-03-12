/**
 * Data-access: quiz results.
 *
 * Server-side only. Do not import in Client Components.
 *
 * Shared by:
 *   - app/api/results/[id]/route.ts (API route)
 *   - app/(quiz)/results/[id]/page.tsx (Server Component — direct call, no internal fetch)
 *
 * Results are accessible by ID without authentication.
 * Anonymous quiz results have user_id = null.
 */
import { createServerClient } from '@/lib/supabase/server'
import type { QuizMode, QuizResultWithCareers } from '@/types'

// Local types matching DB column names
type DbCareerPath = {
  id: string
  slug: string
  title: string
}

type DbResultCareer = {
  score: number
  rank: number
  career_paths: DbCareerPath
}

type DbQuizResult = {
  id: string
  user_id: string | null
  quiz_type: string
  quiz_version: number
  created_at: string
  quiz_result_careers: DbResultCareer[]
}

export async function getQuizResult(id: string): Promise<QuizResultWithCareers | null> {
  const supabase = await createServerClient()

  const { data, error } = await supabase
    .from('quiz_results')
    .select(`
      id,
      user_id,
      quiz_type,
      quiz_version,
      created_at,
      quiz_result_careers (
        score,
        rank,
        career_paths (
          id,
          slug,
          title
        )
      )
    `)
    .eq('id', id)
    .single()

  if (error) {
    // PGRST116 = no rows found
    if (error.code === 'PGRST116') return null
    throw new Error(`Failed to load quiz result: ${error.message}`)
  }

  const row = data as unknown as DbQuizResult

  return {
    id:          row.id,
    userId:      row.user_id,
    quizType:    row.quiz_type as QuizMode,
    quizVersion: row.quiz_version,
    createdAt:   row.created_at,
    careers: (row.quiz_result_careers ?? [])
      .sort((a, b) => a.rank - b.rank)
      .map((rc) => ({
        careerPathSlug: rc.career_paths.slug,
        careerPathName: rc.career_paths.title,
        score:          rc.score,
        rank:           rc.rank,
      })),
  }
}
