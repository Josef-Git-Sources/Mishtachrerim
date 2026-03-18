/**
 * Career editorial comparison page — /career/editorial/[slug]
 *
 * Static editorial pages comparing two career paths in prose.
 * Targets comparison-intent search queries (e.g. "QA tester vs data analyst").
 *
 * Content is fully static — no database queries.
 * Three editorials are served: qa-tester-vs-data-analyst, qa-tester-vs-full-stack-developer,
 * data-analyst-vs-full-stack-developer
 *
 * ISR: revalidated hourly, matching the convention across all public pages.
 */
import { notFound } from 'next/navigation'
import type { Metadata } from 'next'
import { buildMetadata } from '@/lib/seo/metadata'
import { getCareerEditorial, getAllCareerEditorialSlugs } from '@/lib/content/career-editorials'

export const revalidate = 3600

interface Props {
  params: Promise<{ slug: string }>
}

export function generateStaticParams() {
  return getAllCareerEditorialSlugs().map((slug) => ({ slug }))
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params
  const editorial = getCareerEditorial(slug)

  if (!editorial) {
    return buildMetadata({ title: 'דף לא נמצא' })
  }

  return buildMetadata({
    title:       editorial.title,
    description: editorial.description,
    path:        `/career/editorial/${slug}`,
    openGraph:   {},
  })
}

export default async function CareerEditorialPage({ params }: Props) {
  const { slug } = await params
  const editorial = getCareerEditorial(slug)

  if (!editorial) notFound()

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
