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
        <ul>
          {courses.map((course) => (
            <li key={course.id}>
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
  )
}
