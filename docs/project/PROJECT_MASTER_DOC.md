# PROJECT_MASTER_DOC.md

Project Master Document
Project: משתחררים (Mishtachrerim)

This document serves as the primary overview and entry point for the Mishtachrerim project.

It explains the purpose of the product, the core architecture, and the relationships between the different system components.

All developers and AI coding agents should read this document before working on the project.

---

# 1. Project Overview

Mishtachrerim is a career decision platform designed for discharged soldiers in Israel.

The platform helps users decide their next professional step after military service.

It combines:

SEO-driven content
Interactive decision tools
Curated training recommendations

The goal is to help users move from uncertainty to a clear career direction.

---

# 2. Core Product Concept

The product is designed as a **Decision Engine**.

Users arrive through search engines or direct visits.

They are guided through a structured flow that helps them explore career options and training paths.

Core flow:

SEO Page or Guide

↓

Quiz

↓

Results (Top 3 Career Paths)

↓

Career Path Page

↓

Courses

This flow moves users from:

Information
→ Decision
→ Action

---

# 3. Primary User

Primary audience:

Discharged soldiers in Israel

Typical age range:

21–27

Common needs:

Career exploration
Practical training programs
Short learning paths
Clear guidance on next steps

Users often search for:

"What should I study after army?"

"What professions can I learn without a degree?"

"How to become a QA tester?"

The platform answers these questions through structured content and tools.

---

# 4. System Architecture

The system is designed as:

Static SEO site + Interactive product features.

Core layers include:

SEO Content Layer
Interactive Decision Layer
Data and Service Layer

Frontend framework:

Next.js (App Router)

Database:

PostgreSQL

Hosting:

Vercel

Authentication:

Supabase Auth

Supported login methods:

Google OAuth
Email login

---

# 5. Key Product Components

The platform includes several main components.

Checklist
Guides
Quiz
Results
Career Path Pages
Courses
Editorial Course Pages
User Dashboard
Admin System

Each component plays a role in the user journey.

---

# 6. Checklist

Route:

/checklist

Purpose:

Provide a simple checklist for discharged soldiers.

Examples of checklist items:

Use army deposit funds
Explore career options
Research training programs
Prepare resume
Start professional training

Checklist progress can optionally be saved by logged-in users.

---

# 7. Guides

Routes:

/guides
/guides/[slug]

Purpose:

SEO content that captures informational search queries.

Examples:

what-to-do-after-army
how-to-use-army-deposit
professions-without-degree

Guides build trust and guide users toward the quiz or career exploration.

---

# 8. Quiz

Routes:

/quiz
/quiz/deep

Purpose:

Help users discover suitable career paths.

Quiz modes:

Quick Quiz (5 questions)
Deep Quiz (10 questions)

The quiz produces:

Top 3 recommended career paths.

Quiz system documentation:

/docs/quiz/QUIZ_SYSTEM_SPEC.md

---

# 9. Matching Engine

The career matching engine converts quiz answers into career recommendations.

Algorithm documentation:

/docs/quiz/MATCHING_ENGINE_LOGIC.md

Question bank and score mappings:

/docs/quiz/QUIZ_QUESTION_BANK.md

The system uses a deterministic scoring model.

Each answer adds points to one or more careers.

At the end of the quiz:

Careers are ranked and the top 3 results are returned.

---

# 10. Results Page

Route:

/results/[id]

Each quiz completion generates a stored result.

Results include:

Top 3 career recommendations
Match explanations
Links to career pages

Results can be viewed without login.

Logged-in users can save results.

---

# 11. Career Path Pages

Route:

/career/[slug]

Examples:

/career/qa-tester
/career/data-analyst
/career/digital-marketing

Career pages are central to the platform.

They serve as:

SEO landing pages
Trust pages
Course hubs
Conversion bridges

Each career page includes:

Career overview
Salary range
Training time
Pros and cons
How to start
Recommended courses

---

# 12. Courses

Routes:

/courses
/courses/[slug]

Purpose:

Display curated training programs related to career paths.

Courses are primarily discovered through career pages.

Course detail pages include:

Provider information
Course duration
Learning mode
Price range
Editorial rating
Deposit eligibility

---

# 13. Editorial Course Pages

Route:

/courses/editorial/[slug]

Examples:

/courses/editorial/best-qa-courses
/courses/editorial/top-digital-marketing-courses

These pages compare training programs and capture commercial search queries.

---

# 14. Course Comparison

Route:

/courses/compare

Purpose:

Allow users to compare curated courses.

Comparison attributes include:

Duration
Learning mode
Difficulty
Price range
Deposit eligibility

---

# 15. User Accounts

Authentication is handled through Supabase Auth.

Supported login methods:

Google OAuth
Email login

Users can optionally create accounts.

Benefits of login:

Save quiz results
Save courses
Track checklist progress

User dashboard routes:

/dashboard
/dashboard/results
/dashboard/courses
/dashboard/checklist
/dashboard/profile

---

# 16. Admin System

The admin system allows content management.

Editable entities include:

career paths
courses
guides
checklist items
quiz questions
quiz answers
score mappings

Admin routes are not part of the public SEO structure.

---

# 17. SEO Strategy

Organic search is the primary acquisition channel.

SEO page types include:

Guides
Intent Pages
Career Path Pages
Editorial Course Pages

SEO documentation:

/docs/seo/SEO_STRATEGY.md

Intent page structure:

/docs/seo/INTENT_PAGE_STRATEGY.md

---

# 18. Data Model

The database schema is defined in:

/docs/data/DATA_MODEL.md

Key tables include:

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

# 19. Phase 1 Scope

Phase 1 includes the following features.

Homepage
Checklist
Guides
Quiz
Results
Career pages
Courses
Editorial course pages
Course comparison
User accounts
Dashboard
Admin tools

---

# 20. Development Guidelines

The documentation in the /docs folder is the source of truth.

Developers and AI coding agents must follow the architecture defined in the documentation.

If contradictions appear between documents:

Stop and clarify before implementing changes.

Do not invent new architecture without documentation updates.

---

# 21. Development Workflow

Development is performed in the cloud using Claude Code.

Typical workflow:

Read project documentation

Implement small features aligned with the documentation

Verify consistency with architecture and data model

Commit changes to the repository

---
