# MATCHING_ENGINE_LOGIC.md

Matching Engine Logic
Project: משתחררים (Mishtachrerim)

This document defines the algorithm used to convert quiz answers into recommended career paths.

The matching engine is the core of the Decision Engine.

It receives quiz answers and produces:

Top 3 recommended careers

Each result includes:

Career name
Score
Explanation

---

# 1. Core Concept

The system uses a **score-based matching model**.

Each quiz answer adds points to one or more careers.

At the end of the quiz:

1. Scores are summed
2. Careers are ranked
3. Top 3 careers are returned

The engine must remain:

* deterministic
* explainable
* easy to maintain
* easy to tune

This is not an AI recommendation engine.

It is a transparent scoring engine.

---

# 2. Supported Careers

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

These are the canonical career paths used by the scoring engine.

Each career begins with score:

0

---

# 3. Input Data Structure

The engine receives answers in a normalized structure.

Example:

answers = [
{ questionId: "q1", answerId: "a" },
{ questionId: "q2", answerId: "c" },
{ questionId: "q3", answerId: "b" }
]

Each answer maps to a predefined scoring table.

The engine does not define the question content itself.

The canonical source for quiz questions and score mappings is:

QUIZ_QUESTION_BANK.md

---

# 4. Score Mapping Model

Each answer option corresponds to a score mapping.

Example:

Question 1
Answer A

scores:

QA Tester +3
Data Analyst +3
IT Support +2
Full Stack Developer +2

Equivalent representation:

scores = {
"QA Tester": 3,
"Data Analyst": 3,
"IT Support": 2,
"Full Stack Developer": 2
}

The engine adds these values to the current accumulated score.

---

# 5. Score Accumulation Logic

Algorithm:

1. Initialize all supported career scores to 0
2. For each submitted answer:

   * retrieve the score mapping for that answer
   * add score values to the relevant careers
3. Continue until all answers are processed

Pseudo process:

Initialize all career scores to 0

For each answer:
For each career in scoreMapping:
careerScore += mappingValue

The engine must ignore careers that are not part of the supported phase 1 career set.

---

# 6. Quick Quiz vs Deep Quiz

The engine supports two quiz modes.

Quick Quiz

* 5 questions

Deep Quiz

* 10 questions

The engine logic is identical in both modes.

The difference is only the number of answers processed.

Deep quiz provides more signals and therefore usually produces a more stable ranking.

The engine may persist the quiz type with the result record.

Canonical values:

quick
deep

---

# 7. Ranking Logic

Once scoring finishes:

1. Create a list of careers with final scores
2. Sort by score descending
3. Apply tie-break rules when necessary
4. Select top 3 careers

Example:

sortedCareers = careers.sort(score DESC)

top3 = first 3

The UI should only display the top 3 results.

The system may optionally store more than 3 ranked careers for analytics or future use.

---

# 8. Canonical Tie-Break Logic

If two or more careers have identical scores, apply the following tie-break logic in order.

Tie-Break Rule 1
Prefer the career that matches stronger signals from these dimensions:

* technical preference
* analytical preference
* creative preference
* people/business preference

Tie-Break Rule 2
If still tied, prefer the career whose mapped answers appeared more frequently across the completed quiz.

Tie-Break Rule 3
If still tied, use a fixed deterministic priority order.

Fixed priority order:

1. Full Stack Developer
2. Data Analyst
3. QA Tester
4. UX/UI Designer
5. Digital Marketing
6. IT Support
7. Network Technician
8. Project Management
9. Graphic Design
10. Ecommerce Manager

This rule exists only to keep output deterministic.

Important:

Tie-break logic must always remain deterministic.

The same set of answers must always produce the same ranking.

---

# 9. Example Calculation

User answers:

Q1 → A
Q2 → A
Q3 → C

Example score progression:

After Q1:

QA Tester = 3
Data Analyst = 3
IT Support = 2
Full Stack Developer = 2

After Q2:

Full Stack Developer += 3
QA Tester += 2
Data Analyst += 2
IT Support += 2

After Q3:

Full Stack Developer += 3
IT Support += 2

Final scores:

Full Stack Developer = 8
QA Tester = 5
Data Analyst = 5
IT Support = 4

Top results after ranking and tie-break:

1. Full Stack Developer
2. Data Analyst
3. QA Tester

Note:

The exact output depends on the mappings defined in QUIZ_QUESTION_BANK.md and the tie-break rules above.

---

# 10. Result Output Format

The engine should return results in a normalized structure.

Example:

results = [
{
careerPathSlug: "full-stack-developer",
careerPathName: "Full Stack Developer",
score: 8,
rank: 1
},
{
careerPathSlug: "data-analyst",
careerPathName: "Data Analyst",
score: 5,
rank: 2
},
{
careerPathSlug: "qa-tester",
careerPathName: "QA Tester",
score: 5,
rank: 3
}
]

The engine returns scoring output only.

The UI layer and content layer attach additional metadata such as:

* career description
* salary range
* training time
* how to start
* related guides
* related courses

---

# 11. Result Explanation Logic

Each result should include a short explanation layer derived from answers.

The engine itself does not need to generate long natural-language text.

Instead it should return explanation signals or tags.

Example explanation signals:

* technical_interest
* analytical_preference
* creative_preference
* short_training_preference
* structured_work_preference
* people_oriented_preference

The presentation layer can transform these into user-facing text.

Example user-facing explanation:

"You showed strong interest in structured technical work and problem solving."

This keeps the engine simple and the UI flexible.

---

# 12. Result Persistence

After calculating the sorted career scores, the system must persist the results.

The persistence model uses two tables:

quiz_results
quiz_result_careers

Step 1

Create a quiz_results record.

Suggested fields:

id
user_id
quiz_type
created_at

Example:

quiz_results

id: 123
user_id: null
quiz_type: quick

Step 2

Store ranked career matches in quiz_result_careers.

Suggested fields:

quiz_result_id
career_path_id
score
rank

Example:

quiz_result_id: 123
career_path_id: full-stack-developer
score: 8
rank: 1

quiz_result_id: 123
career_path_id: data-analyst
score: 5
rank: 2

quiz_result_id: 123
career_path_id: qa-tester
score: 5
rank: 3

The UI only displays the top 3 results.

The system may store additional ranked careers for analytics.

---

# 13. Anonymous vs Logged-In Behavior

Anonymous users can:

* complete the quiz
* receive a results page
* view the results page at /results/[id]

Logged-in users can additionally:

* save results to their account
* revisit past results from the dashboard

Authentication is handled by:

Supabase Auth

Supported methods:

Google OAuth
Email login

---

# 14. Minimum Score Threshold

Optional rule for Phase 1:

If all scores are extremely low or clustered too closely, the system may still return the top 3 careers but also show a general clarification message.

Example:

"ייתכן שכדאי לבדוק כמה כיוונים לפני קבלת החלטה."

This is optional.

Phase 1 can work without a minimum threshold rule.

---

# 15. Performance Requirements

The matching engine must be:

Fast
Stateless
Deterministic

Expected runtime:

well below 50ms in normal server execution

The engine should not depend on network requests during score calculation.

It should operate entirely on local mappings and submitted answers.

---

# 16. Implementation Location

The matching engine should be implemented in:

Server logic or API layer

Suggested path:

/lib/matching-engine.ts

The UI must never implement scoring logic directly.

The UI may call a server action, route handler, or backend service that runs the engine.

---

# 17. Testing Requirements

Unit tests should validate:

* correct score accumulation
* correct ranking
* correct top 3 selection
* correct tie-break behavior
* deterministic output
* correct behavior for quick and deep quiz modes

Test examples:

* identical answer sets
* mixed answers
* tie cases
* incomplete input rejection
* unsupported answer mapping rejection

---

# 18. Validation Rules

Before score calculation begins, the system should validate:

* the submitted answers belong to the expected quiz mode
* question ids are valid
* answer ids are valid
* duplicate answers for the same question are rejected
* missing required answers are rejected

If validation fails, the engine should not calculate results.

Instead it should return a controlled error to the application layer.

---

# 19. Product Constraints

The engine must remain:

* explainable
* editable by product and admin logic
* deterministic
* easy to tune

It must not become:

* black-box AI
* opaque scoring
* uncontrolled recommendation logic

Courses and guides are not generated by the engine.

They are attached later through curated relationships in the product data model.

---

# 20. Future Improvements

Possible future improvements:

* weighted dimensions
* quiz-mode-specific weighting
* stronger explanation generation
* probability scoring layer
* behavior-based personalization
* A/B testing of scoring logic

These are future options.

None of them are required for Phase 1.

---

# 21. Design Philosophy

The system must be:

Simple
Explainable
Predictable

Users should feel the result is logical.

The recommendation must feel grounded in the answers they gave.

Avoid black-box behavior.
