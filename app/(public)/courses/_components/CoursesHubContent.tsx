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
      <p>
        כל מסלול קריירה כולל גם רשימת קורסים רלוונטיים — אם כבר בחרתם כיוון,{' '}
        כדאי לצאת מדף המסלול. כאן תמצאו את כל הקורסים במקום אחד.
      </p>

      {courses.length === 0 ? (
        <p>
          אין קורסים זמינים כרגע.{' '}
          <a href="/career">עיינו במסלולי הקריירה</a>{' '}
          בינתיים.
        </p>
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
          לא ברור לכם מאיזה כיוון להתחיל?{' '}
          <a href="/quiz">ענו על כמה שאלות קצרות</a>{' '}
          ותקבלו המלצת מסלול מותאמת — ומשם תוכלו לראות אילו קורסים רלוונטיים לכם.
        </p>
      </section>
    </section>
  )
}
