\# QUIZ\_SYSTEM\_SPEC.md



Quiz System Specification

Project: משתחררים (Mishtachrerim)



This document describes the architecture and behavior of the quiz system.



The quiz is the core interactive component of the product and powers

the Decision Engine.



The purpose of the quiz is to evaluate user preferences and produce

career path recommendations.



The quiz does not attempt to produce a psychological profile.



Instead it provides a fast signal about which career paths might

fit the user best.



--------------------------------------------------



\# 1. Quiz Role in the Product



The quiz is the transition point between:



Information

and

Decision.



Typical product flow:



SEO Page / Guide

→ Quiz

→ Career Recommendation

→ Career Page

→ Courses



The quiz therefore acts as the central decision engine.



--------------------------------------------------



\# 2. Quiz Modes



The system supports two quiz modes.



Quick Quiz



Questions:

5



Purpose:

Fast recommendation.



Used when:

User arrives from SEO or homepage.



Expected completion time:

1–2 minutes.



--------------------------------------------------



Deep Quiz



Questions:

10



Purpose:

More accurate recommendation.



Used when:

User explicitly chooses deeper evaluation.



Expected completion time:

3–4 minutes.



--------------------------------------------------



\# 3. Question Source



Questions are defined in:



QUIZ\_QUESTION\_BANK.md



This file defines:



Questions

Answers

Score mappings

Career relationships



The system reads questions dynamically.



--------------------------------------------------



\# 4. Data Tables Used



The quiz system uses the following database tables.



quiz\_questions



Stores the question text and order.



Fields:



id

question\_text\_he

question\_order

is\_deep\_quiz\_only



--------------------------------------------------



quiz\_answers



Stores possible answers for each question.



Fields:



id

question\_id

answer\_text\_he

answer\_key



--------------------------------------------------



quiz\_answer\_scores



Defines scoring mapping between answers and careers.



Fields:



answer\_id

career\_path\_id

score



Example mapping:



Answer: "פתרון בעיות טכניות"



QA Tester +3

Data Analyst +2

IT Support +2



--------------------------------------------------



quiz\_results



Stores quiz attempts.



Fields:



id

user\_id

created\_at



Users may take quiz without login.



user\_id may be null.



--------------------------------------------------



quiz\_result\_careers



Stores career matches for each quiz attempt.



Fields:



id

quiz\_result\_id

career\_path\_id

score

rank



Example:



rank 1 → QA Tester

rank 2 → Data Analyst

rank 3 → Digital Marketing



--------------------------------------------------



\# 5. Quiz Execution Flow



Step 1



User starts quiz.



Event tracked:



quiz\_started



--------------------------------------------------



Step 2



System loads questions from database.



Quick Quiz:

first 5 questions.



Deep Quiz:

all 10 questions.



--------------------------------------------------



Step 3



User answers questions.



Answers are temporarily stored in client state.



--------------------------------------------------



Step 4



Submit quiz answers.



Answers sent to server.



--------------------------------------------------



Step 5



Matching engine calculates scores.



Logic defined in:



MATCHING\_ENGINE\_LOGIC.md



--------------------------------------------------



Step 6



System creates quiz\_results record.



--------------------------------------------------



Step 7



System inserts rows into quiz\_result\_careers.



Each row represents one career match.



--------------------------------------------------



Step 8



Results page loads.



Top 3 careers displayed.



--------------------------------------------------



\# 6. Matching Engine



Matching engine logic is documented in:



MATCHING\_ENGINE\_LOGIC.md



Summary:



1 Initialize career scores



2 Add score for each answer



3 Sort careers by score



4 Select top careers



--------------------------------------------------



\# 7. Result Display



The results page shows:



Top 3 recommended careers.



Each card displays:



career name

short explanation

salary range

training time



CTA:



View career path



--------------------------------------------------



\# 8. Explanation Logic



Each result should include a short explanation.



Example:



You might enjoy QA Tester because:



You like technical problem solving

You pay attention to details

You prefer structured tasks



Explanation logic may use templates.



--------------------------------------------------



\# 9. Analytics Events



The quiz generates analytics events.



quiz\_started



quiz\_question\_answered



quiz\_completed



results\_viewed



career\_clicked



These events help measure:



completion rate

career interest

conversion funnel



--------------------------------------------------



\# 10. Performance Requirements



The quiz engine must be:



Fast

Stateless

Deterministic



Expected runtime for matching engine:



<10ms



--------------------------------------------------



\# 11. Security Rules



Quiz scoring logic must run on the server.



Client code should never calculate career scores.



This prevents manipulation of results.



--------------------------------------------------



\# 12. UX Principles



The quiz should feel:



Fast

Simple

Insightful



Avoid long explanations.



Momentum toward results is critical.



--------------------------------------------------



\# 13. Phase 1 Constraints



Maximum questions:



10



Supported careers:



10–15



Scoring model:



Score-based only.



No machine learning.



--------------------------------------------------



\# 14. Future Extensions



Future improvements may include:



Adaptive question order

Confidence scoring

Behavior signals

Machine learning models



These are not required for Phase 1.



--------------------------------------------------



\# 15. Design Philosophy



The quiz must remain:



Explainable

Predictable

Transparent



Users should understand why a career was recommended.



Avoid black-box recommendations.

