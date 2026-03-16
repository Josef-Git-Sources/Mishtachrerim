-- ============================================================
-- Migration: 006_intent_page_seed_5b
-- Project:   Mishtachrerim
-- Phase:     5B
--
-- Seeds 8 additional intent pages into career_paths.
-- Covers: QA, Data Analyst, Digital Marketing, UX/UI Designer
-- intent types: without-experience, learning-time, how-to, salary
--
-- Scope:
--   - page_type = 'intent' rows only
--   - No DDL changes
--   - No new tables
--   - No new columns
--
-- Parent career linkage is handled at render time by PARENT_CAREER_MAP
-- in IntentPageContent — not by a DB column.
--
-- Rerun-safe: ON CONFLICT (slug) DO UPDATE SET brings every field
-- to the approved values on each run.
-- ============================================================


-- ── qa-without-experience ────────────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'qa-without-experience',
  'intent',
  'האם אפשר להיכנס ל-QA ללא ניסיון?',
  'כניסה לבדיקות תוכנה ללא ניסיון קודם — האם זה אפשרי ובאילו תנאים.',
  'כן, כניסה ל-QA ללא ניסיון קודם בתכנות היא ריאלית. מרבית תפקידי Junior QA לא דורשים רקע טכני מעמיק. קורס ממוקד של 3–4 חודשים, פרויקטי תרגול אישיים, ויכולת לתעד באגים בצורה ברורה — אלו מחליפים ניסיון בפועל. מה שמחליף ניסיון: פורטפוליו קטן עם דוחות בדיקה, ידע בסיסי ב-SQL, והבנת מחזור חיי הפיתוח.',
  NULL,
  '3–4 חודשים',
  'בינוני',
  NULL,
  true
)
ON CONFLICT (slug) DO UPDATE SET
  page_type         = EXCLUDED.page_type,
  title             = EXCLUDED.title,
  short_description = EXCLUDED.short_description,
  long_description  = EXCLUDED.long_description,
  salary_range      = EXCLUDED.salary_range,
  training_time     = EXCLUDED.training_time,
  difficulty_level  = EXCLUDED.difficulty_level,
  example_roles     = EXCLUDED.example_roles,
  is_published      = EXCLUDED.is_published,
  updated_at        = NOW();


-- ── qa-learning-time ─────────────────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'qa-learning-time',
  'intent',
  'כמה זמן לוקח ללמוד QA?',
  'זמן הלמידה הריאלי לכניסה לתחום בדיקות התוכנה.',
  'הלמידה הבסיסית ל-QA ידנית נמשכת 3–4 חודשים. המעבר לאוטומציה מצריך עוד 3–6 חודשים של למידה עצמאית או קורס נוסף. הגורמים שמשפיעים על הזמן: רקע טכני קיים, עקביות הלמידה, ומידת ההתעמקות בכלים כמו Selenium ו-Postman. מי שמגיע עם ניסיון בפיתוח יכול לקצר את התהליך באופן משמעותי.',
  NULL,
  '3–4 חודשים',
  'בינוני',
  NULL,
  true
)
ON CONFLICT (slug) DO UPDATE SET
  page_type         = EXCLUDED.page_type,
  title             = EXCLUDED.title,
  short_description = EXCLUDED.short_description,
  long_description  = EXCLUDED.long_description,
  salary_range      = EXCLUDED.salary_range,
  training_time     = EXCLUDED.training_time,
  difficulty_level  = EXCLUDED.difficulty_level,
  example_roles     = EXCLUDED.example_roles,
  is_published      = EXCLUDED.is_published,
  updated_at        = NOW();


-- ── data-analyst-without-experience ──────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'data-analyst-without-experience',
  'intent',
  'האם אפשר להיכנס לאנליזת נתונים ללא ניסיון?',
  'כניסה לתחום ניתוח הנתונים ללא ניסיון קודם — באילו תנאים זה אפשרי.',
  'כן, כניסה כאנליסט נתונים ללא ניסיון קודם אפשרית, אך מאתגרת יותר מאשר ב-QA. מה שמחליף ניסיון: פרויקטי ניתוח בפורטפוליו (גם על נתונים פתוחים), ידע ב-SQL ו-Excel, והיכולת להציג תובנות עסקיות ברורות. תואר רלוונטי (כלכלה, סטטיסטיקה, מדעי המחשב) מסייע אך אינו הכרחי. הדרישה הנפוצה ביותר: פרויקטים שמדגימים חשיבה אנליטית — לא תעודות.',
  NULL,
  '6–12 חודשים',
  'גבוה',
  NULL,
  true
)
ON CONFLICT (slug) DO UPDATE SET
  page_type         = EXCLUDED.page_type,
  title             = EXCLUDED.title,
  short_description = EXCLUDED.short_description,
  long_description  = EXCLUDED.long_description,
  salary_range      = EXCLUDED.salary_range,
  training_time     = EXCLUDED.training_time,
  difficulty_level  = EXCLUDED.difficulty_level,
  example_roles     = EXCLUDED.example_roles,
  is_published      = EXCLUDED.is_published,
  updated_at        = NOW();


-- ── data-analyst-learning-time ───────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'data-analyst-learning-time',
  'intent',
  'כמה זמן לוקח ללמוד ניתוח נתונים?',
  'זמן הלמידה הריאלי לכניסה לתפקיד אנליסט נתונים.',
  'הלמידה הבסיסית — SQL, Excel ו-Python בסיסי — אורכת 4–6 חודשים. הכשרה מלאה הכוללת ויזואליזציה, סטטיסטיקה בסיסית, ובניית פורטפוליו לוקחת 8–12 חודשים. הגורמים שמשפיעים: ניסיון קודם עם נתונים (גם בלתי טכני), עמידות בפני למידת מתמטיקה, ומהירות בניית פרויקטים לתיק עבודות. מי עם רקע בכלכלה או סטטיסטיקה לרוב מתקדם מהר יותר.',
  NULL,
  '6–12 חודשים',
  'גבוה',
  NULL,
  true
)
ON CONFLICT (slug) DO UPDATE SET
  page_type         = EXCLUDED.page_type,
  title             = EXCLUDED.title,
  short_description = EXCLUDED.short_description,
  long_description  = EXCLUDED.long_description,
  salary_range      = EXCLUDED.salary_range,
  training_time     = EXCLUDED.training_time,
  difficulty_level  = EXCLUDED.difficulty_level,
  example_roles     = EXCLUDED.example_roles,
  is_published      = EXCLUDED.is_published,
  updated_at        = NOW();


-- ── how-to-become-digital-marketer ───────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'how-to-become-digital-marketer',
  'intent',
  'איך להיכנס לתחום השיווק הדיגיטלי',
  'מדריך כניסה לשיווק הדיגיטלי — כישורים, זמן הכשרה ואיך מתחילים לעבוד בתחום.',
  'שיווק דיגיטלי כולל ניהול קמפיינים ב-Google ו-Meta, SEO, ניתוח ביצועים, וניהול תוכן. הכישורים הבסיסיים לכניסה: הבנת פלטפורמות הפרסום הגדולות, ידע בניתוח נתוני קמפיין, וחשיבה יצירתית שמשולבת עם חשיבה ממוקדת תוצאות. הדרך המהירה ביותר: קורס מעשי של 3–4 חודשים, ניהול קמפיין בפועל (גם על תקציב קטן), ובניית פורטפוליו עם תוצאות מדידות.',
  '8,000–13,000 ₪ למתחילים',
  '3–4 חודשים',
  'נמוך',
  'מנהל קמפיינים, Performance Marketer, מנהל סושיאל מדיה, SEO Specialist',
  true
)
ON CONFLICT (slug) DO UPDATE SET
  page_type         = EXCLUDED.page_type,
  title             = EXCLUDED.title,
  short_description = EXCLUDED.short_description,
  long_description  = EXCLUDED.long_description,
  salary_range      = EXCLUDED.salary_range,
  training_time     = EXCLUDED.training_time,
  difficulty_level  = EXCLUDED.difficulty_level,
  example_roles     = EXCLUDED.example_roles,
  is_published      = EXCLUDED.is_published,
  updated_at        = NOW();


-- ── digital-marketing-salary ─────────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'digital-marketing-salary',
  'intent',
  'כמה מרוויח מנהל שיווק דיגיטלי בישראל',
  'טווח שכר לאנשי שיווק דיגיטלי בישראל — ממתחיל ועד בכיר.',
  'מתחילים בשיווק דיגיטלי מרוויחים 8,000–13,000 ₪ בחודש. עם ניסיון ב-Performance Marketing ויכולת להוכיח ROI, השכר עולה ל-15,000–22,000 ₪. הגורמים שמשפיעים: התמחות ספציפית (Paid Ads לעומת SEO), גודל התקציב שמנוהל, וסוג החברה (B2B/B2C, מוצר/שירותים). בכירים עם מעל 5 שנות ניסיון ויכולת לנהל צוות יכולים להגיע ל-25,000–35,000 ₪.',
  '8,000–35,000 ₪',
  NULL,
  NULL,
  NULL,
  true
)
ON CONFLICT (slug) DO UPDATE SET
  page_type         = EXCLUDED.page_type,
  title             = EXCLUDED.title,
  short_description = EXCLUDED.short_description,
  long_description  = EXCLUDED.long_description,
  salary_range      = EXCLUDED.salary_range,
  training_time     = EXCLUDED.training_time,
  difficulty_level  = EXCLUDED.difficulty_level,
  example_roles     = EXCLUDED.example_roles,
  is_published      = EXCLUDED.is_published,
  updated_at        = NOW();


-- ── how-to-become-ux-designer ────────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'how-to-become-ux-designer',
  'intent',
  'איך להיכנס לתחום ה-UX/UI',
  'מדריך כניסה לתכנון ממשקי משתמש — כישורים, כלים ואיך מתחילים לעבוד בתחום.',
  'UX/UI Designer אחראי על חוויית המשתמש ועיצוב הממשקים בפיתוח דיגיטלי. הכישורים הבסיסיים: ידע ב-Figma, הבנת עקרונות UX (ארכיטקטורת מידע, בדיקות משתמשים), ויכולת לתקשר החלטות עיצוביות. הדרך לכניסה: קורס ממוקד של 3–6 חודשים ובניית פורטפוליו עם 3–4 פרויקטים. פורטפוליו חזק חשוב יותר מהתעודה — מעסיקים מחפשים ראיות לחשיבה עיצובית, לא רק עיצוב יפה.',
  '10,000–16,000 ₪ למתחילים',
  '3–6 חודשים',
  'בינוני',
  'UX Designer, UI Designer, Product Designer, UX/UI Researcher',
  true
)
ON CONFLICT (slug) DO UPDATE SET
  page_type         = EXCLUDED.page_type,
  title             = EXCLUDED.title,
  short_description = EXCLUDED.short_description,
  long_description  = EXCLUDED.long_description,
  salary_range      = EXCLUDED.salary_range,
  training_time     = EXCLUDED.training_time,
  difficulty_level  = EXCLUDED.difficulty_level,
  example_roles     = EXCLUDED.example_roles,
  is_published      = EXCLUDED.is_published,
  updated_at        = NOW();


-- ── ux-designer-salary ───────────────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'ux-designer-salary',
  'intent',
  'כמה מרוויח מעצב UX/UI בישראל',
  'טווח שכר למעצבי UX/UI בישראל — ממתחיל ועד בכיר.',
  'מעצבי UX/UI מתחילים מרוויחים 10,000–16,000 ₪ בחודש. עם ניסיון ב-Product Design ויכולת לנהל תהליך עיצוב מקצה לקצה, השכר עולה ל-18,000–28,000 ₪. הגורמים שמשפיעים: סוג החברה (סטארטאפ לעומת אנטרפרייז), יכולת עבודה עם Design Systems, ועומק הניסיון ב-UX Research. בכירים עם מוצרים ניכרים בפורטפוליו יכולים להגיע ל-30,000–40,000 ₪.',
  '10,000–40,000 ₪',
  NULL,
  NULL,
  NULL,
  true
)
ON CONFLICT (slug) DO UPDATE SET
  page_type         = EXCLUDED.page_type,
  title             = EXCLUDED.title,
  short_description = EXCLUDED.short_description,
  long_description  = EXCLUDED.long_description,
  salary_range      = EXCLUDED.salary_range,
  training_time     = EXCLUDED.training_time,
  difficulty_level  = EXCLUDED.difficulty_level,
  example_roles     = EXCLUDED.example_roles,
  is_published      = EXCLUDED.is_published,
  updated_at        = NOW();
