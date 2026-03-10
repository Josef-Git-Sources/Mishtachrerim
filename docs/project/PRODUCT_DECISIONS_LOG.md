\# PRODUCT\_DECISIONS\_LOG.md



Project: משתחררים  

This document records critical product decisions to prevent conflicting implementations.



If any implementation suggestion contradicts these decisions, the conflict must be raised before implementation.



---



\# 1. Product Type



The product is a \*\*Decision Engine\*\* for discharged soldiers.



It is NOT:



\- a job board

\- a government information portal

\- an open marketplace

\- a community forum



The system is a \*\*guided assistant\*\* that helps users decide their next career step.



---



\# 2. Core User Flow



The primary flow is:



Homepage / SEO

→ Guide or Checklist

→ Quiz

→ Results

→ Career Path Page

→ Courses



Career guidance must appear \*\*before courses\*\*.



Courses must never appear as the first step of the experience.



---



\# 3. Courses Policy



Courses are:



\- manually curated

\- limited (10–30 courses)

\- editorially rated



The platform is \*\*NOT an open course marketplace\*\*.



Providers cannot submit courses directly.



There are:



\- no user reviews

\- no public ratings



---



\# 4. Career Paths Layer



Career paths are the core layer between quiz results and courses.



Each career page functions as:



\- SEO page

\- trust page

\- course hub

\- conversion bridge



Courses must be shown primarily inside career pages.



---



\# 5. Quiz Structure



Two quiz modes exist:



Quick Quiz (5 questions)



Deep Quiz (10 questions)



Each answer contributes scores to career paths.



The system returns the \*\*top 3 matching career paths\*\*.



---



\# 6. Monetization Policy



Revenue sources:



Affiliate commissions from course providers.



Lead generation for training institutions.



Future sponsored placements may exist but must remain transparent.



Monetization must never appear before career guidance.



---



\# 7. Trust Rules



To maintain trust:



Salary numbers must be presented as ranges.



Career pages must include advantages and disadvantages.



Affiliate relationships must be disclosed.



Official sources should be referenced for rights-related content.



---



\# 8. SEO Strategy



SEO is a primary acquisition channel.



SEO pages include:



Guides

Career path pages

Editorial course pages

Course pages



SEO pages should naturally lead users to the quiz.



---



\# 9. Platform Model



The platform is:



Static SEO site + interactive features.



Framework: Next.js (App Router)



SEO pages are statically generated.



Interactive features include:



\- quiz

\- results

\- saved items

\- user accounts

\- lead forms



---



\# 10. User Accounts



Users may access quiz results without registration.



Registration is required only for:



\- saving results

\- saving courses

\- saving checklist progress



Authentication methods:



Google login  

Email login



---



\# 11. Content Management



All content is managed internally via an admin panel.



Editable entities include:



Career paths  

Courses  

Editorial ratings  

SEO articles  

Checklist items



---



\# 12. Phase 1 Limits



The first version of the product includes:



Homepage  

Checklist  

Quiz  

Results page  

Career pages  

Courses layer  

SEO guides  

Admin panel  

Analytics tracking



The product will NOT include:



Community features  

Forum  

Job board  

Open marketplace  

Complex AI recommendation systems

