# DATA_MODEL.md

Data Model
Project: משתחררים (Mishtachrerim)

This document defines the database schema used by the Mishtachrerim platform.

The database is implemented using PostgreSQL.

The schema supports:

* career recommendation quiz
* career path content
* course listings
* SEO guides
* checklist tracking
* user accounts
* analytics events
* lead collection

---

# 1. Core Entities

The system revolves around the following core entities.

users
career_paths
courses
guides
checklist_items
quiz_questions
quiz_answers
quiz_answer_scores
quiz_results
quiz_result_careers
leads

---

# 2. Users

Table

users

Purpose

Stores registered users.

Users are created via Supabase Auth.

Fields

id
uuid
primary key

email
text

created_at
timestamp

last_login_at
timestamp

auth_provider
text

Possible values:

google
email

---

# 3. Career Paths

Table

career_paths

Purpose

Defines the curated career paths used by the recommendation engine.

Fields

id
uuid
primary key

slug
text
unique

title
text

short_description
text

long_description
text

salary_range
text

training_time
text

difficulty_level
text

example_roles
text

is_published
boolean

created_at
timestamp

updated_at
timestamp

Example records

qa-tester
data-analyst
digital-marketing
it-support
project-management
graphic-design
ecommerce-manager
network-technician
full-stack-developer
ux-ui-designer

---

# 4. Courses

Table

courses

Purpose

Stores curated training programs.

Fields

id
uuid
primary key

slug
text
unique

title
text

provider_name
text

career_path_id
uuid
foreign key → career_paths.id

description
text

duration
text

learning_mode
text

Possible values

online
in-person
hybrid

price_range
text

deposit_eligible
boolean

editorial_rating
numeric

provider_url
text

is_published
boolean

created_at
timestamp

updated_at
timestamp

---

# 5. Guides

Table

guides

Purpose

Stores SEO informational articles.

Fields

id
uuid
primary key

slug
text
unique

title
text

summary
text

content
text

author_name
text

is_published
boolean

created_at
timestamp

updated_at
timestamp

---

# 6. Checklist Items

Table

checklist_items

Purpose

Defines tasks users should complete after discharge.

Fields

id
uuid
primary key

title
text

description
text

display_order
integer

is_published
boolean

created_at
timestamp

updated_at
timestamp

---

# 7. User Checklist Progress

Table

user_checklist_items

Purpose

Tracks checklist completion for logged-in users.

Fields

id
uuid
primary key

user_id
uuid
foreign key → users.id

checklist_item_id
uuid
foreign key → checklist_items.id

completed
boolean

completed_at
timestamp

---

# 8. Quiz Questions

Table

quiz_questions

Purpose

Stores quiz questions.

Fields

id
uuid
primary key

question_key
text
unique

question_text
text

display_order
integer

is_active
boolean

created_at
timestamp

updated_at
timestamp

Example

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

# 9. Quiz Answers

Table

quiz_answers

Purpose

Stores answer options for each question.

Fields

id
uuid
primary key

question_id
uuid
foreign key → quiz_questions.id

answer_key
text

answer_text
text

display_order
integer

created_at
timestamp

updated_at
timestamp

---

# 10. Quiz Answer Scores

Table

quiz_answer_scores

Purpose

Defines score mappings between answers and career paths.

Fields

id
uuid
primary key

answer_id
uuid
foreign key → quiz_answers.id

career_path_id
uuid
foreign key → career_paths.id

score_value
integer

Example

answer_id → q1_a
career_path → data-analyst
score_value → 3

---

# 11. Quiz Results

Table

quiz_results

Purpose

Stores each quiz attempt.

Fields

id
uuid
primary key

user_id
uuid
nullable
foreign key → users.id

quiz_type
text

Possible values

quick
deep

quiz_version
integer

created_at
timestamp

---

# 12. Quiz Result Careers

Table

quiz_result_careers

Purpose

Stores ranked career matches for a quiz result.

Fields

id
uuid
primary key

quiz_result_id
uuid
foreign key → quiz_results.id

career_path_id
uuid
foreign key → career_paths.id

score
integer

rank
integer

Example

quiz_result_id → 123
career_path → full-stack-developer
score → 8
rank → 1

---

# 13. Leads

Table

leads

Purpose

Stores lead form submissions.

Fields

id
uuid
primary key

email
text

phone
text

name
text

source_page
text

course_id
uuid
nullable

created_at
timestamp

---

# 14. Publishing Workflow

The following tables support draft and publish states.

career_paths
courses
guides
checklist_items

Each table includes:

is_published

Editors can:

create
edit
publish
archive

---

# 15. Relationships Overview

Key relationships:

career_paths
1 → many
courses

quiz_questions
1 → many
quiz_answers

quiz_answers
1 → many
quiz_answer_scores

quiz_results
1 → many
quiz_result_careers

users
1 → many
quiz_results

users
1 → many
user_checklist_items

---

# 16. Result Flow

Quiz answers are submitted.

↓

Scores are calculated using:

quiz_answer_scores

↓

Result is created in:

quiz_results

↓

Top ranked careers are stored in:

quiz_result_careers

↓

User visits:

/results/[id]

---

# 17. Admin Editable Data

Admin users must be able to edit:

career_paths
courses
guides
checklist_items
quiz_questions
quiz_answers
quiz_answer_scores

Admin editing must not require code changes.

---

# 18. Data Integrity Rules

The system must enforce:

valid foreign keys
no orphan records
unique slugs
consistent quiz question ordering

Quiz results must always contain at least 3 ranked careers.

---

# 19. Performance Considerations

Indexes should be added for:

career_paths.slug
courses.slug
guides.slug

quiz_results.id
quiz_result_careers.quiz_result_id

quiz_questions.question_key

---

# 20. Future Extensions

Possible schema extensions include:

saved_courses
newsletter_subscribers
career_comparisons
job_listings
user_preferences

These are not required for Phase 1.

---
