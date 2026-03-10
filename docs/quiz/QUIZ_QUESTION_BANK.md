\# QUIZ\_QUESTION\_BANK.md



Quiz Question Bank

Project: משתחררים (Mishtachrerim)



This document defines the full question bank for the career matching quiz.



The quiz is one of the core components of the product because it drives the

Decision Engine.



The goal of the quiz is NOT to produce a psychological profile.



The goal is to quickly estimate which career paths may fit the user.



The system uses \*\*score-based matching\*\*.



Each answer adds points to specific career paths.



The system returns the \*\*Top 3 careers with the highest score\*\*.



---



\# 1. Quiz Modes



There are two quiz modes.



Quick Quiz  

5 questions



Deep Quiz  

10 questions



The first 5 questions are identical in both modes.



The Deep Quiz adds additional questions.



---



\# 2. Supported Career Paths



Phase 1 careers:



QA Tester  

Digital Marketing  

Data Analyst  

IT Support  

Project Management  

Graphic Design  

Ecommerce Manager  

Network Technician  

Full Stack Developer  

UX/UI Designer



Each answer will add points to one or more of these careers.



---



\# 3. Scoring Model



Each answer adds:



+1 to +3 points



Example:



Answer:  

"I enjoy technical problem solving"



Scoring:



+3 Data Analyst  

+2 QA Tester  

+2 Full Stack  

+1 IT Support



---
---

# 3.1 Database Mapping

The quiz scoring model is implemented in the database.

The following tables are used:

quiz_questions
quiz_answers
quiz_answer_scores

Structure:

quiz_questions

id
question_text_he
question_order
is_deep_quiz_only

quiz_answers

id
question_id
answer_text_he
answer_key

quiz_answer_scores

answer_id
career_path_id
score

Each answer can contribute score
to multiple career paths.

Example:

answer_id: Q1_A

QA Tester → +3
Data Analyst → +3
IT Support → +2
Full Stack Developer → +2


\# 4. Question Categories



Questions measure several dimensions:



Technical inclination  

Creativity  

Analytical thinking  

People orientation  

Work style  

Business orientation



Each career path has a different profile across these dimensions.



---



\# 5. Core Quiz Questions (Quick Quiz)



These are the most important questions.



---



\# Question 1



What type of tasks do you enjoy the most?



Hebrew:



איזה סוג משימות אתם הכי נהנים לעשות?



Answers:



A  

פתרון בעיות טכניות



Scores:



+3 QA Tester  

+3 Data Analyst  

+2 IT Support  

+2 Full Stack Developer



---



B  

עבודה יצירתית



Scores:



+3 Graphic Design  

+3 UX/UI Designer  

+2 Digital Marketing



---



C  

ניתוח מידע והסקת מסקנות



Scores:



+3 Data Analyst  

+2 Project Management  

+1 QA Tester



---



D  

עבודה עם אנשים וניהול תהליכים



Scores:



+3 Project Management  

+2 Digital Marketing  

+1 Ecommerce



---



\# Question 2



What type of work environment do you prefer?



Hebrew:



איזה סוג סביבת עבודה אתם מעדיפים?



Answers:



A  

עבודה עם מחשבים וטכנולוגיה



Scores:



+3 Full Stack Developer  

+2 QA Tester  

+2 Data Analyst  

+2 IT Support



---



B  

עבודה יצירתית עם עיצוב ורעיונות



Scores:



+3 Graphic Design  

+3 UX/UI Designer



---



C  

עבודה עם נתונים וניתוח מידע



Scores:



+3 Data Analyst  

+2 Digital Marketing



---



D  

עבודה עסקית ושיווקית



Scores:



+3 Digital Marketing  

+2 Ecommerce Manager



---



\# Question 3



Which statement describes you best?



Hebrew:



איזה משפט הכי מתאר אתכם?



Answers:



A  

אני שם לב לפרטים קטנים



Scores:



+3 QA Tester  

+2 Data Analyst



---



B  

אני אוהב לחשוב על רעיונות יצירתיים



Scores:



+3 Graphic Design  

+2 UX/UI Designer



---



C  

אני נהנה להבין איך דברים עובדים



Scores:



+3 Full Stack Developer  

+2 IT Support



---



D  

אני נהנה לנהל משימות ואנשים



Scores:



+3 Project Management



---



\# Question 4



How comfortable are you with technology?



Hebrew:



עד כמה אתם מרגישים בנוח עם טכנולוגיה?



Answers:



A  

מאוד נוח לי לעבוד עם טכנולוגיה



Scores:



+3 Full Stack Developer  

+2 Data Analyst  

+2 QA Tester  

+2 IT Support



---



B  

נוח לי, אבל לא בצורה מאוד טכנית



Scores:



+2 Digital Marketing  

+2 Project Management



---



C  

אני מעדיף תחומים פחות טכנולוגיים



Scores:



+3 Graphic Design  

+2 UX/UI Designer



---



\# Question 5



What kind of work impact interests you?



Hebrew:



איזה סוג השפעה בעבודה מושך אתכם?



Answers:



A  

לבנות מערכות ומוצרים



Scores:



+3 Full Stack Developer  

+2 QA Tester



---



B  

לעזור לחברות להבין נתונים



Scores:



+3 Data Analyst



---



C  

לעצב חוויות ומוצרים



Scores:



+3 UX/UI Designer  

+3 Graphic Design



---



D  

לעזור לחברות לצמוח עסקית



Scores:



+3 Digital Marketing  

+2 Ecommerce Manager  

+2 Project Management



---



\# 6. Additional Questions (Deep Quiz)



These questions appear only in the deep quiz.



---



\# Question 6



How do you prefer to solve problems?



Hebrew:



איך אתם מעדיפים לפתור בעיות?



Answers:



A  

באמצעות ניתוח נתונים



Scores:



+3 Data Analyst



---



B  

באמצעות בדיקות וניסויים



Scores:



+3 QA Tester



---



C  

באמצעות רעיונות יצירתיים



Scores:



+3 Graphic Design  

+2 UX/UI Designer



---



D  

באמצעות תכנון וניהול



Scores:



+3 Project Management



---



\# Question 7



What type of learning interests you?



Hebrew:



איזה סוג למידה מושך אתכם?



Answers:



A  

קוד ותכנות



Scores:



+3 Full Stack Developer



---



B  

כלים לניתוח נתונים



Scores:



+3 Data Analyst



---



C  

עיצוב וחוויית משתמש



Scores:



+3 UX/UI Designer  

+2 Graphic Design



---



D  

שיווק דיגיטלי ועסקים



Scores:



+3 Digital Marketing  

+2 Ecommerce Manager



---



\# Question 8



Which activity sounds most interesting?



Hebrew:



איזו פעילות נשמעת לכם הכי מעניינת?



Answers:



A  

בדיקת אפליקציות



Scores:



+3 QA Tester



---



B  

בניית אתר



Scores:



+3 Full Stack Developer



---



C  

ניתוח נתונים של משתמשים



Scores:



+3 Data Analyst



---



D  

ניהול קמפיינים שיווקיים



Scores:



+3 Digital Marketing



---



\# Question 9



What motivates you more?



Hebrew:



מה יותר מניע אתכם?



Answers:



A  

פתרון בעיות מורכבות



Scores:



+2 Data Analyst  

+2 Full Stack



---



B  

יצירת דברים חדשים



Scores:



+3 Graphic Design  

+2 UX/UI Designer



---



C  

השגת תוצאות עסקיות



Scores:



+3 Digital Marketing  

+2 Ecommerce Manager



---



D  

ארגון תהליכים



Scores:



+3 Project Management



---



\# Question 10



What pace of work do you prefer?



Hebrew:



איזה קצב עבודה אתם מעדיפים?



Answers:



A  

עבודה עמוקה ומרוכזת



Scores:



+3 Data Analyst  

+2 Full Stack



---



B  

עבודה עם משימות מגוונות



Scores:



+3 Digital Marketing  

+2 Project Management



---



C  

עבודה יצירתית



Scores:



+3 Graphic Design  

+2 UX/UI Designer



---



D  

עבודה טכנית מסודרת



Scores:



+3 QA Tester  

+2 IT Support



---



\# 7. Result Generation



Process:



1\. Initialize score = 0 for all careers

2\. Add score for each answer

3\. Sort careers by score

4\. Return top 3 careers



---



\# 8. Result Explanation



Each result should include a short explanation.



Example:



QA Tester might be recommended because:



\- You prefer structured technical work

\- You pay attention to details

\- You enjoy problem solving



---



\# 9. Tie-Break Logic



If multiple careers have identical scores:



Priority rules:



1\. Careers with stronger technical signals first

2\. Careers with stronger data signals second

3\. Creative careers third



This avoids random ordering.



---



\# 10. Future Improvements



Possible improvements:



More questions  

Personality dimensions  

Learning preference scoring  

Experience signals



These are not required for Phase 1.



---



\# 11. Design Principle



The quiz must feel:



Fast  

Simple  

Insightful



It should not feel like a long psychological test.



Users should complete it within:



1–2 minutes (Quick Quiz)  

3–4 minutes (Deep Quiz)

