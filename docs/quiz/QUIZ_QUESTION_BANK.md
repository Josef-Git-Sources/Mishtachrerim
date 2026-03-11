# QUIZ_QUESTION_BANK.md

Quiz Question Bank
Project: משתחררים (Mishtachrerim)

This document defines the canonical set of quiz questions and scoring mappings used by the career recommendation engine.

This file is the **source of truth for quiz content**.

It defines:

* quiz questions
* answer options
* score mappings to career paths

The scoring algorithm itself is defined in:

MATCHING_ENGINE_LOGIC.md

---

# 1. Supported Career Paths

The quiz evaluates the following curated career paths.

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

Each answer contributes points to one or more of these careers.

All careers start with score:

0

---

# 2. Quiz Modes

The question bank supports two quiz modes.

Quick Quiz

5 questions

Deep Quiz

10 questions

Quick quiz uses the first 5 questions.

Deep quiz uses all 10 questions.

---

# 3. Question Format

Each question includes:

Question ID
Question Text
Answer Options
Score Mappings

Each answer option contributes points to one or more careers.

Example mapping:

Answer A

QA Tester +3
Data Analyst +3
IT Support +2

---

# 4. Question 1

Question ID

q1

Question

What type of tasks do you enjoy the most?

Answers

A
Solving logical or technical problems

Scores

Full Stack Developer +3
Data Analyst +3
QA Tester +2
IT Support +2

B
Creating visuals or designing things

Scores

Graphic Design +3
UX/UI Designer +3
Digital Marketing +1

C
Working with people and organizing work

Scores

Project Management +3
Digital Marketing +2
Ecommerce Manager +2

D
Managing systems or fixing technical issues

Scores

IT Support +3
Network Technician +3
QA Tester +2

---

# 5. Question 2

Question ID

q2

Question

How comfortable are you with technology?

Answers

A
Very comfortable, I enjoy learning new tools

Scores

Full Stack Developer +3
Data Analyst +2
QA Tester +2

B
Comfortable, but I prefer structured tools

Scores

QA Tester +3
IT Support +2
Project Management +1

C
Moderately comfortable

Scores

Digital Marketing +2
Ecommerce Manager +2

D
Not very comfortable

Scores

Project Management +2
Graphic Design +2

---

# 6. Question 3

Question ID

q3

Question

What kind of work environment do you prefer?

Answers

A
Independent analytical work

Scores

Data Analyst +3
Full Stack Developer +2

B
Creative work

Scores

Graphic Design +3
UX/UI Designer +3

C
Structured technical work

Scores

QA Tester +3
IT Support +2

D
Collaborative team work

Scores

Project Management +3
Digital Marketing +2

---

# 7. Question 4

Question ID

q4

Question

How long are you willing to invest in learning a new profession?

Answers

A
Less than 6 months

Scores

QA Tester +3
IT Support +3
Digital Marketing +2

B
6–12 months

Scores

Data Analyst +2
UX/UI Designer +2
Graphic Design +2

C
More than a year

Scores

Full Stack Developer +3
Network Technician +2

---

# 8. Question 5

Question ID

q5

Question

What motivates you the most in a career?

Answers

A
High salary potential

Scores

Full Stack Developer +3
Data Analyst +2
Ecommerce Manager +2

B
Creative expression

Scores

Graphic Design +3
UX/UI Designer +3

C
Stable and practical work

Scores

QA Tester +3
IT Support +3

D
Working with people and leading projects

Scores

Project Management +3
Digital Marketing +2

---

# 9. Question 6 (Deep Quiz Only)

Question ID

q6

Question

Do you enjoy working with data?

Answers

A
Yes, I enjoy analyzing numbers and patterns

Scores

Data Analyst +3
Full Stack Developer +1

B
Somewhat

Scores

Digital Marketing +2
Project Management +1

C
Not really

Scores

Graphic Design +2
UX/UI Designer +2

---

# 10. Question 7 (Deep Quiz Only)

Question ID

q7

Question

What type of learning style suits you best?

Answers

A
Technical hands-on learning

Scores

Full Stack Developer +3
Network Technician +2

B
Structured training with clear tasks

Scores

QA Tester +3
IT Support +2

C
Creative exploration

Scores

Graphic Design +3
UX/UI Designer +3

D
Strategic and business learning

Scores

Digital Marketing +2
Ecommerce Manager +3
Project Management +2

---

# 11. Question 8 (Deep Quiz Only)

Question ID

q8

Question

How comfortable are you with problem solving under pressure?

Answers

A
Very comfortable

Scores

IT Support +3
Network Technician +3

B
Comfortable

Scores

QA Tester +2
Full Stack Developer +2

C
Prefer slower paced environments

Scores

Graphic Design +2
UX/UI Designer +2

---

# 12. Question 9 (Deep Quiz Only)

Question ID

q9

Question

Do you enjoy planning and organizing projects?

Answers

A
Yes, very much

Scores

Project Management +3
Digital Marketing +2

B
Sometimes

Scores

Ecommerce Manager +2
Data Analyst +1

C
Not really

Scores

Full Stack Developer +2
Graphic Design +1

---

# 13. Question 10 (Deep Quiz Only)

Question ID

q10

Question

What type of results give you the most satisfaction?

Answers

A
Building working systems

Scores

Full Stack Developer +3
Network Technician +2

B
Finding insights in data

Scores

Data Analyst +3

C
Designing something visually appealing

Scores

Graphic Design +3
UX/UI Designer +3

D
Launching campaigns or business initiatives

Scores

Digital Marketing +3
Ecommerce Manager +2

---

# 14. Quick Quiz Subset

Quick quiz uses:

q1
q2
q3
q4
q5

---

# 15. Deep Quiz Full Set

Deep quiz uses:

q1
q2
q3
q4
q5
q6
q7
q8
q9
q10

---

# 16. Maintenance Rules

Quiz questions must remain:

Clear
Simple
Actionable

Avoid:

Abstract personality questions
Psychological profiling
Ambiguous answers

Questions should always relate to:

Career preferences
Work style
Learning style
Motivation

---

# 17. Admin Editing

Quiz content should be editable via admin tools.

Editable fields:

question_text
answer_text
score_mappings

The system should allow updating quiz content without changing application code.

---

# 18. Versioning

If quiz logic changes significantly:

A new version of the quiz may be created.

Example:

quiz_version = 1
quiz_version = 2

This allows historical quiz results to remain valid.

---

# 19. Design Philosophy

The quiz should feel:

Fast
Logical
Helpful

Users should feel that the recommendations are clearly connected to their answers.

Avoid:

Black-box recommendations
Overly complex scoring
Confusing questions

---
