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

// ─── Sibling intent mapping ───────────────────────────────────────────────────
// Maps each intent slug to up to 2 sibling intent pages in the same cluster.
// Purely static — no algorithms. Update when new intent pages are added.

const SIBLING_MAP: Record<string, Array<{ slug: string; title: string }>> = {
  // QA cluster
  'how-to-become-qa':      [{ slug: 'qa-salary',             title: 'כמה מרוויח QA Tester' },
                             { slug: 'qa-learning-time',      title: 'כמה זמן לוקח ללמוד QA' }],
  'qa-salary':             [{ slug: 'how-to-become-qa',       title: 'איך להיות QA Tester' },
                             { slug: 'qa-without-experience',  title: 'כניסה ל-QA בלי ניסיון' }],
  'qa-without-experience': [{ slug: 'how-to-become-qa',       title: 'איך להיות QA Tester' },
                             { slug: 'qa-salary',              title: 'כמה מרוויח QA Tester' }],
  'qa-learning-time':      [{ slug: 'how-to-become-qa',       title: 'איך להיות QA Tester' },
                             { slug: 'qa-without-experience',  title: 'כניסה ל-QA בלי ניסיון' }],
  // Data Analyst cluster
  'how-to-become-data-analyst':      [{ slug: 'data-analyst-salary',            title: 'כמה מרוויח Data Analyst' },
                                       { slug: 'data-analyst-learning-time',     title: 'כמה זמן לוקח ללמוד Data' }],
  'data-analyst-salary':             [{ slug: 'how-to-become-data-analyst',      title: 'איך להיות Data Analyst' },
                                       { slug: 'data-analyst-without-experience', title: 'כניסה לדאטה בלי ניסיון' }],
  'data-analyst-without-experience': [{ slug: 'how-to-become-data-analyst',      title: 'איך להיות Data Analyst' },
                                       { slug: 'data-analyst-salary',             title: 'כמה מרוויח Data Analyst' }],
  'data-analyst-learning-time':      [{ slug: 'how-to-become-data-analyst',      title: 'איך להיות Data Analyst' },
                                       { slug: 'data-analyst-without-experience', title: 'כניסה לדאטה בלי ניסיון' }],
  // Digital Marketing cluster
  'how-to-become-digital-marketer': [{ slug: 'digital-marketing-salary', title: 'שכר בשיווק דיגיטלי' }],
  'digital-marketing-salary':       [{ slug: 'how-to-become-digital-marketer', title: 'איך להיות מקדם דיגיטלי' }],
  // UX/UI cluster
  'how-to-become-ux-designer': [{ slug: 'ux-designer-salary', title: 'שכר מעצב UX/UI' }],
  'ux-designer-salary':        [{ slug: 'how-to-become-ux-designer', title: 'איך להיות מעצב UX/UI' }],
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
  const parent   = PARENT_CAREER_MAP[slug]
  const siblings = SIBLING_MAP[slug] ?? []

  return (
    <article>
      <h1>{title}</h1>

      {shortDescription && <p>{shortDescription}</p>}
      {longDescription && <p>{longDescription}</p>}

      {hasFacts && (
        <section>
          <h2>פרטים מרכזיים</h2>
          <dl className="facts-dl">
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

      {siblings.length > 0 && (
        <p>
          {'קראו גם: '}
          {siblings.map((s, i) => (
            <span key={s.slug}>
              {i > 0 && ' · '}
              <a href={`/career/${s.slug}`}>{s.title}</a>
            </span>
          ))}
        </p>
      )}

      <section className="cta-box">
        <p>
          {'הצעד הבא: '}
          {parent ? (
            <a href={`/career/${parent.slug}`}>למסלול {parent.title} המלא</a>
          ) : (
            <a href="/career">לכל מסלולי הקריירה</a>
          )}
        </p>
        <p>
          לא בטוחים שזה מתאים לכם?{' '}
          <a href="/quiz" className="btn-primary">ענו על כמה שאלות קצרות</a>
        </p>
      </section>
    </article>
  )
}
