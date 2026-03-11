\# TASKS.md



Development Tasks

Project: משתחררים (Mishtachrerim)



This document defines the concrete development tasks required to build the MVP.



The tasks are organized in the recommended build order.



The goal is to allow Claude Code to build the system step-by-step.



Each task should be completed before moving to the next major block.



---



\# 1. Project Setup



Initialize project repository.



Tasks:



Create Next.js project (App Router)



Configure TypeScript



Configure ESLint



Configure Prettier



Create base folder structure



Folders:



/app

/components

/lib

/data

/content

/quiz

/admin

/analytics



Install dependencies:



Next.js  

NextAuth  

PostgreSQL client  

ORM (Prisma recommended)



---



\# 2. Database Setup



Create database schema.



Tables to create:



users



career\_paths



courses



quiz\_questions



quiz\_answers



quiz\_answer\_scores



quiz\_results



saved\_careers



saved\_courses



checklist\_items



user\_checklist\_progress



guides



leads



Tasks:



Define schema in ORM



Run migrations



Seed initial data



---



\# 3. Seed Initial Data



Insert base content.



Seed:



10 career paths



10–30 courses



10 quiz questions



40 quiz answers



quiz scoring mappings



5 checklist items



This allows the system to function immediately.



---



\# 4. Core Layout



Implement main layout.



Tasks:



Create AppLayout



Create Header



Create Footer



Create Container component



Add navigation links:



Guides



Careers



Checklist



Quiz



---



\# 5. Homepage



Create homepage.



Sections:



Hero section



Explanation of product



CTA to start quiz



Example career paths



Links to guides



Link to checklist



---



\# 6. Checklist Page



Create checklist page.



Tasks:



Display checklist items



Allow marking items complete



Optional:



Save progress for logged-in users



Components:



ChecklistContainer



ChecklistItem



ChecklistProgress



---



\# 7. Guides System



Create guide pages.



Tasks:



Create dynamic route:



/guides/\[slug]



Load content from database



Render markdown content



Add internal links



Add CTA blocks



---



\# 8. Quiz System



Implement quiz flow.



Tasks:



Create quiz start page



Create question component



Load questions from database



Track answers



Add progress bar



Allow moving to next question



---



\# 9. Matching Engine



Implement scoring logic.



Tasks:



Load answer scoring mappings



Calculate career scores



Sort careers



Select top 3



Return results



Implementation location:



/lib/matching-engine.ts



---



\# 10. Results Page



Create results page.



Tasks:



Display top 3 careers



Show explanation text



Add CTA to career pages



Components:



CareerResultCard



---



\# 11. Career Pages



Create dynamic career pages.



Route:



/career/\[slug]



Tasks:



Load career data



Render sections:



Overview



Salary



Pros and cons



How to start



Courses



Add internal links



---



\# 12. Courses Pages



Create course pages.



Route:



/courses/\[slug]



Tasks:



Load course data



Render course details



Display editorial rating



Add CTA to provider site



---



\# 13. Editorial Course Pages



Create comparison pages.



Example route:



/courses/editorial/\[slug]



Tasks:



Load relevant courses



Display comparison table



Add CTA to quiz



---



\# 14. Lead Form



Implement lead capture.



Tasks:



Create LeadForm component



Store leads in database



Add validation



Add success message



---



\# 15. Authentication



Implement user authentication.



Use:



NextAuth



Login methods:



Google



Email



---



\# 16. Saved Items



Allow users to save items.



Tasks:



Save careers



Save courses



Create user dashboard



Routes:



/dashboard



---



\# 17. Admin Panel



Create admin system.



Route:



/admin



Sections:



Career paths



Courses



Guides



Checklist



Leads



Admin actions:



Create



Edit



Delete



---



\# 18. Analytics Integration



Implement analytics tracking.



Events:



quiz\_started



quiz\_completed



results\_viewed



career\_page\_viewed



course\_provider\_clicked



lead\_submitted



---



\# 19. SEO Optimization



Implement SEO features.



Tasks:



Add meta tags



Add structured data



Add canonical URLs



Add internal linking



Generate sitemap



---



\# 20. Performance Optimization



Tasks:



Enable static generation for SEO pages



Optimize images



Lazy load components



Use caching where possible



---



\# 21. Testing



Basic testing tasks:



Quiz logic tests



Matching engine tests



API tests



Form validation tests



---



\# 22. Deployment



Prepare production deployment.



Tasks:



Configure environment variables



Deploy to Vercel



Connect database



Test production build



---



\# 23. Launch Checklist



Before launch verify:



Quiz works correctly



Results are logical



Career pages render correctly



Course links work



Lead form works



Analytics events fire



SEO pages indexed



---



\# 24. Post-Launch Tasks



After launch monitor:



Quiz completion rate



Career page engagement



Course click-through rate



Lead generation



Use insights to improve the product.

