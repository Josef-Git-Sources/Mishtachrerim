# PRD.md

Product Requirements Document
Project: משתחררים (Mishtachrerim)

This document defines the product goals, user problems, core flows, and feature requirements for the Mishtachrerim platform.

The product helps discharged soldiers in Israel decide their next career path after military service.

---

# 1. Product Vision

Mishtachrerim is a **career decision platform** for discharged soldiers.

The product combines:

SEO-driven content
Interactive decision tools
Curated training recommendations

The platform helps users move from:

Uncertainty
→ Career Direction
→ Training Decision

---

# 2. Core User Problem

After military service many people face the same problem:

They do not know what career direction to pursue.

Common challenges include:

Too many options
Lack of clarity about professions
Lack of structured guidance
Difficulty choosing courses or training paths

Users often search for information such as:

"What should I study after the army?"

"What professions can I learn without a degree?"

"How to become a QA tester?"

"What jobs pay well without university?"

The product aims to provide structured answers to these questions.

---

# 3. Target Audience

Primary audience:

Discharged soldiers in Israel
Age range approximately 21–27

Typical characteristics:

Exploring career options
Considering short training programs
Interested in practical professions
Searching online for career guidance

Secondary audiences may include:

People considering career change
Students exploring alternatives to university

---

# 4. Product Strategy

The platform combines:

Content discovery
Decision guidance
Career exploration
Training recommendations

The core concept is a **Decision Engine**.

Users arrive through SEO content or directly.

They are then guided through a structured flow that leads to career recommendations and training options.

---

# 5. Core Product Flow

The main product flow is:

SEO Page or Guide

↓

Quiz

↓

Results Page (Top 3 Careers)

↓

Career Path Page

↓

Courses

This flow moves the user from:

Information
→ Decision
→ Action

---

# 6. Entry Points

Users may enter the system through several paths.

Primary entry points include:

Homepage
Guides
Intent pages
Checklist page

Examples:

/guides/what-to-do-after-army
/career/how-to-become-qa
/checklist

These pages introduce the product and guide users toward the quiz or career exploration.

---

# 7. Key Product Components

The system contains several core components.

Checklist
Guides
Quiz
Results
Career Path Pages
Courses
Editorial Course Pages
User Dashboard

Each component serves a specific role in the user journey.

---

# 8. Checklist

Route:

/checklist

Purpose:

Provide practical first steps after military service.

Examples of checklist items:

Use army deposit funds
Explore career options
Research training programs
Prepare resume
Start professional training

The checklist can be used without login.

Logged-in users can save progress.

---

# 9. Guides

Routes:

/guides
/guides/[slug]

Purpose:

SEO-driven informational content.

Examples:

what-to-do-after-army
professions-without-degree
how-to-use-army-deposit

Guides should:

Provide useful information
Build trust
Lead users into the quiz or career exploration.

---

# 10. Quiz

Routes:

/quiz
/quiz/deep

Purpose:

Help users discover suitable career paths.

Quiz modes:

Quick Quiz
5 questions

Deep Quiz
10 questions

The quiz produces:

Top 3 recommended careers.

Quiz behavior is defined in:

QUIZ_SYSTEM_SPEC.md

Scoring logic is defined in:

MATCHING_ENGINE_LOGIC.md

Questions and score mappings are defined in:

QUIZ_QUESTION_BANK.md

---

# 11. Results Page

Route:

/results/[id]

Purpose:

Display the user's recommended careers.

Each results page includes:

Top 3 careers
Short explanation of matches
Links to career pages

Results are stored in the database.

Anonymous users can view results.

Logged-in users can save results.

---

# 12. Career Path Pages

Route:

/career/[slug]

Examples:

/career/qa-tester
/career/data-analyst
/career/digital-marketing

Purpose:

These are the **most important pages in the system**.

They serve multiple roles:

SEO landing pages
Trust-building pages
Course hubs
Conversion bridges

Each career page includes:

Career overview
Why this career fits certain users
Salary range
Training time
Pros and cons
How to start
Relevant courses
Related guides

---

# 13. Courses

Routes:

/courses
/courses/[slug]

Purpose:

Display curated training programs.

Courses are primarily discovered through career pages.

The courses page is a limited curated browse layer.

Course detail pages include:

Provider name
Course duration
Learning mode
Price range
Editorial rating
Deposit eligibility
Link to provider

---

# 14. Editorial Course Pages

Route:

/courses/editorial/[slug]

Examples:

/courses/editorial/best-qa-courses
/courses/editorial/top-digital-marketing-courses

Purpose:

SEO comparison pages.

These pages compare multiple curated courses and help users choose the right program.

---

# 15. Course Comparison

Route:

/courses/compare

Purpose:

Allow users to compare selected courses.

Comparison attributes may include:

Duration
Learning mode
Difficulty
Price range
Deposit eligibility

---

# 16. User Accounts

Authentication is handled via:

Supabase Auth

Supported login methods:

Google OAuth
Email login

Users can optionally create an account.

Benefits of logging in:

Save quiz results
Save courses
Track checklist progress

The main user area is:

/dashboard

---

# 17. User Dashboard

Routes:

/dashboard
/dashboard/results
/dashboard/courses
/dashboard/checklist
/dashboard/profile

Purpose:

Provide access to saved content and progress.

---

# 18. Monetization

Primary monetization methods:

Course provider referrals
Lead submissions

Possible additional methods:

Affiliate programs
Sponsored courses
Advertising partnerships

---

# 19. Analytics

Key events to track include:

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

# 20. Phase 1 Scope

Phase 1 must include:

Homepage

Checklist

Guides

Quiz

Results

Career path pages

Courses

Editorial course pages

Course comparison

User accounts

Dashboard

Admin tools for managing content

---

# 21. Future Product Extensions

Possible future features include:

Additional career paths
Expanded course marketplace
Advanced personalization
AI-assisted recommendations
Career comparison tools

These features are not required for Phase 1.

---
