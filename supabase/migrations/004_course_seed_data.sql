-- ============================================================
-- Migration: 004_course_seed_data
-- Project:   Mishtachrerim
-- Phase:     4B pre-check gate
--
-- Seeds the minimal set of published courses and their career-path
-- associations required to pass the Phase 4B pre-check.
--
-- Design decisions:
--
--   1. Rerun-safe
--      Courses use ON CONFLICT (slug) DO UPDATE SET so that every
--      field is brought to the approved values on each run.
--      Junction rows use ON CONFLICT (course_id, career_path_id) DO NOTHING
--      because the composite PRIMARY KEY is the conflict target.
--
--   2. No hardcoded UUIDs
--      course_id and career_path_id are resolved from slug columns
--      via subqueries / JOIN at execution time.
--
--   3. Pre-flight guard
--      A DO $$ block runs before any INSERT. If any required career
--      path slug is missing or unpublished, the migration raises an
--      exception and rolls back — no partial state is left.
--
--   4. Schema untouched
--      No DDL statements. All INSERTs reference existing columns only.
-- ============================================================

-- ─── Pre-flight: verify required career path slugs ────────────────────────────
-- Raises immediately if any slug is absent or not published.
-- Prevents the junction INSERT from silently inserting nothing.

DO $$
DECLARE
  missing TEXT[];
BEGIN
  SELECT ARRAY_AGG(required.slug)
    INTO missing
  FROM (VALUES
    ('full-stack-developer'),
    ('data-analyst'),
    ('qa-tester'),
    ('digital-marketing'),
    ('ux-ui-designer')
  ) AS required(slug)
  LEFT JOIN public.career_paths cp
         ON cp.slug = required.slug
        AND cp.is_published = true
  WHERE cp.slug IS NULL;

  IF missing IS NOT NULL AND array_length(missing, 1) > 0 THEN
    RAISE EXCEPTION
      'Pre-flight failed: required career path slugs not found or not published: %',
      missing;
  END IF;
END $$;

-- ─── Courses ──────────────────────────────────────────────────────────────────

INSERT INTO public.courses (
  slug,
  title,
  provider_name,
  description,
  duration,
  learning_mode,
  price_range,
  deposit_eligible,
  editorial_rating,
  provider_url,
  is_published
)
VALUES
  (
    'fullstack-web-bootcamp',
    'בוטקמפ פיתוח Full Stack',
    'Course Provider',
    'הכשרה מקיפה לפיתוח Full Stack הכוללת HTML, CSS, JavaScript, React ו-Node.js. מתאים למשתחררים ללא רקע תכנותי קודם. הקורס כולל פרויקט גמר אישי ותמיכה בחיפוש עבודה.',
    '12 חודשים',
    'hybrid',
    '15,000–25,000 ₪',
    true,
    4.0,
    NULL,
    true
  ),
  (
    'data-analysis-python',
    'ניתוח נתונים עם Python',
    'Course Provider',
    'קורס מעשי לניתוח נתונים באמצעות Python, Pandas ו-SQL. כולל עבודה עם נתונים אמיתיים, ויזואליזציה וסטטיסטיקה בסיסית. מתאים לבעלי חשיבה כמותית.',
    '6 חודשים',
    'online',
    '8,000–14,000 ₪',
    true,
    4.0,
    NULL,
    true
  ),
  (
    'qa-testing-foundations',
    'יסודות בדיקות תוכנה (QA)',
    'Course Provider',
    'הכשרה לבדיקות תוכנה ידניות ואוטומטיות. כולל כלים מקצועיים כגון Selenium ו-Postman, ופרויקט גמר על אפליקציה אמיתית.',
    '3 חודשים',
    'online',
    '5,000–9,000 ₪',
    true,
    3.5,
    NULL,
    true
  ),
  (
    'digital-marketing-fundamentals',
    'שיווק דיגיטלי — יסודות ומעבר',
    'Course Provider',
    'קורס שיווק דיגיטלי מקיף: Google Ads, Meta Ads, SEO, אימייל מרקטינג ואנליטיקס. מתאים לתחילת דרך בתחום ללא ידע קודם.',
    '3 חודשים',
    'online',
    '4,000–8,000 ₪',
    true,
    4.0,
    NULL,
    true
  ),
  (
    'ux-ui-design-course',
    'עיצוב UX/UI — מהתיאוריה לפרקטיקה',
    'Course Provider',
    'קורס עיצוב חוויית משתמש ועיצוב ממשק. כולל Figma, מחקר משתמשים, אפיון זרימות ובניית תיק עבודות מקצועי.',
    '6 חודשים',
    'hybrid',
    '8,000–14,000 ₪',
    true,
    4.0,
    NULL,
    true
  )
ON CONFLICT (slug) DO UPDATE SET
  title            = EXCLUDED.title,
  provider_name    = EXCLUDED.provider_name,
  description      = EXCLUDED.description,
  duration         = EXCLUDED.duration,
  learning_mode    = EXCLUDED.learning_mode,
  price_range      = EXCLUDED.price_range,
  deposit_eligible = EXCLUDED.deposit_eligible,
  editorial_rating = EXCLUDED.editorial_rating,
  provider_url     = EXCLUDED.provider_url,
  is_published     = EXCLUDED.is_published,
  updated_at       = NOW();

-- ─── Course–Career Links ──────────────────────────────────────────────────────
-- Resolves both IDs from slug columns.
-- ON CONFLICT DO NOTHING because PRIMARY KEY (course_id, career_path_id)
-- is the conflict target — duplicate runs are silent no-ops.

INSERT INTO public.course_career_paths (course_id, career_path_id)
SELECT
  c.id  AS course_id,
  cp.id AS career_path_id
FROM (VALUES
  ('fullstack-web-bootcamp',         'full-stack-developer'),
  ('data-analysis-python',           'data-analyst'),
  ('qa-testing-foundations',         'qa-tester'),
  ('digital-marketing-fundamentals', 'digital-marketing'),
  ('ux-ui-design-course',            'ux-ui-designer')
) AS links(course_slug, career_slug)
JOIN public.courses      c  ON c.slug  = links.course_slug
JOIN public.career_paths cp ON cp.slug = links.career_slug
ON CONFLICT (course_id, career_path_id) DO NOTHING;
