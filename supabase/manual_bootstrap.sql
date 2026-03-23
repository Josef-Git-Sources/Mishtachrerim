-- ============================================================
-- manual_bootstrap.sql
-- Project: Mishtachrerim
--
-- Convenience file for web-only Supabase setup.
-- Contains the exact content of all 7 migrations in the
-- required execution order. No statements were added,
-- removed, or modified.
--
-- Instructions:
--   1. Open your Supabase project → SQL Editor
--   2. Paste this entire file and click Run
--   3. Validate results per docs/deployment/supabase-web-bootstrap.md
--
-- If this file produces an error, re-run each migration
-- file individually using Option A in the bootstrap guide.
--
-- Migration order:
--   001_initial_schema.sql      — schema DDL
--   002_quiz_seed_data.sql      — quiz + career path stubs
--   003_career_path_content.sql — career path Hebrew content
--   004_course_seed_data.sql    — courses + junction links
--   005_intent_page_seed.sql    — 4 intent pages
--   006_intent_page_seed_5b.sql — 8 more intent pages
--   007_quiz_hebrew_text.sql    — Hebrew text for quiz questions/answers
-- ============================================================


-- ============================================================
-- BEGIN: 001_initial_schema.sql
-- ============================================================

-- ============================================================
-- Migration: 001_initial_schema
-- Project:   Mishtachrerim
-- Phase:     1
--
-- Creates the full Phase 1 database schema.
--
-- Design decisions recorded here:
--
--   1. career_paths.page_type
--      Both career pages and intent pages are stored in this table.
--      The page_type field ('career' | 'intent') determines which
--      layout variant is rendered at /career/[slug].
--      No separate intent_pages table is needed.
--
--   2. course_career_paths (junction table)
--      Courses have a many-to-many relationship with career paths.
--      This replaces the single career_path_id FK from the original
--      DATA_MODEL.md spec. A course can appear on multiple career pages.
--
--   3. public.users mirrors auth.users
--      Supabase Auth manages auth.users. public.users stores additional
--      profile fields and is referenced by all other tables.
--      A trigger should be added (Phase 2) to auto-create the public.users
--      row when a new auth.users row is inserted.
--
--   4. quiz_results.user_id is nullable
--      Anonymous users can complete the quiz. user_id is null for
--      anonymous results and set when the user is authenticated.
--
--   5. Indexes
--      Added on all slug columns, published flags, and FK columns
--      used in common join patterns.
-- ============================================================

-- ============================================================
-- Extensions
-- ============================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- Users
-- References Supabase Auth (auth.users).
-- Row is created when a user signs up via Supabase Auth.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.users (
  id            UUID        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email         TEXT        NOT NULL,
  auth_provider TEXT,                            -- 'google' | 'email'
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_login_at TIMESTAMPTZ
);

-- ============================================================
-- Career Paths
-- Stores both career pages (page_type = 'career') and
-- intent pages (page_type = 'intent').
-- Served by the single route /career/[slug].
-- ============================================================

CREATE TABLE IF NOT EXISTS public.career_paths (
  id                UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  slug              TEXT        NOT NULL UNIQUE,
  page_type         TEXT        NOT NULL DEFAULT 'career', -- 'career' | 'intent'
  title             TEXT        NOT NULL,
  short_description TEXT,
  long_description  TEXT,
  salary_range      TEXT,
  training_time     TEXT,
  difficulty_level  TEXT,
  example_roles     TEXT,
  is_published      BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Courses
-- No direct career_path_id FK — relationship is many-to-many
-- via the course_career_paths junction table below.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.courses (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  slug             TEXT        NOT NULL UNIQUE,
  title            TEXT        NOT NULL,
  provider_name    TEXT,
  description      TEXT,
  duration         TEXT,
  learning_mode    TEXT,                          -- 'online' | 'in-person' | 'hybrid'
  price_range      TEXT,
  deposit_eligible BOOLEAN     NOT NULL DEFAULT FALSE,
  editorial_rating NUMERIC(3,1),
  provider_url     TEXT,
  is_published     BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Course ↔ Career Path junction (many-to-many)
-- Replaces the single-FK model described in DATA_MODEL.md.
-- A course can appear on multiple career path pages.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.course_career_paths (
  course_id      UUID NOT NULL REFERENCES public.courses(id)      ON DELETE CASCADE,
  career_path_id UUID NOT NULL REFERENCES public.career_paths(id) ON DELETE CASCADE,
  PRIMARY KEY (course_id, career_path_id)
);

-- ============================================================
-- Guides
-- SEO informational articles.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.guides (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  slug         TEXT        NOT NULL UNIQUE,
  title        TEXT        NOT NULL,
  summary      TEXT,
  content      TEXT,
  author_name  TEXT,
  is_published BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Checklist Items
-- Post-discharge action items shown on /checklist.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.checklist_items (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  title         TEXT        NOT NULL,
  description   TEXT,
  display_order INTEGER     NOT NULL DEFAULT 0,
  is_published  BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- User Checklist Progress
-- Tracks per-user completion of checklist items.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.user_checklist_items (
  id                UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID        NOT NULL REFERENCES public.users(id)           ON DELETE CASCADE,
  checklist_item_id UUID        NOT NULL REFERENCES public.checklist_items(id) ON DELETE CASCADE,
  completed         BOOLEAN     NOT NULL DEFAULT FALSE,
  completed_at      TIMESTAMPTZ,
  UNIQUE (user_id, checklist_item_id)
);

-- ============================================================
-- Quiz Questions
-- question_key values: 'q1' through 'q10'.
-- Quick quiz uses q1–q5. Deep quiz uses q1–q10.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.quiz_questions (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  question_key  TEXT        NOT NULL UNIQUE,  -- 'q1' ... 'q10'
  question_text TEXT        NOT NULL,
  display_order INTEGER     NOT NULL DEFAULT 0,
  is_active     BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Quiz Answers
-- Answer options for each question.
-- answer_key values: 'a', 'b', 'c', 'd' per question.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.quiz_answers (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id   UUID        NOT NULL REFERENCES public.quiz_questions(id) ON DELETE CASCADE,
  answer_key    TEXT        NOT NULL,  -- 'a' | 'b' | 'c' | 'd'
  answer_text   TEXT        NOT NULL,
  display_order INTEGER     NOT NULL DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (question_id, answer_key)
);

-- ============================================================
-- Quiz Answer Score Mappings
-- Maps each answer to one or more career paths with a score value.
--
-- Source of truth for score values: /docs/quiz/QUIZ_QUESTION_BANK.md
-- Do not change score values here without updating that document.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.quiz_answer_scores (
  id             UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
  answer_id      UUID    NOT NULL REFERENCES public.quiz_answers(id)   ON DELETE CASCADE,
  career_path_id UUID    NOT NULL REFERENCES public.career_paths(id)   ON DELETE CASCADE,
  score_value    INTEGER NOT NULL DEFAULT 0,
  UNIQUE (answer_id, career_path_id)
);

-- ============================================================
-- Quiz Results
-- One record per quiz attempt.
-- user_id is nullable — anonymous users can take the quiz.
-- quiz_type: 'quick' | 'deep'
-- quiz_version: incremented if question bank changes significantly.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.quiz_results (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID        REFERENCES public.users(id) ON DELETE SET NULL,  -- nullable
  quiz_type    TEXT        NOT NULL,   -- 'quick' | 'deep'
  quiz_version INTEGER     NOT NULL DEFAULT 1,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Quiz Result Careers
-- Stores the ranked career matches for a quiz result.
-- The UI displays the top 3. More can be stored for analytics.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.quiz_result_careers (
  id             UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
  quiz_result_id UUID    NOT NULL REFERENCES public.quiz_results(id)  ON DELETE CASCADE,
  career_path_id UUID    NOT NULL REFERENCES public.career_paths(id)  ON DELETE CASCADE,
  score          INTEGER NOT NULL DEFAULT 0,
  rank           INTEGER NOT NULL,
  UNIQUE (quiz_result_id, career_path_id),
  UNIQUE (quiz_result_id, rank)
);

-- ============================================================
-- Leads
-- Lead form submissions from course and career pages.
-- course_id is nullable — a lead may not be tied to a specific course.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.leads (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  email       TEXT        NOT NULL,
  phone       TEXT,
  name        TEXT,
  source_page TEXT,
  course_id   UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Indexes
-- ============================================================

-- career_paths
CREATE INDEX IF NOT EXISTS idx_career_paths_slug        ON public.career_paths (slug);
CREATE INDEX IF NOT EXISTS idx_career_paths_page_type   ON public.career_paths (page_type);
CREATE INDEX IF NOT EXISTS idx_career_paths_published   ON public.career_paths (is_published);

-- courses
CREATE INDEX IF NOT EXISTS idx_courses_slug             ON public.courses (slug);
CREATE INDEX IF NOT EXISTS idx_courses_published        ON public.courses (is_published);

-- course_career_paths (support queries from both sides)
CREATE INDEX IF NOT EXISTS idx_ccp_career_path_id       ON public.course_career_paths (career_path_id);

-- guides
CREATE INDEX IF NOT EXISTS idx_guides_slug              ON public.guides (slug);
CREATE INDEX IF NOT EXISTS idx_guides_published         ON public.guides (is_published);

-- quiz
CREATE INDEX IF NOT EXISTS idx_quiz_questions_key       ON public.quiz_questions (question_key);
CREATE INDEX IF NOT EXISTS idx_quiz_questions_order     ON public.quiz_questions (display_order);
CREATE INDEX IF NOT EXISTS idx_quiz_results_user        ON public.quiz_results (user_id);
CREATE INDEX IF NOT EXISTS idx_quiz_result_careers_rid  ON public.quiz_result_careers (quiz_result_id);

-- ============================================================
-- BEGIN: 002_quiz_seed_data.sql
-- ============================================================

-- ============================================================
-- Migration: 002_quiz_seed_data
-- Project:   Mishtachrerim
-- Phase:     2
--
-- Populates the relational quiz tables with canonical data from:
--   /docs/quiz/QUIZ_QUESTION_BANK.md  (source of truth for all score values)
--
-- Tables populated:
--   career_paths        — stub rows for all 10 supported careers (is_published = false)
--   quiz_questions      — q1–q10
--   quiz_answers        — all answer options per question
--   quiz_answer_scores  — score mappings per (answer, career_path)
--
-- All INSERTs use ON CONFLICT DO NOTHING to be safe for re-runs.
--
-- IMPORTANT: Do not change score_value entries here without updating
-- QUIZ_QUESTION_BANK.md first. That document is the source of truth.
-- ============================================================


-- ============================================================
-- Career Path Stubs
-- Inserted as is_published = false. Content editors populate
-- the remaining fields. These rows must exist before quiz_answer_scores
-- can reference them via FK.
-- ============================================================

INSERT INTO public.career_paths (slug, title, page_type, is_published)
VALUES
  ('full-stack-developer',  'Full Stack Developer',  'career', false),
  ('data-analyst',          'Data Analyst',          'career', false),
  ('qa-tester',             'QA Tester',             'career', false),
  ('ux-ui-designer',        'UX/UI Designer',        'career', false),
  ('digital-marketing',     'Digital Marketing',     'career', false),
  ('it-support',            'IT Support',            'career', false),
  ('network-technician',    'Network Technician',    'career', false),
  ('project-management',    'Project Management',    'career', false),
  ('graphic-design',        'Graphic Design',        'career', false),
  ('ecommerce-manager',     'Ecommerce Manager',     'career', false)
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- Quiz Questions
-- question_key is the canonical identifier used in all mappings.
-- Quick quiz: q1–q5. Deep quiz: q1–q10.
-- ============================================================

INSERT INTO public.quiz_questions (question_key, question_text, display_order)
VALUES
  ('q1',  'What type of tasks do you enjoy the most?',                       1),
  ('q2',  'How comfortable are you with technology?',                        2),
  ('q3',  'What kind of work environment do you prefer?',                    3),
  ('q4',  'How long are you willing to invest in learning a new profession?', 4),
  ('q5',  'What motivates you the most in a career?',                        5),
  ('q6',  'Do you enjoy working with data?',                                 6),
  ('q7',  'What type of learning style suits you best?',                     7),
  ('q8',  'How comfortable are you with problem solving under pressure?',    8),
  ('q9',  'Do you enjoy planning and organizing projects?',                  9),
  ('q10', 'What type of results give you the most satisfaction?',           10)
ON CONFLICT (question_key) DO NOTHING;


-- ============================================================
-- Quiz Answers
-- Each block inserts all answers for one question using a CROSS JOIN
-- so we can reference question_id by question_key without a subquery
-- per row.
-- ============================================================

-- Q1
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'Solving logical or technical problems',      1),
  ('b', 'Creating visuals or designing things',       2),
  ('c', 'Working with people and organizing work',    3),
  ('d', 'Managing systems or fixing technical issues',4)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q1'
ON CONFLICT (question_id, answer_key) DO NOTHING;

-- Q2
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'Very comfortable, I enjoy learning new tools', 1),
  ('b', 'Comfortable, but I prefer structured tools',   2),
  ('c', 'Moderately comfortable',                       3),
  ('d', 'Not very comfortable',                         4)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q2'
ON CONFLICT (question_id, answer_key) DO NOTHING;

-- Q3
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'Independent analytical work', 1),
  ('b', 'Creative work',               2),
  ('c', 'Structured technical work',   3),
  ('d', 'Collaborative team work',     4)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q3'
ON CONFLICT (question_id, answer_key) DO NOTHING;

-- Q4 (3 options only)
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'Less than 6 months',    1),
  ('b', '6–12 months',           2),
  ('c', 'More than a year',      3)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q4'
ON CONFLICT (question_id, answer_key) DO NOTHING;

-- Q5
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'High salary potential',              1),
  ('b', 'Creative expression',                2),
  ('c', 'Stable and practical work',          3),
  ('d', 'Working with people and leading projects', 4)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q5'
ON CONFLICT (question_id, answer_key) DO NOTHING;

-- Q6 (3 options only)
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'Yes, I enjoy analyzing numbers and patterns', 1),
  ('b', 'Somewhat',                                    2),
  ('c', 'Not really',                                  3)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q6'
ON CONFLICT (question_id, answer_key) DO NOTHING;

-- Q7
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'Technical hands-on learning',               1),
  ('b', 'Structured training with clear tasks',      2),
  ('c', 'Creative exploration',                      3),
  ('d', 'Strategic and business learning',           4)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q7'
ON CONFLICT (question_id, answer_key) DO NOTHING;

-- Q8 (3 options only)
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'Very comfortable',               1),
  ('b', 'Comfortable',                    2),
  ('c', 'Prefer slower paced environments', 3)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q8'
ON CONFLICT (question_id, answer_key) DO NOTHING;

-- Q9 (3 options only)
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'Yes, very much', 1),
  ('b', 'Sometimes',      2),
  ('c', 'Not really',     3)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q9'
ON CONFLICT (question_id, answer_key) DO NOTHING;

-- Q10
INSERT INTO public.quiz_answers (question_id, answer_key, answer_text, display_order)
SELECT q.id, v.answer_key, v.answer_text, v.display_order
FROM public.quiz_questions q
CROSS JOIN (VALUES
  ('a', 'Building working systems',                    1),
  ('b', 'Finding insights in data',                    2),
  ('c', 'Designing something visually appealing',      3),
  ('d', 'Launching campaigns or business initiatives', 4)
) AS v(answer_key, answer_text, display_order)
WHERE q.question_key = 'q10'
ON CONFLICT (question_id, answer_key) DO NOTHING;


-- ============================================================
-- Quiz Answer Scores
-- Each block inserts all score mappings for one question.
-- Score values are taken verbatim from QUIZ_QUESTION_BANK.md.
-- ============================================================

-- Q1 scores
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'full-stack-developer', 3),
  ('a', 'data-analyst',         3),
  ('a', 'qa-tester',            2),
  ('a', 'it-support',           2),
  ('b', 'graphic-design',       3),
  ('b', 'ux-ui-designer',       3),
  ('b', 'digital-marketing',    1),
  ('c', 'project-management',   3),
  ('c', 'digital-marketing',    2),
  ('c', 'ecommerce-manager',    2),
  ('d', 'it-support',           3),
  ('d', 'network-technician',   3),
  ('d', 'qa-tester',            2)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q1' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q2 scores
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'full-stack-developer', 3),
  ('a', 'data-analyst',         2),
  ('a', 'qa-tester',            2),
  ('b', 'qa-tester',            3),
  ('b', 'it-support',           2),
  ('b', 'project-management',   1),
  ('c', 'digital-marketing',    2),
  ('c', 'ecommerce-manager',    2),
  ('d', 'project-management',   2),
  ('d', 'graphic-design',       2)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q2' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q3 scores
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'data-analyst',         3),
  ('a', 'full-stack-developer', 2),
  ('b', 'graphic-design',       3),
  ('b', 'ux-ui-designer',       3),
  ('c', 'qa-tester',            3),
  ('c', 'it-support',           2),
  ('d', 'project-management',   3),
  ('d', 'digital-marketing',    2)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q3' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q4 scores
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'qa-tester',            3),
  ('a', 'it-support',           3),
  ('a', 'digital-marketing',    2),
  ('b', 'data-analyst',         2),
  ('b', 'ux-ui-designer',       2),
  ('b', 'graphic-design',       2),
  ('c', 'full-stack-developer', 3),
  ('c', 'network-technician',   2)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q4' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q5 scores
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'full-stack-developer', 3),
  ('a', 'data-analyst',         2),
  ('a', 'ecommerce-manager',    2),
  ('b', 'graphic-design',       3),
  ('b', 'ux-ui-designer',       3),
  ('c', 'qa-tester',            3),
  ('c', 'it-support',           3),
  ('d', 'project-management',   3),
  ('d', 'digital-marketing',    2)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q5' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q6 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'data-analyst',         3),
  ('a', 'full-stack-developer', 1),
  ('b', 'digital-marketing',    2),
  ('b', 'project-management',   1),
  ('c', 'graphic-design',       2),
  ('c', 'ux-ui-designer',       2)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q6' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q7 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'full-stack-developer', 3),
  ('a', 'network-technician',   2),
  ('b', 'qa-tester',            3),
  ('b', 'it-support',           2),
  ('c', 'graphic-design',       3),
  ('c', 'ux-ui-designer',       3),
  ('d', 'digital-marketing',    2),
  ('d', 'ecommerce-manager',    3),
  ('d', 'project-management',   2)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q7' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q8 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'it-support',           3),
  ('a', 'network-technician',   3),
  ('b', 'qa-tester',            2),
  ('b', 'full-stack-developer', 2),
  ('c', 'graphic-design',       2),
  ('c', 'ux-ui-designer',       2)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q8' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q9 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'project-management',   3),
  ('a', 'digital-marketing',    2),
  ('b', 'ecommerce-manager',    2),
  ('b', 'data-analyst',         1),
  ('c', 'full-stack-developer', 2),
  ('c', 'graphic-design',       1)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q9' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q10 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
CROSS JOIN (VALUES
  ('a', 'full-stack-developer', 3),
  ('a', 'network-technician',   2),
  ('b', 'data-analyst',         3),
  ('c', 'graphic-design',       3),
  ('c', 'ux-ui-designer',       3),
  ('d', 'digital-marketing',    3),
  ('d', 'ecommerce-manager',    2)
) AS v(answer_key, career_slug, score_value)
JOIN public.career_paths cp  ON cp.slug = v.career_slug
WHERE q.question_key = 'q10' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- ============================================================
-- BEGIN: 003_career_path_content.sql
-- ============================================================

-- ============================================================
-- Migration: 003_career_path_content
-- Project:   Mishtachrerim
-- Phase:     3B
--
-- Populates the 10 base career path rows inserted by 002_quiz_seed_data
-- with real Hebrew content and sets is_published = true.
--
-- Scope:
--   - page_type = 'career' rows only (all 10 base careers)
--   - No intent pages
--   - No schema changes
--
-- title stores the base English career name only.
-- The H1 suffix (— מה זה, כמה מרוויחים ואיך מתחילים) is appended by
-- CareerPageContent at render time.
-- The SEO title suffix (— שכר, זמן הכשרה והאם זה מתאים לכם) is appended
-- by generateMetadata at render time.
--
-- difficulty_level uses three controlled values: נמוך | בינוני | גבוה
-- salary_range includes the qualifier למתחילים within the string.
-- ============================================================


-- ── full-stack-developer ─────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Full Stack Developer',
  short_description = 'Full Stack Developer הוא מפתח שעובד הן על ממשק המשתמש (Front End) והן על הלוגיקה והשרתים (Back End). ההכשרה ארוכה יחסית, אך מובילה לאחד טווחי השכר הגבוהים בשוק ההייטק.',
  long_description  = 'מפתח Full Stack אחראי על פיתוח יישומי web מקצה לקצה — ממשק המשתמש, הלוגיקה העסקית, מסדי הנתונים וחיבורי ה-API. הכלים הנפוצים כוללים JavaScript, Python, React, Node.js ו-SQL.

המקצוע דורש יכולת לימוד עצמאית גבוהה ונכונות לבנות פרויקטים מעשיים לאורך זמן. רקע בתוכנה, סיסטמות או לוגיקה מהצבא הוא יתרון, אך אנשים ללא רקע טכני נכנסים לתחום לאחר הכשרה מספקת.

הדרך הנפוצה להיכנס היא בוטקאמפ פיתוח web או לימוד עצמי ממוקד עם פרויקטים. מדובר במסלול שדורש השקעה של כ-12–18 חודשים לפני חיפוש עבודה ראשון.',
  salary_range      = '15,000–25,000 ₪ למתחילים',
  training_time     = '12–18 חודשים',
  difficulty_level  = 'גבוה',
  example_roles     = 'מפתח Full Stack, מפתח Front End, מפתח Back End, Web Developer',
  is_published      = true
WHERE slug = 'full-stack-developer';


-- ── data-analyst ─────────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Data Analyst',
  short_description = 'Data Analyst הוא מקצוע שמתמקד בניתוח נתונים ועזרה לארגונים לקבל החלטות מבוססות מידע. דורש רקע אנליטי חזק ונכונות להשקיע בלמידה טכנית.',
  long_description  = 'אנליסט נתונים עובד עם כלים כמו SQL, Python, Excel ו-Tableau כדי לנתח מידע עסקי ולהגיש תובנות לצוותי ניהול. העבודה כוללת איסוף נתונים ממקורות שונים, ניקוי, עיבוד והצגה ברורה של ממצאים.

המקצוע מתאים למי שנוח לו עם מספרים, שם לב לפרטים, ויכול לתרגם נתונים גולמיים לתמונה ברורה. רקע מהצבא בתחומי מודיעין, לוגיסטיקה, פיקוד ושליטה, או כל תפקיד שכלל עבודה שיטתית עם נתונים — רלוונטי לתפקיד.

הכניסה לתחום דרך קורס ממוקד דורשת לימוד SQL, Python ובסיסי סטטיסטיקה. פרויקטים אישיים ו-portfolio ב-GitHub מסייעים להדגים יכולות בפני מעסיקים.',
  salary_range      = '12,000–20,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'גבוה',
  example_roles     = 'אנליסט נתונים, Data Analyst, BI Analyst, Business Analyst',
  is_published      = true
WHERE slug = 'data-analyst';


-- ── qa-tester ─────────────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'QA Tester',
  short_description = 'QA Tester הוא מקצוע שמתמקד בבדיקת תוכנות ומערכות לפני שחרורן למשתמשים. אחד ממסלולי הכניסה הנגישים להייטק, גם ללא ניסיון תכנות מוקדם.',
  long_description  = 'בודק תוכנה אחראי על איתור תקלות ובאגים במוצרים דיגיטליים לפני שחרורם ללקוחות. הוא כותב תסריטי בדיקה, מתעד ממצאים, ועובד בשיתוף פעולה עם צוותי הפיתוח.

המקצוע מתאים למי שמדויק, שם לב לפרטים, ויכול לחשוב על תרחישי כשל. לא נדרש רקע בתכנות כדי להתחיל ב-QA ידני — ידע ב-QA אוטומטי מרחיב את אפשרויות הקידום והשכר בשלב מאוחר יותר.

הדרך הנפוצה להיכנס היא קורס QA ממוקד. תפקידי Junior QA הם נקודת כניסה נפוצה, עם אפשרות לעבור לאוטומציה ולניהול בדיקות בהמשך.',
  salary_range      = '9,000–14,000 ₪ למתחילים',
  training_time     = '3–6 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'בודק תוכנה, QA Engineer, Automation Tester, QA Analyst',
  is_published      = true
WHERE slug = 'qa-tester';


-- ── ux-ui-designer ───────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'UX/UI Designer',
  short_description = 'UX/UI Designer הוא מקצוע שמשלב עיצוב חזותי עם הבנת חוויית משתמש. נמצא בצומת של טכנולוגיה ויצירתיות, ודורש בניית portfolio מעשי כחלק מהכשרה.',
  long_description  = 'מעצב UX/UI אחראי על האופן שבו נראים ומרגישים מוצרים דיגיטליים — אתרים, אפליקציות ומערכות. UX מתמקד בחוויה וב-flow של המשתמש; UI מתמקד בעיצוב הוויזואלי. בשוק הישראלי שני התחומים משולבים לרוב בתפקיד אחד.

הכלים הנפוצים הם Figma ו-Adobe XD. המקצוע מתאים למי שמסוגל לחשוב מנקודת מבט המשתמש ומוכן לשלב בין אסתטיקה לפונקציונליות. ניסיון בהדרכה, תכנון תהליכים, או ממשקי מערכת מהצבא יכול להיות רלוונטי.

הכניסה לתחום דורשת קורס ממוקד ובניית portfolio. הפורטפוליו הוא אמצעי הסינון העיקרי בתחום זה — לא פחות חשוב מהתעודה.',
  salary_range      = '10,000–18,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'מעצב UX/UI, Product Designer, UX Researcher, UI Designer',
  is_published      = true
WHERE slug = 'ux-ui-designer';


-- ── digital-marketing ────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Digital Marketing',
  short_description = 'Digital Marketing כולל ניהול קמפיינים ממומנים, SEO, סושיאל מדיה ואימייל מרקטינג. תחום רחב עם כניסה אפשרית ללא רקע טכני ומגוון נתיבי התמחות.',
  long_description  = 'אנשי שיווק דיגיטלי עובדים על קמפיינים ב-Google Ads, Meta Ads, SEO ורשתות חברתיות. המטרה היא להגדיל תנועה, לייצר לידים, ולמדוד אפקטיביות בעזרת נתונים.

לא נדרש רקע טכני מעמיק. יכולת ניתוח נתונים וכתיבה שיווקית הן יתרון ברור. ניסיון בניהול משימות ועמידה ביעדים מהצבא רלוונטי לניהול קמפיינים שוטף.

הכניסה לתחום אפשרית דרך קורס ממוקד ופרויקטים אישיים. הסמכות כמו Google Ads ו-Meta Blueprint עוזרות להציג ידע בסיסי בפני מעסיקים.',
  salary_range      = '8,000–15,000 ₪ למתחילים',
  training_time     = '3–6 חודשים',
  difficulty_level  = 'נמוך',
  example_roles     = 'מנהל קמפיינים, Performance Marketer, מנהל סושיאל מדיה, SEO Specialist',
  is_published      = true
WHERE slug = 'digital-marketing';


-- ── it-support ───────────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'IT Support',
  short_description = 'IT Support הוא תפקיד שמטפל בתשתיות מחשוב, פתרון תקלות ותמיכה טכנית בארגונים. נקודת כניסה נגישה לתחום הטכנולוגי, עם ביקוש יציב.',
  long_description  = 'אנשי IT Support מטפלים בתקלות טכניות, מנהלים חשבונות משתמשים, ומסייעים לעובדים בבעיות יומיומיות. העבודה כוללת תמיכה במחשבים, מערכות הפעלה ורשתות ארגוניות.

אנשים עם רקע תקשוב צבאי — ממ"מים, מפעילי מערכות, אנשי תחזוקה — מגיעים עם ידע ישיר הרלוונטי לתפקיד. ניסיון עם חומרה, מערכות הפעלה ותשתיות מפחית את זמן ההסתגלות לתפקיד.

ניתן להיכנס לתחום גם ללא קורס פורמלי. הסמכות כמו CompTIA A+ ו-Microsoft מאפשרות קידום לתפקידי System Administrator בהמשך.',
  salary_range      = '8,000–13,000 ₪ למתחילים',
  training_time     = '3–6 חודשים',
  difficulty_level  = 'נמוך',
  example_roles     = 'תומך IT, Help Desk Technician, IT Support Specialist, System Administrator',
  is_published      = true
WHERE slug = 'it-support';


-- ── network-technician ───────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Network Technician',
  short_description = 'Network Technician הוא טכנאי שמתמחה בהתקנה, תפעול ואבחון של רשתות תקשורת. מתאים לאנשים עם רקע תקשוב צבאי ולמי שמחפש עבודה טכנית מעשית.',
  long_description  = 'טכנאי רשתות מתקין ומתחזק תשתיות רשת — נתבים, סוויצ׳ים, Firewalls ו-VPN. הוא מאבחן תקלות ומוודא שהתשתית פועלת בצורה תקינה ומאובטחת.

רקע צבאי בתחום תקשוב, קשר, או ניהול מערכות תקשורת רלוונטי ישירות לתפקיד. ידע בציוד תקשורת ופרוטוקולי רשת מהשירות מפחית את עקומת הלמידה.

הסמכות כמו CCNA של Cisco ו-CompTIA Network+ הן אמות המידה הנפוצות בתחום. קורס רשתות ממוקד מכין לתפקידי אדמיניסטרציה ואבטחת רשתות.',
  salary_range      = '9,000–16,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'טכנאי רשתות, Network Administrator, Network Engineer, תומך תשתיות',
  is_published      = true
WHERE slug = 'network-technician';


-- ── project-management ───────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Project Management',
  short_description = 'ניהול פרויקטים הוא מקצוע שעוסק בתכנון, תיאום וביצוע פרויקטים בארגונים. ניסיון פיקודי מהצבא מספק בסיס רלוונטי לתפקיד.',
  long_description  = 'מנהל פרויקטים אחראי על תכנון לוחות זמנים, תיאום בין צוותים, מעקב אחר התקדמות וזיהוי סיכונים. הוא מוודא שהפרויקט מגיע ליעדו בזמן ובמסגרת התקציב.

ניסיון פיקודי, ניהול מבצעים, ניהול לוגיסטי, או עמידה ביעדים תחת לחץ — כולם רלוונטיים לתפקיד. מעסיקים רבים מכירים בניסיון הצבאי כבסיס מקצועי תקף לתחום זה.

לתפקידים בהייטק נדרש לרוב ידע בשיטות Agile ו-Scrum, ולעיתים הסמכה כמו PMP. שילוב של ניסיון תפעולי מהצבא עם קורס ממוקד הוא מסלול כניסה נפוץ.',
  salary_range      = '12,000–22,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'מנהל פרויקטים, Project Manager, Scrum Master, Program Manager',
  is_published      = true
WHERE slug = 'project-management';


-- ── graphic-design ───────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Graphic Design',
  short_description = 'Graphic Design הוא מקצוע שעוסק ביצירת חומרים ויזואליים לדיגיטל ולדפוס. מאפשר עבודה שכירה בסוכנויות ובחברות, או עצמאית כפרילנסר.',
  long_description  = 'מעצב גרפי יוצר חומרי שיווק, לוגואים, פוסטים לרשתות חברתיות ומצגות. הכלים הנפוצים הם Adobe Photoshop, Illustrator ו-Canva.

המקצוע מתאים למי שנוח לו עם כלים ויזואליים ורוצה עבודה שמאפשרת ביטוי עצמי. ניתן להשתלב כשכיר במחלקות שיווק וסוכנויות פרסום, או לעבוד כפרילנסר.

הכניסה לתחום דורשת קורס ממוקד ובניית portfolio. בתחום זה הפורטפוליו הוא אמצעי ההערכה המרכזי — פרויקטים מעשיים חשובים לא פחות מהתעודה.',
  salary_range      = '7,000–14,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'מעצב גרפי, Graphic Designer, מעצב דיגיטל, מעצב שיווקי',
  is_published      = true
WHERE slug = 'graphic-design';


-- ── ecommerce-manager ────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Ecommerce Manager',
  short_description = 'Ecommerce Manager הוא מנהל שמוביל את הפעילות המסחרית של חנות אונליין. תפקיד שמשלב ניהול שוטף, שיווק דיגיטלי וניתוח נתונים.',
  long_description  = 'מנהל איקומרס אחראי על הפעלת חנות אונליין — ניהול מוצרים ומלאי, אופטימיזציה של עמודי מוצר, ניהול קמפיינים שיווקיים ומעקב אחר מדדי ביצוע כמו המרות ועגלות נטושות.

התפקיד מתאים למי שיכול לעבוד עם נתונים, מבין שיווק דיגיטלי, ויודע לנהל מספר ערוצים במקביל. ניסיון בניהול, לוגיסטיקה, או ניהול משאבים מהצבא רלוונטי לתפקיד.

הכניסה לתחום אפשרית דרך ניסיון מעשי עם פלטפורמות כמו Shopify ו-WooCommerce, בשילוב קורס בשיווק דיגיטלי. קיים מגוון תפקידים בתחום — מניהול חנות קטנה ועד ניהול מחלקת מסחר דיגיטלי בחברה גדולה.',
  salary_range      = '10,000–18,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'מנהל חנות אונליין, Ecommerce Manager, מנהל מכירות דיגיטליות, Digital Commerce Specialist',
  is_published      = true
WHERE slug = 'ecommerce-manager';

-- ============================================================
-- BEGIN: 004_course_seed_data.sql
-- ============================================================

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

-- ============================================================
-- BEGIN: 005_intent_page_seed.sql
-- ============================================================

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

-- ============================================================
-- BEGIN: 006_intent_page_seed_5b.sql
-- ============================================================

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
  '8,000–15,000 ₪ למתחילים',
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
  '10,000–18,000 ₪ למתחילים',
  '6–12 חודשים',
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

-- BEGIN: 007_quiz_hebrew_text.sql
-- ============================================================
-- Migration: 007_quiz_hebrew_text
-- Project:   Mishtachrerim
-- Phase:     2 (patch)
--
-- Updates quiz_questions and quiz_answers to Hebrew text.
-- The original 002 seed loaded English placeholder text.
-- This migration updates in-place so existing score mappings
-- (quiz_answer_scores) and any previously submitted responses
-- remain intact — only the display text changes.
--
-- Safe to re-run: each UPDATE is idempotent.
-- ============================================================


-- ─── Quiz Questions ───────────────────────────────────────────────────────────

UPDATE public.quiz_questions SET question_text = 'איזה סוג משימות אתה הכי נהנה לבצע?'                    WHERE question_key = 'q1';
UPDATE public.quiz_questions SET question_text = 'עד כמה אתה מרגיש בנוח עם טכנולוגיה?'                   WHERE question_key = 'q2';
UPDATE public.quiz_questions SET question_text = 'איזו סביבת עבודה אתה מעדיף?'                            WHERE question_key = 'q3';
UPDATE public.quiz_questions SET question_text = 'כמה זמן אתה מוכן להשקיע בלימוד מקצוע חדש?'             WHERE question_key = 'q4';
UPDATE public.quiz_questions SET question_text = 'מה מניע אותך הכי הרבה בקריירה?'                        WHERE question_key = 'q5';
UPDATE public.quiz_questions SET question_text = 'האם אתה נהנה לעבוד עם נתונים?'                         WHERE question_key = 'q6';
UPDATE public.quiz_questions SET question_text = 'איזה סגנון למידה מתאים לך ביותר?'                      WHERE question_key = 'q7';
UPDATE public.quiz_questions SET question_text = 'עד כמה אתה מרגיש בנוח עם פתרון בעיות תחת לחץ?'        WHERE question_key = 'q8';
UPDATE public.quiz_questions SET question_text = 'האם אתה נהנה לתכנן ולארגן פרויקטים?'                   WHERE question_key = 'q9';
UPDATE public.quiz_questions SET question_text = 'איזה סוג תוצאות נותן לך הכי הרבה סיפוק?'               WHERE question_key = 'q10';


-- ─── Quiz Answers ────────────────────────────────────────────────────────────
-- Pattern: UPDATE quiz_answers JOIN quiz_questions on question_id
--          filtered by question_key + answer_key.

-- Q1
UPDATE public.quiz_answers qa SET answer_text = 'פתרון בעיות לוגיות או טכניות'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q1' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = 'יצירת ויזואלים או עיצוב'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q1' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'עבודה עם אנשים וארגון עבודה'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q1' AND qa.answer_key = 'c';
UPDATE public.quiz_answers qa SET answer_text = 'ניהול מערכות או תיקון תקלות טכניות'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q1' AND qa.answer_key = 'd';

-- Q2
UPDATE public.quiz_answers qa SET answer_text = 'מאוד בנוח, אני נהנה ללמוד כלים חדשים'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q2' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = 'בנוח, אבל אני מעדיף כלים מובנים'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q2' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'בנוח במידה בינונית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q2' AND qa.answer_key = 'c';
UPDATE public.quiz_answers qa SET answer_text = 'לא מאוד בנוח'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q2' AND qa.answer_key = 'd';

-- Q3
UPDATE public.quiz_answers qa SET answer_text = 'עבודה אנליטית עצמאית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q3' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = 'עבודה יצירתית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q3' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'עבודה טכנית מובנית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q3' AND qa.answer_key = 'c';
UPDATE public.quiz_answers qa SET answer_text = 'עבודת צוות שיתופית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q3' AND qa.answer_key = 'd';

-- Q4
UPDATE public.quiz_answers qa SET answer_text = 'פחות מ-6 חודשים'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q4' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = '6–12 חודשים'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q4' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'יותר משנה'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q4' AND qa.answer_key = 'c';

-- Q5
UPDATE public.quiz_answers qa SET answer_text = 'פוטנציאל שכר גבוה'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q5' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = 'ביטוי יצירתי'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q5' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'עבודה יציבה ומעשית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q5' AND qa.answer_key = 'c';
UPDATE public.quiz_answers qa SET answer_text = 'עבודה עם אנשים והובלת פרויקטים'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q5' AND qa.answer_key = 'd';

-- Q6
UPDATE public.quiz_answers qa SET answer_text = 'כן, אני נהנה לנתח מספרים ודפוסים'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q6' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = 'במידה מסוימת'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q6' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'לא ממש'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q6' AND qa.answer_key = 'c';

-- Q7
UPDATE public.quiz_answers qa SET answer_text = 'למידה טכנית מעשית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q7' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = 'הכשרה מובנית עם משימות ברורות'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q7' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'חקירה יצירתית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q7' AND qa.answer_key = 'c';
UPDATE public.quiz_answers qa SET answer_text = 'למידה אסטרטגית ועסקית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q7' AND qa.answer_key = 'd';

-- Q8
UPDATE public.quiz_answers qa SET answer_text = 'מאוד בנוח'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q8' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = 'בנוח'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q8' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'מעדיף סביבות בקצב איטי יותר'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q8' AND qa.answer_key = 'c';

-- Q9
UPDATE public.quiz_answers qa SET answer_text = 'כן, מאוד'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q9' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = 'לפעמים'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q9' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'לא ממש'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q9' AND qa.answer_key = 'c';

-- Q10
UPDATE public.quiz_answers qa SET answer_text = 'בניית מערכות עובדות'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q10' AND qa.answer_key = 'a';
UPDATE public.quiz_answers qa SET answer_text = 'מציאת תובנות בנתונים'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q10' AND qa.answer_key = 'b';
UPDATE public.quiz_answers qa SET answer_text = 'עיצוב משהו מושך ויזואלית'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q10' AND qa.answer_key = 'c';
UPDATE public.quiz_answers qa SET answer_text = 'השקת קמפיינים או יוזמות עסקיות'
  FROM public.quiz_questions q WHERE qa.question_id = q.id AND q.question_key = 'q10' AND qa.answer_key = 'd';
