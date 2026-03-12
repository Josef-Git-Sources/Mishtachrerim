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
JOIN public.career_paths cp  ON cp.slug = v.career_slug
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
WHERE q.question_key = 'q1' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q2 scores
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
JOIN public.career_paths cp  ON cp.slug = v.career_slug
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
WHERE q.question_key = 'q2' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q3 scores
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
JOIN public.career_paths cp  ON cp.slug = v.career_slug
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
WHERE q.question_key = 'q3' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q4 scores
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
JOIN public.career_paths cp  ON cp.slug = v.career_slug
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
WHERE q.question_key = 'q4' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q5 scores
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
JOIN public.career_paths cp  ON cp.slug = v.career_slug
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
WHERE q.question_key = 'q5' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q6 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
JOIN public.career_paths cp  ON cp.slug = v.career_slug
CROSS JOIN (VALUES
  ('a', 'data-analyst',         3),
  ('a', 'full-stack-developer', 1),
  ('b', 'digital-marketing',    2),
  ('b', 'project-management',   1),
  ('c', 'graphic-design',       2),
  ('c', 'ux-ui-designer',       2)
) AS v(answer_key, career_slug, score_value)
WHERE q.question_key = 'q6' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q7 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
JOIN public.career_paths cp  ON cp.slug = v.career_slug
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
WHERE q.question_key = 'q7' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q8 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
JOIN public.career_paths cp  ON cp.slug = v.career_slug
CROSS JOIN (VALUES
  ('a', 'it-support',           3),
  ('a', 'network-technician',   3),
  ('b', 'qa-tester',            2),
  ('b', 'full-stack-developer', 2),
  ('c', 'graphic-design',       2),
  ('c', 'ux-ui-designer',       2)
) AS v(answer_key, career_slug, score_value)
WHERE q.question_key = 'q8' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q9 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
JOIN public.career_paths cp  ON cp.slug = v.career_slug
CROSS JOIN (VALUES
  ('a', 'project-management',   3),
  ('a', 'digital-marketing',    2),
  ('b', 'ecommerce-manager',    2),
  ('b', 'data-analyst',         1),
  ('c', 'full-stack-developer', 2),
  ('c', 'graphic-design',       1)
) AS v(answer_key, career_slug, score_value)
WHERE q.question_key = 'q9' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;

-- Q10 scores (deep quiz only)
INSERT INTO public.quiz_answer_scores (answer_id, career_path_id, score_value)
SELECT qa.id, cp.id, v.score_value
FROM public.quiz_answers qa
JOIN public.quiz_questions q ON q.id = qa.question_id
JOIN public.career_paths cp  ON cp.slug = v.career_slug
CROSS JOIN (VALUES
  ('a', 'full-stack-developer', 3),
  ('a', 'network-technician',   2),
  ('b', 'data-analyst',         3),
  ('c', 'graphic-design',       3),
  ('c', 'ux-ui-designer',       3),
  ('d', 'digital-marketing',    3),
  ('d', 'ecommerce-manager',    2)
) AS v(answer_key, career_slug, score_value)
WHERE q.question_key = 'q10' AND qa.answer_key = v.answer_key
ON CONFLICT (answer_id, career_path_id) DO NOTHING;
