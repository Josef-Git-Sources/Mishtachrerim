\# ADMIN\_PANEL\_SPEC.md



Admin Panel Specification

Project: משתחררים (Mishtachrerim)



This document defines the admin panel used to manage the content of the site.



The admin panel allows internal editors to manage:



Career paths  

Courses  

Guides  

Checklist items  

Editorial ratings  



The admin system is \*\*internal only\*\* and not exposed publicly.



Phase 1 admin should be \*\*simple and functional\*\*, not a full CMS.



---



\# 1. Admin Panel Purpose



The admin panel allows content managers to:



Add new career paths  

Edit career content  

Add courses  

Edit course details  

Create SEO guides  

Update checklist tasks  



All content should be editable without code changes.



---



\# 2. Admin Access



Access path:



/admin



Authentication required.



Only authorized users can access admin.



Recommended access method:



Email allowlist



Example:



Only specific admin emails can login.



---



\# 3. Admin Navigation



Admin panel sidebar should include:



Dashboard  

Career Paths  

Courses  

Guides  

Checklist  

Leads  



Future sections may include analytics.



---



\# 4. Dashboard



The admin dashboard provides a simple overview.



Possible elements:



Total careers  

Total courses  

Total guides  

Total leads  



Recent activity:



Recently created guides  

Recent leads



---



\# 5. Career Paths Management



Admin can create and edit career paths.



---



\## Career Paths List



Table view.



Columns:



Career name  

Slug  

Salary range  

Training time  

Last updated  



Actions:



Edit  

Delete  



---



\## Create Career Path



Fields:



slug



Example:



qa-tester



---



name



English name



---



hebrew\_name



Example:



בודק תוכנה (QA)



---



description



Short summary



---



salary\_min



Example:



9000



---



salary\_max



Example:



14000



---



training\_time\_months



Example:



3–6 months



---



content\_sections



Editable structured content.



Includes:



Overview  

Who it suits  

Pros and cons  

How to start



---



\# 6. Courses Management



Admin can create and edit courses.



Courses are curated manually.



---



\## Courses List



Table view.



Columns:



Course name  

Provider  

Career path  

Duration  

Rating  



Actions:



Edit  

Delete



---



\## Create Course



Fields:



slug



Example:



qa-bootcamp-tel-aviv



---



course\_name



---



provider\_name



Example:



HackerU



---



career\_path



Dropdown linking to career\_paths table.



---



duration\_weeks



Example:



12



---



learning\_mode



Options:



online  

onsite  

hybrid



---



price\_range



Example:



8,000–12,000 ₪



---



editorial\_rating



Scale:



1–5



---



course\_description



Markdown supported.



---



provider\_url



External link.



---



\# 7. Guides Management



Admin can create SEO guides.



---



\## Guides List



Columns:



Title  

Slug  

Last updated  



Actions:



Edit  

Delete  



---



\## Create Guide



Fields:



slug



Example:



what-to-do-after-army



---



title\_he



Example:



מה לעשות אחרי הצבא



---



content\_markdown



Main article content.



Markdown supported.



---



SEO fields:



meta\_title  

meta\_description



---



\# 8. Checklist Management



Admin can manage checklist tasks.



---



\## Checklist Items List



Columns:



Title  

Order  



Actions:



Edit  

Delete  



---



\## Create Checklist Item



Fields:



title\_he



Example:



הרשמה לביטוח לאומי



---



description\_he



Short explanation.



---



order\_index



Controls display order.



---



\# 9. Leads Management



Admin can view submitted leads.



---



\## Leads List



Columns:



Name  

Email  

Phone  

Course  

Date  



---



Leads should be exportable.



Example export:



CSV



---



\# 10. Content Editing Strategy



Content fields should support:



Markdown



This allows:



Headings  

Lists  

Links  



Without complex editors.



---



\# 11. Validation Rules



Admin forms must validate:



Required fields  

Slug uniqueness  

Rating range



Example:



Editorial rating must be between 1–5.



---



\# 12. Security



Admin routes must be protected.



Requirements:



Authentication required  

Role verification  

CSRF protection  



---



\# 13. Phase 1 Scope



Admin panel must support:



Career paths management  

Course management  

Guide management  

Checklist management  

Lead viewing



Advanced CMS features are not required.



---



\# 14. Future Admin Features



Possible future additions:



Analytics dashboard  

Course provider management  

Bulk content import  

Content scheduling  



These are not required for Phase 1.



---



\# 15. Design Philosophy



The admin panel should be:



Simple  

Fast  

Minimal  



Editors should be able to update content in minutes.



Avoid complex CMS behavior.

