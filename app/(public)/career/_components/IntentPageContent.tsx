/**
 * IntentPageContent — renders a focused intent page (page_type = 'intent').
 *
 * Intent pages target specific search queries (e.g. "how to become a QA tester").
 * They are structurally lighter than career pages — no course list.
 *
 * The link back to /career is a generic fallback because career_paths has no
 * parent_career_path_id FK. A direct parent link requires a schema change (Phase 4+).
 */
import type { CareerPath } from '@/types'

interface Props {
  careerPath: CareerPath
}

export function IntentPageContent({ careerPath }: Props) {
  const {
    title,
    shortDescription,
    longDescription,
    salaryRange,
    trainingTime,
    difficultyLevel,
    exampleRoles,
  } = careerPath

  const hasFacts = salaryRange || trainingTime || difficultyLevel

  return (
    <article>
      <h1>{title}</h1>

      {shortDescription && <p>{shortDescription}</p>}
      {longDescription && <p>{longDescription}</p>}

      {hasFacts && (
        <section>
          <h2>פרטים מרכזיים</h2>
          <dl>
            {salaryRange && (
              <>
                <dt>טווח שכר</dt>
                <dd>{salaryRange}</dd>
              </>
            )}
            {trainingTime && (
              <>
                <dt>זמן הכשרה</dt>
                <dd>{trainingTime}</dd>
              </>
            )}
            {difficultyLevel && (
              <>
                <dt>רמת קושי</dt>
                <dd>{difficultyLevel}</dd>
              </>
            )}
          </dl>
        </section>
      )}

      {exampleRoles && (
        <section>
          <h2>תפקידים לדוגמה</h2>
          <p>{exampleRoles}</p>
        </section>
      )}

      {/* Generic fallback — no parent_career_path_id FK in schema yet */}
      <p>
        <a href="/career">לכל מסלולי הקריירה</a>
      </p>
    </article>
  )
}
