/**
 * CoursesHubContent — renders the curated courses browse page (/courses).
 *
 * Structural and minimal. Lists all published courses with key facts.
 * Not a marketplace catalog — remains small and curated.
 * No CTA modules, lead forms, or conversion blocks in Phase 4B.
 */
import type { Course } from '@/types'

interface Props {
  courses: Course[]
}

export function CoursesHubContent({ courses }: Props) {
  return (
    <section>
      <h1>קורסים</h1>
      <p>קורסים מומלצים למשתחררי צבא — הכשרות מקצועיות קצרות ומעשיות.</p>

      {courses.length === 0 ? (
        <p>אין קורסים זמינים כרגע.</p>
      ) : (
        <ul className="card-list">
          {courses.map((course) => (
            <li key={course.id}>
              <a href={`/courses/${course.slug}`}>{course.title}</a>
              <span className="card-meta" dir="ltr">
                {[course.providerName, course.duration, course.learningMode, course.priceRange]
                  .filter(Boolean)
                  .join(' · ')}
              </span>
            </li>
          ))}
        </ul>
      )}

      <section className="cta-box">
        <p>
          לא בטוחים איזה קורס מתאים לכם?{' '}
          <a href="/quiz">השאלון שלנו</a>{' '}
          עוזר לבחור את הכיוון המקצועי הנכון.
        </p>
      </section>
    </section>
  )
}
