\# ROUTING\_AND\_PAGE\_STRUCTURE.md



Routing and Page Structure  

Project: משתחררים (Mishtachrerim)



This document defines the page map, routing structure, and page roles for the Mishtachrerim product.



The purpose of this document is to ensure:



\- clear site structure

\- SEO-first routing

\- clean user flow

\- separation between static pages and interactive features



---



\# 1. Routing Principles



The routing system must follow these principles:



1\. SEO pages must have clean, readable URLs

2\. Interactive flows must be clearly separated from public content

3\. Career paths are a central bridge between quiz results and courses

4\. Courses can be browsed in a limited curated way, but are primarily shown in career context

5\. The homepage is an entry point to both checklist and quiz



---



\# 2. Page Type Categories



The site includes 5 main page types:



1\. Core entry pages

2\. SEO content pages

3\. Interactive tool pages

4\. Career and course pages

5\. User and admin pages



---



\# 3. Core Entry Pages



\## 3.1 Homepage



Route:

`/`



Role:

\- primary product landing page

\- entry point to quiz

\- entry point to checklist

\- trust-building overview page



Main goals:

\- explain the value proposition

\- guide users into action

\- introduce checklist, guides, and career paths



Primary CTAs:

\- start quick planning

\- open checklist after discharge



---



\## 3.2 Checklist Landing Page



Route:

`/checklist`



Role:

\- public checklist overview

\- practical first-step page

\- SEO-capable utility page

\- optional entry point to personal checklist tracking



Main goals:

\- help users understand immediate post-discharge actions

\- build trust

\- drive users into quiz when appropriate



---



\# 4. SEO Content Pages



\## 4.1 Guides Index



Route:

`/guides`



Role:

\- directory of SEO guides

\- browsing hub for informational content



---



\## 4.2 Guide Detail Page



Route pattern:

`/guides/\[slug]`



Examples:

\- `/guides/what-to-do-after-army`

\- `/guides/how-to-use-army-deposit`

\- `/guides/professions-without-degree`



Role:

\- SEO landing page

\- trust-building content page

\- entry point to quiz and career flow



Content pattern:

\- problem/context

\- explanation

\- practical advice

\- CTA into quiz or checklist



---



\# 5. Quiz and Decision Flow Pages



\## 5.1 Quiz Landing / Start Page



Route:

`/quiz`



Role:

\- entry point to the planning flow

\- lets user choose quick or deep quiz



Main options:

\- quick quiz

\- deep quiz



---



\## 5.2 Deep Quiz Start or Deep Quiz Flow



Route:

`/quiz/deep`



Role:

\- dedicated entry point for the longer quiz flow



Notes:

\- can either start immediately

\- or display explanation before start



---



\## 5.3 Quiz Flow Pages



Possible implementation options:



\### Option A

Single interactive route:

`/quiz`

and state-based progression inside the page



\### Option B

Step-based route structure:

`/quiz/\[step]`



Recommended for phase 1:

\*\*Option A\*\*

because it is simpler and easier to build while maintaining a guided experience.



---



\## 5.4 Results Page



Recommended route pattern:

`/results/\[id]`



Examples:

\- `/results/abc123`

\- `/results/f3e9a1`



Role:

\- displays the user's top 3 matched career paths

\- acts as the bridge from quiz to career pages



Why not just `/results`:

\- supports saved result states

\- supports restoring result pages

\- supports analytics and future deep linking



Important rule:

Results are viewable without login, but saving requires login.



---



\# 6. Career Path Pages



\## 6.1 Career Paths Index (Optional but recommended)



Route:

`/career`



Role:

\- limited browse/index page for all career paths

\- SEO and navigation support

\- helpful for users who want to explore manually



Notes:

\- should not replace the quiz flow

\- should remain a curated directory, not an overwhelming catalog



---



\## 6.2 Career Path Detail Page



Route pattern:

`/career/\[slug]`



Examples:

\- `/career/qa-tester`

\- `/career/data-analyst`

\- `/career/digital-marketing`



Role:

\- SEO page

\- trust page

\- course hub

\- conversion bridge



Each page should include:

\- overview

\- why this career fits certain users

\- salary range

\- training time

\- pros and cons

\- how to start

\- relevant courses

\- related guides



These are among the most important pages in the product.



---



\# 7. Courses Layer



\## 7.1 Courses Browse Page (Limited curated browse layer)



Route:

`/courses`



Role:

\- curated browse layer for selected courses

\- secondary entry point

\- supports users who already know they want training



Important:

This is NOT the main first step of the product.

Courses should still be shown primarily through career-path context.



The page should remain:

\- small

\- curated

\- filtered lightly if needed

\- not a giant marketplace



---



\## 7.2 Course Detail Page



Route pattern:

`/courses/\[slug]`



Examples:

\- `/courses/qa-bootcamp`

\- `/courses/data-analyst-online`



Role:

\- SEO page

\- conversion page

\- course information page



Page content should include:

\- provider name

\- summary

\- duration

\- learning mode

\- price range

\- editorial rating

\- deposit relevance

\- CTA to provider

\- optional lead form



---



\## 7.3 Editorial Course Pages



Route pattern:

`/courses/\[editorial-slug]`

or a clearer split such as:

`/courses/editorial/\[slug]`



Recommended route structure:

`/courses/editorial/\[slug]`



Examples:

\- `/courses/editorial/best-qa-courses`

\- `/courses/editorial/top-digital-marketing-courses`



Role:

\- editorial SEO pages

\- comparison-driven pages

\- monetization-support pages



These are different from course detail pages and should be modeled separately.



---



\## 7.4 Course Comparison Page



Route:

`/courses/compare`



Role:

\- compare selected curated courses side-by-side



Comparison attributes:

\- duration

\- learning mode

\- difficulty

\- price range

\- deposit relevance

\- field salary range



Notes:

\- compare is an important trust and conversion feature

\- should support a small number of courses at once



---



\# 8. User Pages



\## 8.1 Dashboard



Route:

`/dashboard`



Role:

\- logged-in user home

\- access point to personal saved state



---



\## 8.2 Saved Results



Route:

`/dashboard/results`



Role:

\- list of saved quiz results

\- links back to stored result pages



---



\## 8.3 Saved Courses



Route:

`/dashboard/courses`



Role:

\- saved course list for registered users



---



\## 8.4 Checklist Progress



Route:

`/dashboard/checklist`



Role:

\- personal checklist progress page

\- saved status for checklist items



---



\## 8.5 Profile / Account



Route:

`/dashboard/profile`



Role:

\- lightweight account settings

\- profile information

\- auth-related preferences



---



\# 9. Authentication Pages



\## 9.1 Login



Route:

`/login`



Role:

\- email login

\- Google login

\- entry point when user wants to save progress or results



---



\## 9.2 Optional Register Route



Route:

`/register`



Role:

\- account creation if separate from login



Notes:

\- depending on auth implementation, a single auth page may be enough



---



\# 10. Admin Pages



Admin is internal only.



\## 10.1 Admin Dashboard



Route:

`/admin`



Role:

\- internal home for content management



---



\## 10.2 Admin Career Paths



Route:

`/admin/career-paths`



Role:

\- manage career path content



---



\## 10.3 Admin Courses



Route:

`/admin/courses`



Role:

\- manage curated courses

\- manage editorial ratings

\- manage publish status



---



\## 10.4 Admin Guides



Route:

`/admin/guides`



Role:

\- manage SEO guides



---



\## 10.5 Admin Checklist



Route:

`/admin/checklist`



Role:

\- manage checklist items



---



\## 10.6 Admin Quiz Content



Route:

`/admin/quiz`



Role:

\- manage quiz questions

\- manage answer options

\- manage score mappings



---



\# 11. Route Grouping Strategy (Next.js App Router)



Suggested logical grouping:



```text

/app



&nbsp; /(public)

&nbsp;   page.tsx

&nbsp;   /checklist

&nbsp;   /guides

&nbsp;   /career

&nbsp;   /courses

&nbsp;   /login

&nbsp;   /register



&nbsp; /(quiz)

&nbsp;   /quiz

&nbsp;   /quiz/deep

&nbsp;   /results/\[id]



&nbsp; /(dashboard)

&nbsp;   /dashboard

&nbsp;   /dashboard/results

&nbsp;   /dashboard/courses

&nbsp;   /dashboard/checklist

&nbsp;   /dashboard/profile



&nbsp; /admin

Notes:



route groups are organizational, not necessarily visible in the URL



public pages remain SEO-friendly



quiz and dashboard flows remain logically isolated



12\. Canonical Flow Priorities



Primary flow:

/

→ /checklist or /guides/\[slug]

→ /quiz

→ /results/\[id]

→ /career/\[slug]

→ /courses/\[slug]



Secondary flow:

/

→ /career

→ /career/\[slug]

→ /courses/\[slug]



Tertiary flow:

/

→ /courses

→ /courses/editorial/\[slug]

→ /courses/\[slug]



Important:

The tertiary flow must not dominate the product experience.



13\. SEO Priorities by Route Type



Highest SEO priority:



/guides/\[slug]



/career/\[slug]



/courses/editorial/\[slug]



Medium SEO priority:



/courses/\[slug]



/checklist



/guides



/career



Lower SEO priority:



/quiz



/results/\[id]



/dashboard/\*



/admin/\*



14\. Interaction Priorities by Route Type



Highest interaction priority:



/quiz



/results/\[id]



/courses/\[slug]



/dashboard/\*



Medium interaction priority:



/checklist



/career/\[slug]



/courses/compare



Low interaction priority:



/guides/\[slug]



/courses/editorial/\[slug]



15\. URL Design Rules



All public-facing routes should be:



short



readable



SEO-friendly



English slugs only



stable over time



Examples:

Good:



/career/qa-tester



/guides/what-to-do-after-army



Avoid:



/career?id=123



/page-1



/article/army\_post\_release\_guide\_v2



16\. Key Routing Rules



Career paths must always exist as first-class pages



Results pages must support persistent identifiers



Editorial course pages must not be mixed with raw course detail pages without structure



Dashboard and admin pages must remain outside the public SEO flow



Checklist must remain publicly accessible



The product must never force login before value is shown



17\. Phase 1 Required Pages



Must exist in phase 1:



/



/checklist



/guides



/guides/\[slug]



/quiz



/quiz/deep



/results/\[id]



/career/\[slug]



/courses



/courses/\[slug]



/courses/editorial/\[slug]



/courses/compare



/dashboard



/dashboard/results



/dashboard/courses



/dashboard/checklist



/login



/admin



18\. Future Routing Extensions



Possible future additions:



/career/\[slug]/courses



/newsletter



/compare/\[saved-id]



/dashboard/recommendations



/jobs/\*

