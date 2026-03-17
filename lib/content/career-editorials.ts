/**
 * Static content for career editorial comparison pages (/career/editorial/[slug]).
 *
 * Editorial pages compare two career paths to help undecided users identify
 * which direction fits them better. They are SEO entry points targeting
 * comparison-intent queries (e.g. "QA tester vs data analyst").
 *
 * Content is fully static — no database queries.
 *
 * Used by:
 *   - app/(public)/career/editorial/[slug]/page.tsx (generateStaticParams, generateMetadata, page)
 *
 * Authoring rules:
 *   - No comparison tables. No winner framing. No ranking.
 *   - All sections are prose paragraphs.
 *   - Links may only point to the two compared career pages and /quiz.
 *   - Each dimension section names both paths without declaring one superior.
 */

// ─── Types ────────────────────────────────────────────────────────────────────

export interface CareerEditorialSection {
  /** Rendered as <h2> */
  heading: string
  /** Each string renders as a separate <p> */
  paragraphs: string[]
}

export interface CareerEditorial {
  slug: string
  /** Used as the <title> tag via buildMetadata() */
  title: string
  /** Used as the meta description */
  description: string
  /** Rendered as <h1> */
  h1: string
  /** Opening paragraph — frames the comparison without declaring a winner */
  intro: string
  sections: CareerEditorialSection[]
  /** The two career path slugs compared in this editorial */
  careers: [{ slug: string; title: string }, { slug: string; title: string }]
}

// ─── Editorial data ───────────────────────────────────────────────────────────

const CAREER_EDITORIALS: Record<string, CareerEditorial> = {
  'qa-tester-vs-data-analyst': {
    slug: 'qa-tester-vs-data-analyst',
    title: 'QA Tester או Data Analyst — מה ההבדל ומה מתאים לך?',
    description:
      'השוואה בין QA Tester ל-Data Analyst: אופי העבודה, כישורים נדרשים, שכר ומה עשוי להתאים לך יותר.',
    h1: 'QA Tester או Data Analyst — מה ההבדל ומה מתאים לך?',
    intro:
      'שני המקצועות האלה מדורגים בין הנגישים ביותר לאנשים שנכנסים להייטק בלי ניסיון טכנולוגי קודם. ' +
      'שניהם דורשים הכשרה של כמה חודשים ולא תואר אקדמי. ' +
      'ובכל זאת, אופי העבודה שונה לגמרי — ומי שמחפש כיוון כדאי שיבין את ההבדל לפני שמתחייב להכשרה.',
    sections: [
      {
        heading: 'מה עושה QA Tester ביום-יום',
        paragraphs: [
          'QA Tester בוחן מוצרים דיגיטליים ומזהה תקלות לפני שהמוצר מגיע למשתמשים. ' +
            'חלק גדול מהעבודה הוא ביצוע בדיקות ידניות — הפעלת פיצ\'רים, בדיקת תרחישים שונים, ' +
            'ותיעוד מדויק של מה שמצאת ואיפה.',
          'בחברות רבות ה-QA עובד בצמוד לצוות הפיתוח, שותף לדיונים על דרישות, ומעביר משוב לפני ' +
            'ובמהלך כל מחזור פיתוח. עם הניסיון, חלק מהבודקים עוברים לאוטומציה — כתיבת סקריפטים ' +
            'שמריצים בדיקות אוטומטית, מה שדורש כבר ידע בסיסי בתכנות.',
        ],
      },
      {
        heading: 'מה עושה Data Analyst ביום-יום',
        paragraphs: [
          'Data Analyst עובד עם נתונים כדי לענות על שאלות עסקיות. ' +
            'זה יכול להיות ניתוח של נתוני משתמשים, מעקב אחר מדדי ביצועים, או בניית דשבורדים ' +
            'שמאפשרים לצוותים לקבל החלטות מבוססות-מידע.',
          'כלי הליבה הם SQL לשאילתות מסדי נתונים, Excel או Google Sheets לניתוח ראשוני, ' +
            'וכלי ויזואליזציה כמו Tableau או Power BI לבניית דוחות. ' +
            'בחברות גדולות יותר יש גם שימוש ב-Python לניתוחים מורכבים יותר.',
        ],
      },
      {
        heading: 'כישורים — איפה החפיפה ואיפה ההבדל',
        paragraphs: [
          'שני המקצועות דורשים קפדנות ויכולת לעבוד עם פרטים קטנים. ' +
            'בשניהם חשוב לתעד עבודה, לתקשר ממצאים בצורה ברורה, ולהבין מה ה"למה" מאחורי הנתון ' +
            'או התקלה שמצאת.',
          'ההבדל הגדול הוא בכיוון: QA מתחיל ממוצר קיים ובודק אם הוא עובד נכון. ' +
            'Data Analyst מתחיל משאלה פתוחה ומנסה לחלץ ממנה תשובה מתוך נתונים. ' +
            'אנשים שנמשכים לחקירה כמותית ולמציאת דפוסים בתוך מספרים לרוב מרגישים יותר נוח עם ' +
            'האנליזה. אנשים שמעדיפים לעבוד עם מוצר ממשי ולזהות בו בעיות לרוב נמשכים ל-QA.',
        ],
      },
      {
        heading: 'הכשרה ונגישות לשוק',
        paragraphs: [
          'שני המסלולים מכוסים על ידי הפיקדון הצבאי לגרסאותיהם הנפוצות. ' +
            'הכשרת QA נמשכת בדרך כלל שלושה עד ארבעה חודשים ומסתיימת בפרויקט גמר מעשי. ' +
            'הכשרת Data Analyst דומה באורכה אך כוללת יותר מתמטיקה ו-SQL שדורשים תרגול עצמאי בנוסף לשיעורים.',
          'הכניסה לשוק בשני המקצועות מאתגרת בשנה הראשונה — זה נכון לרוב תחומי ההייטק. ' +
            'עם זאת, QA ידני ידוע כנקודת כניסה טיפוסית יותר לג\'וניורים בישראל, ' +
            'ואילו Data Analyst דורש לרוב עוד כמה חודשים של תרגול עצמי עם פרויקטים אמיתיים לפני שהפורטפוליו מוכן.',
        ],
      },
      {
        heading: 'שכר והתפתחות לאורך זמן',
        paragraphs: [
          'שכר כניסה בשני המקצועות נע סביב אותם טווחים בישראל — ' +
            'בין 7,000 ל-10,000 שקלים ברוטו לג\'וניורים בשנות העבודה הראשונות.',
          'ההתפתחות שונה: QA עם ניסיון יכול לעבור לאוטומציה ולהגדיל משמעותית את השכר, ' +
            'אך זה דורש השקעה נוספת בלימוד תכנות. ' +
            'Data Analyst שצובר ניסיון יכול להתמחות בתחומים כמו business intelligence, ' +
            'ניהול נתונים, או לעבור לתפקידי Data Science. ' +
            'בשני המקצועות, הצמיחה תלויה בהמשך לימוד עצמי מעבר להכשרה הבסיסית.',
        ],
      },
      {
        heading: 'מה עשוי להתאים לך יותר',
        paragraphs: [
          'אם אתה אוהב לשבור דברים, למצוא את הפינה שלא בדקו, ולהרגיש שאתה מגן על המשתמשים מבעיות — ' +
            'QA הוא כיוון שכדאי לבחון.',
          'אם אתה אוהב לעבוד עם מספרים, לשאול שאלות על נתונים ולמצוא תשובות בתוך טבלאות — ' +
            'Data Analyst הוא הכיוון הטבעי יותר.',
          'זה לא כלל אבסולוטי. יש אנשים שמתחילים ב-QA ועוברים לאנליזה. ' +
            'יש אחרים שמגלים שהמוצר מעניין אותם יותר מהנתונים. ' +
            'מה שכן ברור: כדאי לבחור כיוון שמבוסס על אופי העבודה היום-יומי — ' +
            'לא רק על שכר עתידי, ולא רק על מה שנשמע מרשים.',
        ],
      },
    ],
    careers: [
      { slug: 'qa-tester',     title: 'QA Tester' },
      { slug: 'data-analyst',  title: 'Data Analyst' },
    ],
  },
}

// ─── Accessors ────────────────────────────────────────────────────────────────

export function getCareerEditorial(slug: string): CareerEditorial | undefined {
  return CAREER_EDITORIALS[slug]
}

export function getAllCareerEditorialSlugs(): string[] {
  return Object.keys(CAREER_EDITORIALS)
}
