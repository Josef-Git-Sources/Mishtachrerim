/**
 * Static content for guide pages (/guides/[slug]).
 *
 * Guides are SEO entry points that capture broad informational queries and
 * lead users into the career exploration funnel (quiz → career page → course page).
 * Content is fully static — no database queries.
 *
 * Used by:
 *   - app/(public)/guides/[slug]/page.tsx (generateStaticParams, generateMetadata, page)
 */

// ─── Types ────────────────────────────────────────────────────────────────────

export interface CareerLink {
  /** Displayed text */
  title: string
  /** Slug used to build /career/[slug] */
  slug: string
  /** One-line context description rendered after the link */
  description: string
}

export interface GuideSection {
  /** Rendered as <h2> */
  heading: string
  /** Each string renders as a separate <p> */
  paragraphs: string[]
  /** When present, renders as a <ul> of internal career links */
  careers?: CareerLink[]
}

export interface Guide {
  slug: string
  /** Used as the <title> tag via buildMetadata() */
  title: string
  /** Used as the meta description */
  description: string
  /** Rendered as <h1> — should match the search query closely */
  h1: string
  /** First paragraph — must answer the query directly */
  intro: string
  sections: GuideSection[]
}

// ─── Guide data ───────────────────────────────────────────────────────────────

const GUIDES: Record<string, Guide> = {
  'what-to-do-after-army': {
    slug: 'what-to-do-after-army',
    title: 'מה עושים אחרי הצבא – מדריך לבחירת קריירה לחיילים משוחררים',
    description:
      'מדריך מעשי לחיילים משוחררים — אילו מקצועות אפשר ללמוד מהר, כמה מרוויחים ואיך מתחילים.',
    h1: 'מה עושים אחרי הצבא?',
    intro:
      'אחרי הצבא יש ארבע אפשרויות עיקריות: נסיעה לחו״ל, לימודים אקדמיים, כניסה ישירה לשוק העבודה, או הכשרה מקצועית קצרה. רוב מי שרוצים להתחיל לעבוד מהר בוחרים בהכשרה מקצועית — 3 עד 12 חודשים, מוכוונת לשוק העבודה, וחלקה זכאית למענק שחרור.',
    sections: [
      {
        heading: 'מה האפשרויות אחרי השחרור?',
        paragraphs: [
          'נסיעה לחו״ל, לימודים אקדמיים, כניסה ישירה לשוק העבודה, או הכשרה מקצועית קצרה — אלו האפשרויות הנפוצות. לכל אחת יש יתרונות, ובחירה נכונה תלויה במה שמעניין אתכם ובמצב הכלכלי שלכם.',
          'הכשרות מקצועיות קצרות הפכו לאחת הדרכים הפופולריות ביותר בקרב משוחררים. רובן נמשכות 3–12 חודשים, מתמקדות בכניסה לשוק העבודה, וחלקן זכאיות למענק שחרור מהמדינה.',
        ],
      },
      {
        heading: 'מקצועות שאפשר ללמוד תוך 3–12 חודשים',
        paragraphs: [
          'אלו מקצועות שמשוחררים רבים בחרו בהם — הכשרה קצרה, שכר טוב, וביקוש גבוה בשוק:',
        ],
        careers: [
          {
            title: 'בודק תוכנה (QA)',
            slug: 'qa-tester',
            description: 'הכשרה של 3 חודשים, כניסה קלה לשוק העבודה הטכנולוגי',
          },
          {
            title: 'אנליסט נתונים',
            slug: 'data-analyst',
            description: 'מתאים מאוד לאנשים שאוהבים מספרים ופתרון בעיות',
          },
          {
            title: 'מעצב UX/UI',
            slug: 'ux-ui-designer',
            description: 'מקצוע יצירתי עם ביקוש גבוה בכל חברות ההייטק',
          },
          {
            title: 'מקדם דיגיטלי',
            slug: 'digital-marketing',
            description: 'מקצוע גמיש שפותח אפשרויות לשכיר ולעצמאי כאחד',
          },
          {
            title: 'מנהל ecommerce',
            slug: 'ecommerce-manager',
            description: 'ניהול חנויות ומכירות דיגיטליות — תחום בצמיחה מהירה',
          },
        ],
      },
      {
        heading: 'איך בוחרים מקצוע שמתאים לכם?',
        paragraphs: [
          'שאלו את עצמכם: מה עניין אתכם בצבא? אנשים שנהנו מעבודה טכנית עם מערכות — כדאי לבדוק QA או ניתוח נתונים. אנשים שנהנו מניהול, תקשורת ועבודה מול אנשים — שיווק דיגיטלי או ecommerce עשויים להתאים.',
          'שימו לב גם לזמן שיש לכם ולתקציב: קורסים קצרים (3 חודשים) דורשים פחות השקעה ראשונית, אבל הכשרות ארוכות יותר — כמו ניתוח נתונים — מובילות לשכר גבוה יותר בטווח הארוך.',
        ],
      },
    ],
  },

  'how-to-enter-high-tech-without-degree': {
    slug: 'how-to-enter-high-tech-without-degree',
    title: 'איך להיכנס להייטק בלי תואר – מדריך למשוחררי צבא',
    description:
      'גלו אילו מקצועות הייטק לא דורשים תואר אקדמי, כמה זמן לוקחת ההכשרה ואיך מתחילים.',
    h1: 'איך להיכנס להייטק בלי תואר',
    intro:
      'להייטק אפשר להיכנס בלי תואר — וזה הרבה יותר נפוץ ממה שחושבים. חברות ישראליות רבות מגייסות בוגרי בוטקמפים ואנשים ממסלולי הסבה, ומסתכלות קודם כל על יכולות מעשיות ותיק עבודות. המפתח הוא לבחור את המקצוע הנכון ואת ההכשרה הנכונה.',
    sections: [
      {
        heading: 'מה מעסיקים בהייטק באמת בודקים — בלי תואר',
        paragraphs: [
          'בתחומים כמו QA, עיצוב UX/UI וניתוח נתונים, מעסיקים בודקים קודם כל תיק עבודות: פרויקטים שעשיתם, קוד שכתבתם, ממשקים שעיצבתם — לא נייר מהאוניברסיטה. בוטקמפ עם פרויקט גמר אמיתי לרוב מספיק כדי להגיע לראיון.',
          'חברות רבות גם מציעות מבחני כניסה מעשיים שמחליפים לגמרי את הדרישה לתואר. כוח האדם בהייטק הישראלי אינו מספיק לביקוש — וזו הסיבה שמעסיקים פתחו את השער לבוגרי הכשרות ממוקדות.',
        ],
      },
      {
        heading: 'מקצועות הייטק שלא דורשים תואר אקדמי',
        paragraphs: [
          'אלו המקצועות שבהם הכניסה הכי נגישה דרך הכשרה ממוקדת:',
        ],
        careers: [
          {
            title: 'בודק תוכנה (QA)',
            slug: 'qa-tester',
            description: 'נקודת כניסה קלסית להייטק — 3 חודשי הכשרה, ביקוש גבוה',
          },
          {
            title: 'אנליסט נתונים',
            slug: 'data-analyst',
            description: 'ניתוח נתונים — אחד התחומים הכי חמים כיום בהייטק',
          },
          {
            title: 'מעצב UX/UI',
            slug: 'ux-ui-designer',
            description: 'תפקיד יצירתי בלב ההייטק — פורטפוליו חשוב יותר מתואר',
          },
          {
            title: 'מקדם דיגיטלי',
            slug: 'digital-marketing',
            description: 'שיווק דיגיטלי — הייטק-משיק עם ביקוש גבוה בחברות מכל הגדלים',
          },
          {
            title: 'מנהל ecommerce',
            slug: 'ecommerce-manager',
            description: 'ניהול מסחר דיגיטלי — צומח מהר, מקובל גם בלי תואר',
          },
        ],
      },
      {
        heading: 'בוטקמפ, קורס קצר, או תואר — מה נכון לכם?',
        paragraphs: [
          'קורס קצר (3–6 חודשים) מתאים למקצועות כמו QA, שיווק דיגיטלי ועיצוב UX/UI. בוטקמפ (6–12 חודשים) מתאים לניתוח נתונים — הכשרה אינטנסיבית יותר שמובילה לשכר גבוה יותר.',
          'תואר אקדמי שווה לשקול רק אם אתם מכוונים לתפקידי R&D בכירים בטווח של 5+ שנים. לרוב תפקידי ההייטק הנגישים לבוגרי צבא — הוא אינו תנאי כניסה.',
        ],
      },
    ],
  },

  'high-paying-jobs-without-degree': {
    slug: 'high-paying-jobs-without-degree',
    title: 'מקצועות עם שכר גבוה בלי תואר – מדריך לבוגרי צבא',
    description:
      'אילו מקצועות משלמים שכר גבוה בלי תואר? כמה מרוויחים ברמת כניסה וכמה זמן לוקחת ההכשרה.',
    h1: 'מקצועות עם שכר גבוה בלי תואר',
    intro:
      'לא צריך תואר כדי להרוויח טוב. בתחום הטכנולוגיה ומשיק הטכנולוגיה, שכר של 10,000–20,000 ₪ בחודש נגיש אחרי הכשרה של 3–12 חודשים בלבד. הסוד הוא לבחור מקצוע עם ביקוש אמיתי בשוק.',
    sections: [
      {
        heading: 'למה מקצועות טכנולוגיים משלמים טוב?',
        paragraphs: [
          'ביקוש גבוה לצד היצע נמוך יוצרים שכר גבוה. תעשיית ההייטק וסביבתה מחפשות כל הזמן עובדים מקצועיים — ומחסור כרוני מוביל לשכר תחרותי, גם ברמת הכניסה.',
          'בניגוד לתחומים מסורתיים שבהם שנות ניסיון נבנות לאט, בהייטק קידום מהיר הוא הנורמה. שנה-שנתיים אחרי הכניסה לשוק, שכר של 15,000–20,000 ₪ הוא ריאלי לגמרי.',
        ],
      },
      {
        heading: 'המקצועות עם השכר הגבוה ביותר ברמת כניסה',
        paragraphs: [
          'אלו המקצועות שמשלבים שכר גבוה עם סף כניסה נגיש:',
        ],
        careers: [
          {
            title: 'בודק תוכנה (QA)',
            slug: 'qa-tester',
            description: 'שכר כניסה 9,000–14,000 ₪ — הדרך הקלה ביותר להיכנס להייטק',
          },
          {
            title: 'אנליסט נתונים',
            slug: 'data-analyst',
            description: 'שכר כניסה 12,000–20,000 ₪ — אחד המקצועות המבוקשים ביותר',
          },
          {
            title: 'מעצב UX/UI',
            slug: 'ux-ui-designer',
            description: 'שכר כניסה 10,000–18,000 ₪ — ביקוש גובר בכל חברה דיגיטלית',
          },
          {
            title: 'מקדם דיגיטלי',
            slug: 'digital-marketing',
            description: 'שכר כניסה 8,000–15,000 ₪ — פוטנציאל גבוה לעצמאות ולסוכנויות',
          },
          {
            title: 'מנהל ecommerce',
            slug: 'ecommerce-manager',
            description: 'שכר כניסה 10,000–18,000 ₪ — תחום בצמיחה מואצת',
          },
        ],
      },
      {
        heading: 'כמה זמן לוקח להגיע לשכר הזה?',
        paragraphs: [
          'זמן ההכשרה משתנה בין המקצועות: QA ושיווק דיגיטלי — 3 חודשים. UX/UI וניתוח נתונים — 6 חודשים. פיתוח Full Stack — 12 חודשים ויותר.',
          'לרוב המקצועות ברשימה, חצי שנה של הכשרה ממוקדת מספיקה להתחיל לחפש עבודה. השכר הגבוה יגיע אחרי שנה-שנתיים של ניסיון בתפקיד.',
        ],
      },
    ],
  },
}

// ─── Accessors ────────────────────────────────────────────────────────────────

export function getGuide(slug: string): Guide | undefined {
  return GUIDES[slug]
}

export function getAllGuideSlugs(): string[] {
  return Object.keys(GUIDES)
}
