-- ============================================================
-- Migration: 005_intent_page_seed
-- Project:   Mishtachrerim
-- Phase:     5A
--
-- Seeds 4 intent pages into career_paths.
-- Intent pages target specific search queries and link back to
-- their parent career page. No schema changes.
--
-- Scope:
--   - page_type = 'intent' rows only
--   - No DDL changes
--   - No new tables
--   - No FK additions
--
-- Parent career linkage is handled at render time by a static
-- mapping in IntentPageContent — not by a DB column.
--
-- Rerun-safe: ON CONFLICT (slug) DO UPDATE SET brings every field
-- to the approved values on each run.
-- ============================================================


-- ── how-to-become-qa ─────────────────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'how-to-become-qa',
  'intent',
  'איך להיכנס לתחום QA',
  'מדריך מעשי לכניסה לעולם בדיקות התוכנה — מה לומדים, כמה זמן לוקח ואיך מוצאים עבודה ראשונה.',
  'כדי להיכנס ל-QA אין צורך ברקע בתכנות. קורס בדיקות תוכנה ידניות נמשך 3–4 חודשים ומכין לתפקידי Junior QA. הכישורים שמעסיקים מחפשים: חשיבה ביקורתית, תשומת לב לפרטים, ויכולת לתעד תקלות בצורה ברורה. לאחר שנה-שנתיים אפשר להתמחות באוטומציה ולהגדיל משמעותית את השכר.',
  '9,000–14,000 ₪ למתחילים',
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


-- ── qa-salary ────────────────────────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'qa-salary',
  'intent',
  'כמה מרוויח בודק תוכנה (QA) בישראל',
  'טווח שכר לבודקי תוכנה בישראל — ממתחיל ועד בכיר, לפי ניסיון ותחום התמחות.',
  'בודקי תוכנה מתחילים מרוויחים 9,000–14,000 ₪ בחודש. עם 2–3 שנות ניסיון ומעבר לאוטומציה, השכר עולה ל-15,000–22,000 ₪. הגורמים שמשפיעים: ידע בכלי אוטומציה כמו Selenium ו-Playwright, ניסיון בבדיקות API, וגודל החברה.',
  '9,000–22,000 ₪',
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


-- ── how-to-become-data-analyst ───────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'how-to-become-data-analyst',
  'intent',
  'איך להיכנס לתחום ניתוח הנתונים',
  'מדריך לכניסה לתפקיד אנליסט נתונים — כישורים נדרשים, זמן הכשרה ואיך מציגים ידע בפני מעסיקים.',
  'הכישורים הבסיסיים: SQL, Python בסיסי, ו-Excel מתקדם. הכשרה ממוקדת של 6 חודשים מספיקה לרוב כדי לגשת לראיונות ראשונים. מעסיקים מחפשים מישהו שמסוגל לנתח נתונים, לייצר דוחות, ולתמוך בקבלת החלטות עסקיות. פורטפוליו עם 2–3 פרויקטי ניתוח אמיתיים שווה יותר ממרבית הקורסים.',
  '12,000–20,000 ₪ למתחילים',
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


-- ── data-analyst-salary ──────────────────────────────────────────────────────

INSERT INTO public.career_paths (
  slug, page_type, title,
  short_description, long_description,
  salary_range, training_time, difficulty_level, example_roles,
  is_published
)
VALUES (
  'data-analyst-salary',
  'intent',
  'כמה מרוויח אנליסט נתונים בישראל',
  'טווח שכר לאנליסטי נתונים בישראל — ממתחיל ועד בכיר, לפי כלים וניסיון.',
  'אנליסטי נתונים מתחילים מרוויחים 12,000–20,000 ₪ בחודש — אחד מטווחי הכניסה הגבוהים בשוק הטכנולוגיה. השכר עולה עם ידע ב-BI Tools כמו Tableau ו-Power BI ועם ניסיון בעבודה עם Big Data. עם 3–4 שנות ניסיון, שכר של 25,000–35,000 ₪ הוא ריאלי.',
  '12,000–35,000 ₪',
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
