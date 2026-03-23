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
