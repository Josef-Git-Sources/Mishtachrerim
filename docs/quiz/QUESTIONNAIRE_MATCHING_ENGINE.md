\# QUESTIONNAIRE\_MATCHING\_ENGINE.md



Technical Product Logic  

Project: משתחררים (Mishtachrerim)



This document defines the logic of the quiz matching engine used to recommend career paths to users.



The purpose of this system is to provide a \*\*clear, explainable, score-based recommendation\*\* for discharged soldiers.



This is NOT a complex AI recommendation system.



It is a \*\*transparent scoring engine\*\*.



---



\# 1. Purpose



The matching engine determines which career paths fit the user best based on quiz answers.



The output is:



\- Top 3 matching career paths

\- Reasoning behind the match

\- Suggested next steps

\- Relevant courses for each path



---



\# 2. Core Principle



Each answer contributes points to one or more career paths.



At the end of the quiz:



1\. scores are summed

2\. careers are ranked

3\. the top 3 careers are returned



This creates a recommendation that is:



\- explainable

\- easy to maintain

\- easy to improve

\- suitable for phase 1



---



\# 3. Career Paths in Phase 1



Initial set of career paths:



1\. QA Tester

2\. Digital Marketing

3\. Data Analyst

4\. IT Support

5\. Project Management

6\. Graphic Design

7\. Ecommerce

8\. Network Technician

9\. Full Stack Developer

10\. UX/UI Designer



These are the canonical paths used by the scoring engine.



---



\# 4. Quiz Modes



\## 4.1 Quick Quiz



Length:

5 questions



Purpose:

Fast directional recommendation.



Output:

Top 3 career paths with brief explanation.



---



\## 4.2 Deep Quiz



Length:

10 questions



Purpose:

More accurate recommendation.



Output:

Top 3 career paths with richer explanation and better filtering.



---



\# 5. Scoring Model



Each answer option has an associated score map.



Example:



Answer:

"I enjoy technical troubleshooting"



May add:



\- IT Support +3

\- Network Technician +2

\- QA Tester +1



---



\# 6. Quick Quiz Question Set



\## Question 1

What matters most to you right now?



Options:



A. Start earning money quickly  

B. Build a long-term career  

C. Find a stable profession  

D. Do something creative  

E. I’m still not sure



\### Score mapping



A:

\- QA Tester +2

\- IT Support +2

\- Network Technician +2

\- Digital Marketing +1



B:

\- Full Stack Developer +3

\- Data Analyst +2

\- UX/UI Designer +2

\- Project Management +1



C:

\- IT Support +2

\- Network Technician +2

\- QA Tester +1

\- Project Management +1



D:

\- Digital Marketing +3

\- UX/UI Designer +3

\- Graphic Design +2

\- Ecommerce +2



E:

\- Project Management +1

\- Digital Marketing +1

\- QA Tester +1

\- IT Support +1



---



\## Question 2

What type of work attracts you most?



Options:



A. Computers and technology  

B. Working with people  

C. Creativity and design  

D. Practical technical work  

E. Numbers and analysis



\### Score mapping



A:

\- QA Tester +2

\- IT Support +2

\- Full Stack Developer +3

\- Data Analyst +1

\- Network Technician +2



B:

\- Project Management +3

\- Digital Marketing +1



C:

\- UX/UI Designer +3

\- Graphic Design +3

\- Digital Marketing +2

\- Ecommerce +1



D:

\- Network Technician +3

\- IT Support +2



E:

\- Data Analyst +3

\- QA Tester +1



---



\## Question 3

How long are you willing to study before starting?



Options:



A. Up to 1 month  

B. Up to 3 months  

C. Up to 6 months  

D. More than 6 months if it’s worth it



\### Score mapping



A:

\- Ecommerce +1

\- Digital Marketing +1



B:

\- Digital Marketing +2

\- IT Support +1

\- Network Technician +1

\- QA Tester +1



C:

\- QA Tester +2

\- UX/UI Designer +2

\- Data Analyst +2

\- Project Management +1

\- Graphic Design +1



D:

\- Full Stack Developer +3

\- Data Analyst +2

\- UX/UI Designer +1



---



\## Question 4

What kind of work environment fits you better?



Options:



A. Structured and clear  

B. Creative and open-ended  

C. Problem-solving and technical  

D. Dynamic and people-oriented  

E. Independent / entrepreneurial



\### Score mapping



A:

\- QA Tester +3

\- Data Analyst +2

\- IT Support +1



B:

\- UX/UI Designer +3

\- Graphic Design +3

\- Digital Marketing +2



C:

\- IT Support +3

\- Full Stack Developer +2

\- Network Technician +2

\- QA Tester +1



D:

\- Project Management +3

\- Digital Marketing +1



E:

\- Ecommerce +3

\- Digital Marketing +2

\- Graphic Design +1



---



\## Question 5

How much challenge are you willing to handle?



Options:



A. I want something easy to start  

B. Medium difficulty is fine  

C. Harder path is okay if salary potential is higher



\### Score mapping



A:

\- QA Tester +2

\- Digital Marketing +2

\- IT Support +2

\- Network Technician +2



B:

\- UX/UI Designer +2

\- Data Analyst +2

\- Project Management +2

\- Graphic Design +2



C:

\- Full Stack Developer +3

\- Data Analyst +2

\- UX/UI Designer +1



---



\# 7. Deep Quiz Additional Questions



The deep quiz includes the 5 quick questions plus 5 more.



\## Question 6

How important is remote work to you?



Options:

\- Very important

\- Nice to have

\- Not important



Recommended influence:

Boost Digital Marketing, UX/UI, Data Analyst, Full Stack for remote preference.



---



\## Question 7

Do you prefer office-style work or hands-on work?



Options:

\- Office / computer-based

\- Hands-on / technical

\- Mix of both



Recommended influence:

\- Hands-on boosts Network Technician, IT Support

\- Office boosts QA, Data, UX/UI, PM



---



\## Question 8

How important is salary in the short term?



Options:

\- Very important

\- Important but not the only thing

\- I’m okay starting lower to learn



Recommended influence:

\- Very important boosts QA, Data, Full Stack

\- Lower urgency may boost Graphic Design, UX/UI, PM



---



\## Question 9

Would you rather be an employee or possibly independent in the future?



Options:

\- Employee

\- Independent

\- Open to both



Recommended influence:

\- Independent boosts Ecommerce, Digital Marketing, Graphic Design

\- Employee boosts IT Support, QA, Data, Network Technician



---



\## Question 10

Do you want a path that may fit deposit funding?



Options:

\- Yes

\- Not sure

\- Not important



Recommended influence:

This question does not directly decide a career path.

It affects:

\- how results are presented

\- course ranking

\- course CTA prioritization



---



\# 8. Result Generation Logic



After the user completes the quiz:



1\. Initialize score = 0 for every career path

2\. For every answer, add mapped points

3\. Sort careers by score descending

4\. Return top 3 careers

5\. Generate explanation based on strongest scoring dimensions

6\. Attach relevant guides

7\. Attach relevant courses



---



\# 9. Tie-Break Rules



If multiple careers have the same score:



Priority order:



1\. Match on study duration preference

2\. Match on challenge level

3\. Match on salary importance

4\. Match on technical vs creative preference



If still tied:

Prefer the career with the clearer path-to-entry for phase 1.



---



\# 10. Recommendation Output Structure



Each result item should contain:



\- career\_path\_id

\- career\_path\_name

\- total\_score

\- match\_reasons

\- estimated\_salary\_range

\- estimated\_training\_time

\- how\_to\_start\_summary

\- relevant\_guide\_ids

\- relevant\_course\_ids



---



\# 11. Match Reasons



The engine should generate short explanations.



Examples:



\- You showed strong interest in technology and structured work

\- You prefer a relatively fast path into a profession

\- You are willing to study for a few months to improve salary potential

\- You leaned toward analytical and computer-based work



These reasons improve trust and make the results feel personal.



---



\# 12. How to Start Suggestions



Each career path should show simple next-step options such as:



\- Learn independently

\- Take a course

\- Start in an entry-level role

\- Read the guide first



Important:

The product must not imply that a course is the only path.



---



\# 13. Relevant Courses Logic



Courses are attached to career paths manually.



The engine does NOT generate courses from scratch.



Instead:



career path

→ linked curated courses

→ ranked by relevance



Course relevance may consider:

\- deposit relevance

\- learning mode

\- duration

\- difficulty

\- editorial rating



---



\# 14. Relevant Guides Logic



Each career path may also link to:



\- guides about choosing that field

\- guides about starting after discharge

\- guides about deposit usage if relevant



Example:

QA Tester might link to:

\- how to enter tech without a degree

\- what to do after the army

\- how to use the army deposit



---



\# 15. Data Model Implications



The scoring engine requires data structures for:



\- career paths

\- quiz questions

\- quiz answers

\- score mappings

\- quiz submissions

\- result records

\- career-to-course relations

\- career-to-guide relations



This should directly inform DATA\_MODEL.md.



---



\# 16. Product Constraints



The engine must remain:



\- explainable

\- editable by product/admin logic

\- deterministic

\- easy to tune



It must NOT become:



\- black-box AI

\- opaque scoring

\- uncontrolled recommendation logic



---



\# 17. Phase 1 Implementation Rule



For phase 1:



\- use fixed scoring rules

\- use fixed career path set

\- use manually linked courses

\- use manually linked guides



This keeps quality high and complexity low.



---



\# 18. Future Extensions



Possible future improvements:



\- weighted scoring by quiz mode

\- stronger reasoning generation

\- dynamic personalization by saved behavior

\- performance-based path ranking

\- A/B testing of scoring logic



These are future options and are NOT required in phase 1.

