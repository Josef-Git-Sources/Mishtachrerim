# QUIZ_SYSTEM_SPEC.md

Quiz System Specification
Project: משתחררים (Mishtachrerim)

This document defines the product behavior, structure, and user flow of the career decision quiz.

The quiz is the core interactive component of the product and acts as the main bridge between informational content and career recommendations.

The quiz helps discharged soldiers identify potential career directions that fit their preferences, interests, and constraints.

---

# 1. Purpose of the Quiz

The quiz exists to solve a core user problem:

Users finishing military service often do not know which career direction to pursue.

The quiz helps them:

* narrow down options
* discover career paths
* understand possible directions
* move from uncertainty to actionable next steps

The quiz produces:

Top 3 career path recommendations.

Each recommendation links to a detailed career path page.

---

# 2. Quiz Philosophy

The quiz is designed to be:

Simple
Fast
Explainable
Practical

The system must avoid:

* black box recommendations
* overly complex psychological profiling
* long personality questionnaires

Instead the system focuses on:

Preferences
Interests
Constraints
Motivation signals

The system is deterministic.

Meaning:

The same answers will always produce the same results.

---

# 3. Quiz Types

The system supports two quiz modes.

Quick Quiz
Deep Quiz

---

# 3.1 Quick Quiz

Quick quiz is designed for fast interaction.

Number of questions:

5

Average completion time:

1–2 minutes

Goal:

Provide a fast directional recommendation.

The quick quiz is the primary entry experience for most users.

---

# 3.2 Deep Quiz

Deep quiz is designed for users who want a more refined recommendation.

Number of questions:

10

Average completion time:

3–5 minutes

Goal:

Provide a more accurate recommendation using additional signals.

Deep quiz includes:

* all core preference questions
* additional questions about learning style, commitment, and constraints

---

# 4. Quiz Flow

The standard quiz flow is:

Start Quiz

↓

Answer Questions

↓

Calculate Scores

↓

Determine Top Careers

↓

Display Results

↓

User explores Career Pages

↓

User explores Courses

---

# 5. Question Categories

Questions are grouped into categories that reflect decision signals.

Examples of categories include:

Interest preference
Work style preference
Learning preference
Commitment level
Income expectations
Time investment tolerance

Each question belongs to one category.

---

# 6. Question Structure

Each question includes:

Question text
Answer options
Score mappings

Answer options map to one or more career paths.

Example structure:

Question

Answer Option A
Answer Option B
Answer Option C
Answer Option D

Each answer contributes points to one or more career paths.

---

# 7. Question Source of Truth

The canonical source for quiz questions and scoring mappings is:

QUIZ_QUESTION_BANK.md

This file defines:

* the full set of quiz questions
* answer options
* score mappings to career paths

The question bank is shared between the quick quiz and the deep quiz.

Quick quiz uses a subset of the question bank.

---

# 8. Scoring Engine

The scoring algorithm is defined in:

MATCHING_ENGINE_LOGIC.md

The algorithm is responsible for:

* initializing career scores
* applying answer mappings
* calculating total scores
* determining the top results

QUIZ_SYSTEM_SPEC.md does not define scoring rules.

It only defines the quiz structure and behavior.

---

# 9. Career Path Universe

The quiz evaluates a fixed set of curated career paths.

Examples include:

QA Tester
Data Analyst
Digital Marketing
Network Technician
IT Support
Ecommerce Manager

Each answer contributes points to one or more of these career paths.

---

# 10. Result Selection

After all answers are submitted:

The system ranks career paths by score.

The system selects:

Top 3 careers.

These careers are presented to the user on the results page.

Each result includes:

Career title
Short explanation
Key characteristics
Link to career path page

---

# 11. Results Page Behavior

The results page is accessible at:

/results/[id]

Each quiz completion creates a stored result record.

The stored result includes:

Selected answers
Career scores
Top career results

Results can be:

Viewed anonymously
Saved to a user account if logged in

---

# 12. Explanation Layer

Results should not feel random.

Each recommended career should include an explanation.

Example explanation types:

"You showed interest in analytical work and structured problem solving."

"You indicated preference for technical skills and practical training."

"You prefer careers with relatively short training paths."

These explanations are derived from the user's answers.

---

# 13. Career Page Bridge

Each recommended career links to a career path page.

Example:

/career/qa-tester
/career/data-analyst

The career page then becomes the next decision layer.

Career pages provide:

* deeper information
* salary insights
* training paths
* recommended courses

---

# 14. Login and Saving Behavior

Users are not required to log in to take the quiz.

Anonymous users can:

* take the quiz
* view results

Logged-in users can additionally:

* save results
* revisit results later
* track their planning progress

Authentication is handled via:

Supabase Auth

Supported methods:

Google OAuth
Email login

---

# 15. Analytics Events

Important events to track include:

quiz_start
quiz_question_answered
quiz_complete
results_view
career_page_click

These events help evaluate quiz performance and conversion rates.

---

# 16. Admin Editing

Quiz content must be editable via the admin system.

Admin capabilities include:

Create questions
Edit questions
Add answer options
Adjust score mappings
Enable or disable questions

The admin system should allow updating the quiz without requiring code changes.

---

# 17. Future Quiz Extensions

Possible future extensions include:

More career paths
More specialized quizzes
Adaptive quiz logic
Career filtering options
Personalized recommendations

These features are optional and not required for Phase 1.

