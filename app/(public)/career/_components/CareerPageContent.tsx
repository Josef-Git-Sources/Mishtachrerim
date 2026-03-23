/**
 * CareerPageContent — renders a full career path page (page_type = 'career').
 *
 * Structural and minimal. Renders all available fields null-safely.
 * Courses section shows a list or a clean empty state.
 * No CTA modules, lead forms, or conversion blocks in Phase 3.
 */
import type { CareerPathWithCourses } from '@/types'

interface Props {
  careerPath: CareerPathWithCourses
}

export function CareerPageContent({ careerPath }: Props) {
  const {
    title,
    shortDescription,
    longDescription,
    salaryRange,
    trainingTime,
    difficultyLevel,
    exampleRoles,
    courses,
  } = careerPath

  const hasFacts = salaryRange || trainingTime || difficultyLevel

  return (
    <article>
      <h1>{title} — מה זה, כמה מרוויחים ואיך מתחילים</h1>

      {shortDescription && <p>{shortDescription}</p>}
      {longDescription && longDescription.split('\n\n').map((para, i) => (
        <p key={i}>{para}</p>
      ))}

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

      <section>
        <h2>קורסים רלוונטיים</h2>
        {courses.length === 0 ? (
          <p>אין קורסים משויכים עדיין.</p>
        ) : (
          <ul>
            {courses.map((course) => (
              <li key={course.id} dir="ltr">
                <a href={`/courses/${course.slug}`}>{course.title}</a>
                {course.providerName && <span> — {course.providerName}</span>}
                {course.duration && <span> · {course.duration}</span>}
                {course.learningMode && <span> · {course.learningMode}</span>}
                {course.priceRange && <span> · {course.priceRange}</span>}
              </li>
            ))}
          </ul>
        )}
      </section>

    </article>
  )
}
