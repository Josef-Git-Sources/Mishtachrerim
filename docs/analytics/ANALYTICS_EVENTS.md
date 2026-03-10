\# ANALYTICS\_EVENTS.md



Analytics Events Specification

Project: משתחררים (Mishtachrerim)



This document defines the analytics tracking events used in the product.



Analytics is critical for understanding:



\- user behavior

\- conversion flow

\- quiz performance

\- SEO effectiveness

\- monetization performance



All analytics events should follow a consistent naming convention.



Recommended tools:



GA4  

PostHog  

or similar product analytics platform.



---



\# 1. Analytics Philosophy



The product must track the full decision journey:



Traffic

→ Content

→ Quiz

→ Results

→ Career exploration

→ Course interest

→ Conversion



This allows the team to understand where users drop off.



---



\# 2. Event Naming Convention



Use clear event names.



Format:



category\_action



Examples:



quiz\_started  

quiz\_completed  

career\_viewed  

course\_clicked  



Avoid vague names.



---



\# 3. Page View Tracking



All pages should trigger page view tracking.



Important page types:



Homepage  

Guide pages  

Career pages  

Course pages  

Checklist page  

Quiz page  

Results page



Page views help measure SEO performance.



---



\# 4. Quiz Events



The quiz is one of the most important flows.



---



\## quiz\_started



Triggered when user starts quiz.



Properties:



quiz\_type



Values:



quick  

deep



---



\## quiz\_question\_answered



Triggered when user answers a question.



Properties:



question\_id  

answer\_key



Example:



question\_id: 3  

answer\_key: B



---



\## quiz\_completed



Triggered when user finishes quiz.



Properties:



quiz\_type  

total\_questions



Example:



quiz\_type: deep  

total\_questions: 10



---



\# 5. Results Page Events



---



\## results\_viewed



Triggered when results page loads.



Properties:



career\_1  

career\_2  

career\_3



Example:



career\_1: qa-tester  

career\_2: data-analyst  

career\_3: digital-marketing



---



\# 6. Career Page Events



---



\## career\_page\_viewed



Triggered when a career page is viewed.



Properties:



career\_slug



Example:



career\_slug: qa-tester



---



\## career\_course\_section\_viewed



Triggered when user scrolls to course section.



Properties:



career\_slug



Purpose:



Understand interest in courses.



---



\# 7. Course Events



---



\## course\_card\_clicked



Triggered when user clicks a course card.



Properties:



course\_slug  

career\_slug



Example:



course\_slug: qa-bootcamp-tel-aviv



---



\## course\_provider\_clicked



Triggered when user clicks external provider link.



Properties:



course\_slug  

provider\_name



This is a key monetization event.



---



\# 8. Lead Events



---



\## lead\_form\_started



Triggered when user focuses on lead form.



Properties:



course\_slug



---



\## lead\_submitted



Triggered when lead form is submitted.



Properties:



course\_slug



This is a primary conversion metric.



---



\# 9. Checklist Events



---



\## checklist\_viewed



Triggered when checklist page loads.



---



\## checklist\_item\_completed



Triggered when user marks task complete.



Properties:



item\_id



Example:



item\_id: national-insurance-registration



---



\# 10. Guide Engagement Events



---



\## guide\_page\_viewed



Triggered when guide page loads.



Properties:



guide\_slug



Example:



guide\_slug: what-to-do-after-army



---



\## guide\_cta\_clicked



Triggered when user clicks CTA inside guide.



Properties:



cta\_type



Examples:



start\_quiz  

view\_career  

open\_checklist



---



\# 11. User Account Events



---



\## signup\_completed



Triggered when user registers.



Properties:



method



Values:



google  

email



---



\## login\_completed



Triggered when user logs in.



---



\# 12. Saved Items Events



---



\## career\_saved



Triggered when user saves a career.



Properties:



career\_slug



---



\## course\_saved



Triggered when user saves a course.



Properties:



course\_slug



---



\# 13. Newsletter Events (Future)



---



\## newsletter\_signup



Triggered when user joins newsletter.



Properties:



source\_page



Example:



guide  

career\_page



---



\# 14. Conversion Funnel



The key funnel to track:



Guide Page View

→ Quiz Started

→ Quiz Completed

→ Results Viewed

→ Career Page Viewed

→ Course Clicked

→ Lead Submitted



Each step should have measurable events.



---



\# 15. Important Metrics



Product metrics:



Quiz completion rate  

Results to career click rate  

Career to course click rate  



Business metrics:



Course provider clicks  

Lead submissions  



SEO metrics:



Guide page views  

Career page traffic



---



\# 16. Privacy Considerations



Analytics must comply with privacy standards.



Do not collect:



Sensitive personal data  

Full quiz answer history tied to identity



Emails should not be sent to analytics tools.



---



\# 17. Implementation Location



Analytics tracking should be implemented in:



Client components.



Example:



Quiz interactions  

CTA clicks  

Scroll tracking



Server events may track:



Lead submissions.



---



\# 18. Phase 1 Analytics Scope



Phase 1 must track:



Quiz start  

Quiz completion  

Results view  

Career page views  

Course clicks  

Lead submissions



Advanced behavioral analytics can be added later.



---



\# 19. Future Analytics Improvements



Possible improvements:



Heatmaps  

Session replay  

A/B testing  



These are not required for Phase 1.



---



\# 20. Analytics Goal



Analytics should answer one core question:



Where do users get stuck in the decision process?



Once this is visible, the product can be improved.

