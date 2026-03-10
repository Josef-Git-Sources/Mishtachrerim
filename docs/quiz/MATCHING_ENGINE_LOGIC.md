\# MATCHING\_ENGINE\_LOGIC.md



Matching Engine Logic

Project: משתחררים (Mishtachrerim)



This document defines the algorithm used to convert quiz answers

into recommended career paths.



The matching engine is the core of the Decision Engine.



It receives quiz answers and produces:



Top 3 recommended careers



Each result includes:



Career name  

Score  

Explanation



---



\# 1. Core Concept



The system uses a \*\*score-based matching model\*\*.



Each quiz answer adds points to one or more careers.



At the end of the quiz:



1\. Scores are summed

2\. Careers are ranked

3\. Top 3 careers are returned



---



\# 2. Supported Careers



Phase 1 careers:



QA Tester  

Digital Marketing  

Data Analyst  

IT Support  

Project Management  

Graphic Design  

Ecommerce Manager  

Network Technician  

Full Stack Developer  

UX/UI Designer



Each career begins with score:



0



---



\# 3. Input Data Structure



The engine receives answers in this structure:



Example:



answers = \[

&nbsp; {questionId: 1, answer: "A"},

&nbsp; {questionId: 2, answer: "C"},

&nbsp; {questionId: 3, answer: "B"}

]



Each answer maps to a predefined scoring table.



---



\# 4. Scoring Table



Each answer corresponds to a scoring map.



Example:



Question 1 Answer A



scores:



QA Tester +3  

Data Analyst +3  

IT Support +2  

Full Stack Developer +2



---



Example representation:



scores = {

&nbsp; "QA Tester": 3,

&nbsp; "Data Analyst": 3,

&nbsp; "IT Support": 2,

&nbsp; "Full Stack Developer": 2

}



The engine adds these values to the current score.



---



\# 5. Score Accumulation



Algorithm:



For each answer:



1\. retrieve score mapping

2\. add score to relevant careers



Pseudo process:



Initialize all career scores to 0



For each answer:

&nbsp;   For each career in scoreMapping:

&nbsp;       careerScore += mappingValue



---



\# 6. Example Calculation



User answers:



Q1 → A  

Q2 → A  

Q3 → C  



Scoring example:



After Q1:



QA Tester = 3  

Data Analyst = 3  

IT Support = 2  

Full Stack = 2  



After Q2:



Full Stack += 3  

QA += 2  

Data += 2  

IT += 2  



After Q3:



Full Stack += 3  

IT += 2  



Final scores:



Full Stack = 8  

QA Tester = 5  

Data Analyst = 5  

IT Support = 4



Top results:



1\. Full Stack Developer  

2\. QA Tester  

3\. Data Analyst



---



\# 7. Sorting Logic



Once scoring finishes:



1\. Create list of careers

2\. Sort by score descending

3\. Select top 3



Example:



sortedCareers = careers.sort(score DESC)



top3 = first 3



---



\# 8. Tie-Break Logic



If two careers have identical scores,

apply tie-break rules.



Priority order:



1\. Technical careers

2\. Analytical careers

3\. Creative careers

4\. Business careers



Example ranking group:



Technical:



Full Stack  

QA Tester  

Network Technician  

IT Support  



Analytical:



Data Analyst  



Creative:



UX/UI Designer  

Graphic Design  



Business:



Digital Marketing  

Ecommerce Manager  

Project Management



If tie occurs within same group,

keep both sorted by score.



---



\# 9. Result Output Format



The engine should return results in this format:



results = \[

&nbsp; {

&nbsp;   career: "Full Stack Developer",

&nbsp;   score: 8

&nbsp; },

&nbsp; {

&nbsp;   career: "QA Tester",

&nbsp;   score: 5

&nbsp; },

&nbsp; {

&nbsp;   career: "Data Analyst",

&nbsp;   score: 5

&nbsp; }

]



The UI layer will attach:



career description  

salary range  

training info



---
---

# 9.1 Result Persistence

After calculating the sorted career scores,
the system must persist the results.

The persistence model uses two tables:

quiz_results
quiz_result_careers

Step 1

Create quiz_results record.

Fields:

id
user_id
created_at

Example:

quiz_results

id: 123
user_id: null

Step 2

Store career matches in quiz_result_careers.

Fields:

quiz_result_id
career_path_id
score
rank

Example:

quiz_result_id:123
career_path_id:qa-tester
score:8
rank:1

quiz_result_id:123
career_path_id:data-analyst
score:5
rank:2

quiz_result_id:123
career_path_id:digital-marketing
score:5
rank:3

The UI only displays the top 3 results,
but the system may store additional ranks for analytics.




\# 10. Result Explanation Logic



Each career result should include

a short explanation based on answers.



Example:



You might enjoy QA Tester because:



\- you prefer structured technical tasks

\- you pay attention to details

\- you enjoy problem solving



Explanation logic may be:



Template based.



---



\# 11. Score Normalization (Optional)



If needed, scores can be normalized.



Example:



scorePercent = careerScore / maxPossibleScore



This is optional for Phase 1.



Raw score ranking is sufficient.



---



\# 12. Minimum Score Threshold



Optional rule:



If all scores are extremely low,

show general recommendation message.



Example:



"ייתכן שכדאי לבדוק עוד אפשרויות קריירה."



This is optional.



---



\# 13. Quick Quiz vs Deep Quiz



Quick Quiz



5 questions



Deep Quiz



10 questions



The engine logic is identical.



Deep quiz simply provides more signals.



---



\# 14. Performance Requirements



The matching engine must be:



Fast  

Stateless  

Deterministic



Expected runtime:



< 10ms



---



\# 15. Implementation Location



The matching engine should be implemented in:



Server logic or API layer.



Suggested path:



/lib/matching-engine.ts



The UI should never implement scoring logic.



---



\# 16. Testing Requirements



Unit tests should validate:



Correct score accumulation  

Correct ranking  

Correct tie-break logic  



Test examples:



\- identical answers

\- mixed answers

\- tie cases



---



\# 17. Future Improvements



Possible future improvements:



Weighted dimensions  

Machine learning scoring  

Behavior-based signals  

Career probability model



None of these are required for Phase 1.



---



\# 18. Design Philosophy



The system must be:



Simple  

Explainable  

Predictable



Users should feel the result is logical.



Avoid black-box algorithms.

