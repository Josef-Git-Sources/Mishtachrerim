/**
 * GuidePageContent — renders a single SEO guide page.
 *
 * Structural and minimal. Sections render in the order defined in the guide data.
 * Quiz CTA is always rendered last — hardcoded because it is identical across
 * all guides and is part of the fixed funnel structure, not per-guide content.
 * No business logic. No Supabase. No client-side interactivity.
 */
import type { Guide } from '@/lib/content/guides'

interface Props {
  guide: Guide
}

export function GuidePageContent({ guide }: Props) {
  return (
    <article>
      <h1>{guide.h1}</h1>
      <p>{guide.intro}</p>

      {guide.sections.map((section, i) => (
        <section key={i}>
          <h2>{section.heading}</h2>
          {section.paragraphs.map((para, j) => (
            <p key={j}>{para}</p>
          ))}
          {section.careers && (
            <ul>
              {section.careers.map((career) => (
                <li key={career.slug}>
                  <a href={`/career/${career.slug}`}>{career.title}</a>
                  {' — '}{career.description}
                </li>
              ))}
            </ul>
          )}
        </section>
      ))}

      <section>
        <h2>לא בטוחים איזה מקצוע מתאים לכם?</h2>
        <p>ענו על כמה שאלות קצרות וקבלו המלצת קריירה מותאמת אישית — בחינם, ללא הרשמה.</p>
        <a href="/quiz">התחילו את השאלון</a>
      </section>
    </article>
  )
}
