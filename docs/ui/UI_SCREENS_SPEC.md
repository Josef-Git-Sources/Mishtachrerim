\# UI\_SCREENS\_SPEC.md



UI Screens Specification

Project: משתחררים (Mishtachrerim)



This document defines the UI structure of the product.



It describes:

\- main screens

\- layout structure

\- key UI components

\- CTA logic

\- user interaction patterns



The UI must support the core product principle:



A guided decision tool, not a content portal.



The user should feel guided step-by-step.



---



\# 1. Global UI Principles



The interface must be:



Simple  

Guided  

Trustworthy  

Mobile-first



The UI must avoid:



\- information overload

\- complex navigation

\- large menus

\- marketplace feeling



The experience should feel like:



A smart assistant helping you plan your next step.



---



\# 2. Global Layout



All public pages share a common layout.



Structure:



Header

Main Content

Footer



---



\# 3. Header



Header must remain minimal.



Elements:



Logo (links to homepage)



Primary navigation:

\- Checklist

\- Guides

\- Careers



Right side:

\- Start Quiz button

\- Login (optional)



Rules:



Quiz CTA should always be visible.



---



\# 4. Footer



Footer includes:



Links:

\- About

\- Contact

\- Privacy policy

\- Terms



Additional links:

\- Guides

\- Career paths



Disclosure:



Affiliate disclosure notice.



---



\# 5. Homepage



Route:

/



Purpose:



Explain the product and guide users into the decision flow.



---



\## Homepage Structure



Hero Section



Headline example:

"What should you do after the army?"



Subheadline:

"Answer a few questions and discover career paths that may fit you."



Primary CTA:

Start Quiz



Secondary CTA:

Open Checklist



---



Section: How It Works



3-step visual explanation.



Step 1

Answer a few questions



Step 2

See career paths that match you



Step 3

Discover how to start



---



Section: Example Career Paths



Cards showing example paths:



\- QA Tester

\- Data Analyst

\- Digital Marketing

\- UX/UI Designer



Each card links to career page.



---



Section: Quick After-Army Checklist



Preview of checklist.



CTA:

Open full checklist.



---



Section: Guides



Preview of helpful guides.



Examples:



\- What to do after the army

\- How to use your army deposit

\- Professions without a degree



---



\# 6. Checklist Page



Route:

/checklist



Purpose:



Provide immediate value and build trust.



---



\## Checklist Layout



Title:

"Things to do after you leave the army"



Checklist list:



Each item contains:



Title  

Short explanation  

Why it matters  

Link to more information



Checkbox interaction:



Users can mark items as completed.



Logged-in users:



Progress is saved.



Guests:



Progress stored locally.



---



\# 7. Guides Index



Route:

&nbsp;/guides



Purpose:



SEO and browsing hub.



Layout:



Grid of guide cards.



Each card includes:



Title  

Short summary  

Read guide CTA



---



\# 8. Guide Article Page



Route:

&nbsp;/guides/\[slug]



Purpose:



SEO landing page and quiz entry point.



---



\## Article Structure



Title



Intro paragraph



Main article sections



Practical tips



Context explanation



CTA section:



Take the career quiz.



Secondary CTA:



View checklist.



---



\# 9. Quiz Start Page



Route:

&nbsp;/quiz



Purpose:



Explain the quiz and start the flow.



---



\## Quiz Intro Layout



Headline:



"Find your next step after the army"



Description:



"This short quiz helps identify career directions that may fit you."



Options:



Quick Quiz

(5 questions)



Deep Quiz

(10 questions)



Primary CTA:

Start Quick Quiz



Secondary CTA:

Start Deep Quiz



---



\# 10. Quiz Screen



Route:

&nbsp;/quiz



The quiz runs inside one interactive screen.



---



\## Quiz Layout



Top:



Progress bar



Example:

Question 2 of 5



Center:



Question text



Answer options as cards or buttons.



Bottom:



Next button



---



\## Answer Interaction



User selects an answer.



Next button activates.



Next question loads.



---



\# 11. Quiz Completion



After the final question:



Loading screen appears.



Example message:



"Analyzing your answers..."



Then redirect to results.



---



\# 12. Results Page



Route:

&nbsp;/results/\[id]



Purpose:



Display the 3 best career matches.



---



\## Results Layout



Headline:



"Career paths that may fit you"



Explanation:



"Based on your answers, these paths may match your interests and preferences."



---



\## Career Match Cards



Three cards displayed.



Each card contains:



Career name



Match explanation



Example:



"You showed interest in technical work and structured environments."



Salary estimate



Training time



CTA:

View Career Path



---



\# 13. Career Path Page



Route:

&nbsp;/career/\[slug]



Purpose:



Provide clear explanation of the career.



Also serves as a major SEO page.



---



\## Career Page Layout



Title:

Career name



Intro summary



Example:

"What does a QA Tester do?"



---



Section: Why This Career Might Fit You



Explanation of who this career suits.



---



Section: Salary Range



Display range.



Include disclaimer.



---



Section: Training Time



Example:



3–6 months



---



Section: Pros and Cons



Pros list



Cons list



---



Section: How to Start



Simple steps:



1\. Learn basics

2\. Take a course or self-study

3\. Build initial experience



---



Section: Relevant Courses



Course cards displayed.



Each card includes:



Course name  

Provider  

Duration  

Editorial rating  

CTA: View Course



---



Section: Related Guides



Links to guides.



Example:



\- How to enter tech without a degree

\- What to do after the army



---



\# 14. Courses Browse Page



Route:

&nbsp;/courses



Purpose:



Curated browsing page.



Not a large marketplace.



---



\## Courses Layout



Grid of course cards.



Each card shows:



Course name  

Provider  

Duration  

Editorial rating  

Career field



CTA:

View Course



---



\# 15. Course Page



Route:

&nbsp;/courses/\[slug]



Purpose:



Course information and conversion page.



---



\## Course Page Layout



Course name



Provider name



Course summary



---



Section: Key Information



Duration  

Learning mode  

Difficulty  

Price range



---



Section: Editorial Rating



Short explanation why the course is recommended.



---



Section: Deposit Relevance



Explanation if the army deposit may apply.



Disclaimer required.



---



CTA:



Visit Provider Website



Optional secondary CTA:



Request information.



---



\# 16. Course Comparison Page



Route:

&nbsp;/courses/compare



Purpose:



Compare curated courses side-by-side.



---



\## Comparison Layout



Table format.



Columns:



Courses



Rows:



Duration  

Learning mode  

Difficulty  

Price range  

Deposit relevance



---



\# 17. Dashboard



Route:

&nbsp;/dashboard



Purpose:



User's personal hub.



---



\## Dashboard Sections



Saved results



Saved courses



Checklist progress



---



\# 18. Saved Results Page



Route:

&nbsp;/dashboard/results



Displays previous quiz results.



Each item links to:



&nbsp;/results/\[id]



---



\# 19. Saved Courses Page



Route:

&nbsp;/dashboard/courses



Displays courses saved by the user.



---



\# 20. Checklist Progress Page



Route:

&nbsp;/dashboard/checklist



Shows checklist completion state.



---



\# 21. Login Page



Route:

&nbsp;/login



Options:



Continue with Google



Login with email



Purpose:



Enable saving results and checklist progress.



---



\# 22. Admin Interface



Route:

&nbsp;/admin



Admin UI is internal.



Admin can manage:



Career paths  

Courses  

Quiz questions  

Guides  

Checklist items



Admin actions:



Create  

Edit  

Publish  

Archive



---



\# 23. UI Component Library



Common UI components required:



Header



Footer



CareerCard



CourseCard



GuideCard



ChecklistItem



QuizQuestion



QuizAnswerOption



ProgressBar



ComparisonTable



CTAButton



---



\# 24. Mobile Design Priority



Mobile devices will represent the majority of traffic.



Design rules:



\- large touch targets

\- short paragraphs

\- stacked layouts

\- minimal navigation



Quiz experience must be extremely smooth on mobile.



---



\# 25. Phase 1 Required Screens



Homepage



Checklist



Guides index



Guide page



Quiz start



Quiz flow



Results page



Career path page



Courses browse



Course page



Course comparison



Dashboard



Saved results



Saved courses



Login



Admin panel

