/**
 * CoursePageContent — renders a minimal course detail page.
 *
 * Structural and minimal. Renders all approved Phase 4A fields null-safely.
 * Provider link only rendered when providerUrl is present.
 * No CTA modules, lead forms, or conversion blocks in Phase 4A.
 */
import type { CourseWithCareers } from '@/types'

interface Props {
  course: CourseWithCareers
}

export function CoursePageContent({ course }: Props) {
  const {
    title,
    description,
    providerName,
    duration,
    learningMode,
    priceRange,
    depositEligible,
    editorialRating,
    providerUrl,
  } = course

  const hasFacts = providerName || duration || learningMode || priceRange || editorialRating !== null

  return (
    <article>
      <h1>{title}</h1>

      {description && description.split('\n\n').map((para, i) => (
        <p key={i}>{para}</p>
      ))}

      {hasFacts && (
        <section>
          <h2>פרטי הקורס</h2>
          <dl>
            {providerName && (
              <>
                <dt>ספק</dt>
                <dd>{providerName}</dd>
              </>
            )}
            {duration && (
              <>
                <dt>משך</dt>
                <dd>{duration}</dd>
              </>
            )}
            {learningMode && (
              <>
                <dt>אופן לימוד</dt>
                <dd>{learningMode}</dd>
              </>
            )}
            {priceRange && (
              <>
                <dt>טווח מחיר</dt>
                <dd>{priceRange}</dd>
              </>
            )}
            {depositEligible && (
              <>
                <dt>מענק פיקדון</dt>
                <dd>הקורס מוכר לצורך מענק פיקדון</dd>
              </>
            )}
            {editorialRating !== null && editorialRating !== undefined && (
              <>
                <dt>דירוג עורכים</dt>
                <dd>{editorialRating} / 10</dd>
              </>
            )}
          </dl>
        </section>
      )}

      {providerUrl && (
        <section>
          <a href={providerUrl} target="_blank" rel="noopener noreferrer">
            לאתר הקורס
          </a>
        </section>
      )}

      <p>
        לא בטוחים שזה המסלול שמתאים לכם?{' '}
        <a href="/quiz">ענו על כמה שאלות קצרות</a>
      </p>
    </article>
  )
}
