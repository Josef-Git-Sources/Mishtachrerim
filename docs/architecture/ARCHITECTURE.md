# ARCHITECTURE.md

System Architecture

Project: משתחררים (Mishtachrerim)

This document defines the technical architecture of the Mishtachrerim product.

The system is designed as a **SEO-first platform combined with interactive decision tools**.

Core principle:

Static SEO content + Interactive decision engine.

---

# 1. Architecture Overview

The product consists of three main layers:

1. SEO Content Layer
2. Interactive Product Layer
3. Data & Services Layer

High-level architecture:

User
↓
Next.js Frontend
↓
API Layer
↓
Database

---

# 2. Architecture Philosophy

The system must support:

- strong SEO performance
- fast page loading
- clear user flow
- scalable product logic
- simple maintainability

The site must behave as:

A content-rich SEO site
combined with
a guided decision tool.

---

# 3. Core Technology Stack

Frontend Framework

Next.js (App Router)

Language

TypeScript

Database

PostgreSQL

Hosting

Vercel

Authentication

Supabase Auth

Supported authentication methods:

- Google OAuth
- Email / Password login

Supabase Auth is used for user identity, session handling,
and integration with the PostgreSQL database.

Analytics

GA4 or PostHog

---

# 4. Rendering Strategy

Different parts of the system use different rendering strategies.

---

## 4.1 Static Generation (SSG)

Used for SEO pages.

Examples:

- Guides
- Career path pages
- Editorial course pages
- Course pages

Benefits:

- fast load times
- excellent SEO
- CDN caching

---

## 4.2 Server Components

Used for dynamic content rendered on the server.

Examples:

- career path data
- course listings
- editorial comparisons

Benefits:

- smaller client bundles
- improved performance

---

## 4.3 Client Components

Used for interactive tools.

Examples:

- quiz interface
- results interaction
- saved items
- lead forms

---

# 5. Application Layers

The application consists of several logical layers.

---

# 5.1 Presentation Layer

Next.js frontend.

Responsibilities:

- UI rendering
- routing
- layout
- components
- page composition

---

# 5.2 Application Logic Layer

Handles product logic.

Examples:

- quiz scoring
- career matching
- course filtering
- lead submission

This logic lives in:

- server functions
- API routes
- backend services

---

# 5.3 Data Layer

Responsible for storing and retrieving data.

Main entities:

- users
- career_paths
- courses
- quiz_questions
- guides
- checklist_items
- leads

Defined in DATA_MODEL.md.

---

# 6. Application Structure (Next.js)

Recommended folder structure.

/guides
/career
/courses
/top-courses

/app

/(seo)

/guides
/career
/courses
/top-courses

/(tool)

/quiz
/results/[id]
/checklist

/(user)

/dashboard
/dashboard/results
/dashboard/courses
/dashboard/checklist
/dashboard/profile

/admin

/api

---

# 7. URL Structure

SEO-friendly URLs are essential.

---

## Guides

/guides/what-to-do-after-army
/guides/how-to-use-army-deposit

---

## Career Paths

/career/qa-tester
/career/data-analyst
/career/digital-marketing

---

## Intent Pages

Intent pages target specific career-related queries.

Examples:

/career/how-to-become-qa
/career/qa-salary
/career/how-to-become-data-analyst

These pages connect search queries to the career exploration flow.

Typical flow:

Intent Page
→ Career Page
→ Courses

or

Intent Page
→ Quiz

---

## Courses

/courses/qa-bootcamp
/courses/data-analyst-online

---

## Editorial Pages

/courses/editorial/best-qa-courses
/courses/editorial/top-digital-marketing-courses

---

## Quiz

/quiz
/quiz/deep

---

## Results

/results/[id]

Each quiz completion creates a persistent result record in the database.

Benefits:

- users can revisit their results
- results can be restored
- analytics can track result pages
- results can be saved to user accounts

---

# 8. Quiz System Architecture

Quiz flow:

Start quiz
↓
Answer questions
↓
Calculate scores
↓
Determine top careers
↓
Display results

---

## Quiz Logic

Scoring engine defined in:

MATCHING_ENGINE_LOGIC.md

Quiz question structure and score mappings
are defined in:

QUIZ_QUESTION_BANK.md

Process:

1. initialize scores for each career
2. apply answer score mappings
3. rank careers
4. return top 3

---

# 9. Career Recommendation System

The recommendation engine is deterministic.

Key properties:

- transparent scoring
- explainable results
- manually curated paths

Output includes:

- career name
- match reasons
- salary estimate
- training time
- how to start
- related courses

---

# 10. Course Layer

Courses are linked to careers.

Structure:

Career Path
→ Courses

Example:

QA Tester
→ QA Bootcamp
→ QA Automation Course

Course relevance is determined by:

- editorial rating
- deposit relevance
- duration
- learning mode

---

# 11. Course Comparison

Course comparison component allows users to compare multiple courses.

Attributes include:

- duration
- learning mode
- difficulty
- price range
- deposit relevance

---

# 12. User Accounts

Accounts enable:

- saving quiz results
- saving courses
- tracking checklist progress

Login methods:

Google OAuth
Email login

Guest users can still:

- take quiz
- view results
- browse career pages

---

# 13. Admin System

Admin panel is required for managing curated content.

Editable entities:

- career paths
- courses
- quiz questions
- answer score mappings
- guides
- checklist items

Admin actions:

create
edit
publish
archive

---

# 14. Analytics Architecture

Key events to track:

quiz_start
quiz_complete
results_view
career_page_view
course_click
lead_submit

Analytics tools may include:

GA4
PostHog

---

# 15. Conversion Points

Main conversion points:

Course provider click
Lead form submission
Newsletter signup

These events must be tracked for optimization.

---

# 16. SEO Architecture

SEO is a core component of the product.

SEO pages include:

- guides
- intent pages
- career paths
- course pages
- editorial course pages

SEO features include:

- static generation
- structured data
- meta tags
- internal linking

---

# 17. Performance Strategy

Performance optimization includes:

- static page generation
- CDN caching
- image optimization
- lazy loading

Goal:

fast page loads even on mobile networks.

---

# 18. Security Considerations

Security measures include:

OAuth authentication
input validation
spam protection for lead forms
rate limiting for APIs

---

# 19. Infrastructure (Phase 1)

Recommended infrastructure:

Frontend
Next.js on Vercel

Database
PostgreSQL

Authentication
Supabase Auth

Google OAuth and Email login are supported through Supabase Auth.

Analytics
GA4

This stack allows fast development and scaling.

---

# 20. Future Architecture Extensions

Possible future additions:

AI-based career recommendation
expanded course marketplace
advanced personalization
partner integrations
recommendation experiments

---

21. Environment Configuration

The site domain must not be hardcoded anywhere in the application.

All absolute URLs must be generated using the environment variable:

NEXT_PUBLIC_SITE_URL

Example values:

Staging environment

https://hatzaad.intelgrp.com

Production environment

https://hatzaad-haba.co.il

All internal links should use relative paths.

Example:

/career/qa-tester

Absolute URLs should only be generated when required for:

canonical tags
sitemaps
Open Graph metadata
structured data

This ensures the site can move between staging and production domains without code changes.

---

