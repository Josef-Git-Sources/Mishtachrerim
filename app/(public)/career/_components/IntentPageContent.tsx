/**
 * IntentPageContent — renders a focused intent page (page_type = 'intent').
 *
 * Intent pages target specific search queries (e.g. "how to become a QA tester").
 * They are structurally lighter than career pages — no course list.
 *
 * Parent career linkage is resolved via PARENT_CAREER_MAP, a small explicit
 * static mapping keyed on intent page slug. No DB column required.
 * Any slug not present in the map falls back to the generic /career index.
 */
import type { CareerPath } from '@/types'

// ─── Parent career mapping ────────────────────────────────────────────────────
// Maps each intent page slug to its parent career page slug and display title.
// Update this map when new intent pages are added.

const PARENT_CAREER_MAP: Record<string, { slug: string; title: string }> = {
  // QA Tester
  'how-to-become-qa':           { slug: 'qa-tester',       title: 'QA Tester' },
  'qa-salary':                  { slug: 'qa-tester',       title: 'QA Tester' },
  'qa-without-experience':      { slug: 'qa-tester',       title: 'QA Tester' },
  'qa-learning-time':           { slug: 'qa-tester',       title: 'QA Tester' },
  // Data Analyst
  'how-to-become-data-analyst':        { slug: 'data-analyst', title: 'Data Analyst' },
  'data-analyst-salary':               { slug: 'data-analyst', title: 'Data Analyst' },
  'data-analyst-without-experience':   { slug: 'data-analyst', title: 'Data Analyst' },
  'data-analyst-learning-time':        { slug: 'data-analyst', title: 'Data Analyst' },
  // Digital Marketing
  'how-to-become-digital-marketer': { slug: 'digital-marketing', title: 'Digital Marketing' },
  'digital-marketing-salary':       { slug: 'digital-marketing', title: 'Digital Marketing' },
  // UX/UI Designer
  'how-to-become-ux-designer': { slug: 'ux-ui-designer', title: 'UX/UI Designer' },
  'ux-designer-salary':         { slug: 'ux-ui-designer', title: 'UX/UI Designer' },
}

// ─── Component ────────────────────────────────────────────────────────────────

interface Props {
  careerPath: CareerPath
}

export function IntentPageContent({ careerPath }: Props) {
  const {
    slug,
    title,
    shortDescription,
    longDescription,
    salaryRange,
    trainingTime,
    difficultyLevel,
    exampleRoles,
  } = careerPath

  const hasFacts = salaryRange || trainingTime || difficultyLevel
  const parent = PARENT_CAREER_MAP[slug]

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

      <p>
        {parent ? (
          <a href={`/career/${parent.slug}`}>למסלול {parent.title} המלא</a>
        ) : (
          <a href="/career">לכל מסלולי הקריירה</a>
        )}
      </p>
    </article>
  )
}

