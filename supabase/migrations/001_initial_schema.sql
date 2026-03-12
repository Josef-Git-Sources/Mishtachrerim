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
