/**
 * CareerEditorialContent — renders a career editorial comparison page.
 *
 * Editorial pages compare two career paths in prose. No tables. No winner.
 * Sections render in the order defined in the editorial data.
 * The closing section links to both compared career pages and to /quiz.
 */
import type { CareerEditorial } from '@/lib/content/career-editorials'

interface Props {
  editorial: CareerEditorial
}

export function CareerEditorialContent({ editorial }: Props) {
  const [careerA, careerB] = editorial.careers

  return (
    <article>
      <h1>{editorial.h1}</h1>
      <p>{editorial.intro}</p>

      {editorial.sections.map((section, i) => (
        <section key={i}>
          <h2>{section.heading}</h2>
          {section.paragraphs.map((para, j) => (
            <p key={j}>{para}</p>
          ))}
        </section>
      ))}

      <section>
        <h2>הצעדים הבאים</h2>
        <p>
          {'קראו עוד על כל אחד מהמסלולים: '}
          <a href={`/career/${careerA.slug}`}>{careerA.title}</a>
          {' · '}
          <a href={`/career/${careerB.slug}`}>{careerB.title}</a>
        </p>
        <p>
          עדיין לא בטוחים מה מתאים לכם?{' '}
          <a href="/quiz">ענו על כמה שאלות קצרות וקבלו המלצה מותאמת אישית</a>
        </p>
      </section>
    </article>
  )
}
