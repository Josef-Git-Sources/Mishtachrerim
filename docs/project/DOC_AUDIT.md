\# DOC\_AUDIT.md



Document Consistency Audit  

Project: משתחררים (Mishtachrerim)



This document defines rules for validating consistency between project documents before implementation begins.



The purpose is to prevent architectural or product contradictions.



---



\# 1. Source of Truth Hierarchy



If conflicts exist between documents, follow this priority order:



1\. PROJECT\_MASTER\_DOC.md

2\. PRODUCT\_DECISIONS\_LOG.md

3\. PRD.md

4\. ARCHITECTURE.md

5\. DATA\_MODEL.md

6\. UI\_SCREENS\_SPEC.md

7\. COMPONENT\_LIST.md

8\. TASKS.md



Higher documents override lower documents.



Example:



If PRD conflicts with PROJECT\_MASTER\_DOC, the master document wins.



---



\# 2. Conflict Detection Rule



Before implementing any feature, the system must check:



\- Does this feature exist in PRD.md?

\- Does it contradict PRODUCT\_DECISIONS\_LOG.md?

\- Does it contradict PROJECT\_MASTER\_DOC.md?



If a contradiction exists:



STOP implementation and report the conflict.



---



\# 3. Forbidden Deviations



The system must never introduce features that contradict core product rules.



Examples of forbidden deviations:



\- Converting the platform into an open marketplace

\- Adding user-generated reviews

\- Turning the platform into a job board

\- Introducing community/forum systems

\- Showing courses before career guidance



---



\# 4. Product Flow Validation



The system must preserve the core flow:



Homepage / SEO

→ Guide or Checklist

→ Quiz

→ Results

→ Career Path Page

→ Courses



Any feature that breaks this sequence must be reviewed.



---



\# 5. SEO Integrity Rule



SEO pages must remain static-first pages.



They include:



\- Guides

\- Career paths

\- Editorial course pages

\- Course pages



SEO pages must not depend on heavy client-side rendering.



---



\# 6. Architecture Validation



The architecture must remain:



Static SEO site + interactive features



Framework:



Next.js (App Router)



SEO pages should be statically generated.



Interactive features include:



\- quiz

\- results

\- saved items

\- authentication

\- lead forms



---



\# 7. Content Governance



All content must remain curated.



The platform is NOT an open marketplace.



Content entities managed internally:



\- career paths

\- courses

\- editorial pages

\- SEO articles

\- checklist items



---



\# 8. Implementation Guardrail



Before generating implementation code, confirm:



\- No contradiction with product decisions

\- No deviation from architecture direction

\- No violation of SEO strategy



If uncertainty exists, request clarification instead of guessing.

