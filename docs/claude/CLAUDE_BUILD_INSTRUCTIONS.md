\# CLAUDE\_BUILD\_INSTRUCTIONS.md



Claude Build Instructions

Project: משתחררים (Mishtachrerim)



This document instructs Claude Code how to build the project.



It defines:



\- how to interpret the project documentation

\- what order to follow

\- development constraints

\- product philosophy



Claude must treat this file as the \*\*primary build guide\*\*.



---



\# 1. Project Overview



The product "משתחררים" is a \*\*Decision Engine for recently discharged soldiers\*\*.



The goal of the product is to help users decide:



What career path to pursue after military service.



The system guides the user through a flow:



SEO Content

→ Quiz

→ Career Recommendations

→ Career Pages

→ Courses



The product is \*\*not\*\*:



A job board  

A generic blog  

A government-style information portal



It is a \*\*guided decision tool\*\*.



---



\# 2. Product Flow



The core user journey is:



SEO Article or Homepage

→ Checklist or Guide

→ Quiz

→ Results (Top 3 careers)

→ Career Page

→ Courses



The site must always move users toward a \*\*decision\*\*.



---



\# 3. Architecture Model



The architecture is:



Static SEO site + interactive features.



Meaning:



Many pages are static SEO pages.



Interactive features include:



Quiz  

Results  

Saved items  

Lead forms



---



\# 4. Technology Stack



Claude must use the following stack.



Framework:



Next.js (App Router)



Language:



TypeScript



Database:



PostgreSQL



ORM:



Prisma (recommended)



Authentication:



NextAuth



Hosting:



Vercel



---



\# 5. Project Structure



Claude must follow the defined project structure.



Example structure:



/app

/components

/data

/quiz

/content

/design

/admin

/analytics

/lib

/project

/claude



Do not create random directories outside this structure.



---



\# 6. Rendering Strategy



Rendering strategy:



Static generation (SSG)



Used for:



Guides  

Career pages  

Editorial pages  

Course pages



Client components used for:



Quiz  

User interactions  

Saved items



---



\# 7. Database Source of Truth



Claude must use the \*\*DATA\_MODEL.md\*\* file as the database source of truth.



Tables must match that specification.



Do not invent new tables unless necessary.



---



\# 8. Quiz Logic Source



The quiz logic must follow:



QUIZ\_QUESTION\_BANK.md  

MATCHING\_ENGINE\_LOGIC.md



Claude must not invent new scoring logic.



The matching engine must remain deterministic.



---



\# 9. Career Page Structure



Career pages must follow:



CAREER\_PATH\_CONTENT\_STRUCTURE.md



Do not create arbitrary layouts.



All career pages must contain:



Overview  

Who it suits  

Salary  

Pros and cons  

How to start  

Courses



---



\# 10. SEO Content Rules



SEO pages must follow:



SEO\_PAGE\_TEMPLATES.md  

INTERNAL\_LINKING\_STRATEGY.md  

CONTENT\_GUIDELINES.md



Claude must respect:



Internal linking rules  

CTA placement  

Content structure



---



\# 11. UI Component System



All UI must follow:



COMPONENT\_LIST.md  

DESIGN\_SYSTEM.md



Claude must:



Reuse components  

Avoid duplicate UI logic  

Follow spacing and typography rules



---



\# 12. Admin Panel



Admin panel must follow:



ADMIN\_PANEL\_SPEC.md



Admin must support editing:



Career paths  

Courses  

Guides  

Checklist items



The admin panel is internal only.



---



\# 13. Analytics



Analytics events must follow:



ANALYTICS\_EVENTS.md



Claude must implement the defined event names.



Do not invent inconsistent event naming.



---



\# 14. Development Order



Claude must follow the order defined in:



TASKS.md



Recommended build order:



Project setup  

Database  

Layout  

Quiz system  

Matching engine  

Career pages  

Courses  

Admin panel  

Analytics



---



\# 15. UI Design Philosophy



The UI must feel like:



A smart decision tool.



Not:



A marketing site  

A blog  

A government information portal



Design must prioritize:



Clarity  

Trust  

Action



---



\# 16. Content Philosophy



The site must build trust.



Content must:



Be neutral  

Avoid exaggerated claims  

Avoid sales language



Courses must never appear as the only path to a career.



---



\# 17. Performance Goals



The site must be:



Fast  

SEO-friendly  

Mobile optimized



Prefer static pages where possible.



---



\# 18. Security



Claude must implement:



Authentication protection for admin routes



Input validation for forms



Spam protection for lead forms



---



\# 19. Phase 1 Constraints



Phase 1 must remain simple.



Do not implement:



Community features  

Forums  

Job boards  

Complex AI features



Focus on:



Decision engine  

SEO pages  

Career discovery



---



\# 20. When in Doubt



If something is unclear:



Follow the documentation files.



Priority order:



PRD.md  

ARCHITECTURE.md  

DATA\_MODEL.md  

TASKS.md



Claude should never invent product features not described in these documents.



---



\# 21. Final Principle



The goal is to build a \*\*clear, useful decision tool\*\*.



Every page must answer the question:



"What should I do next?"

