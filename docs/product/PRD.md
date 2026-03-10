# PRD.md

Product Requirements Document Product: משתחררים (Mishtachrerim)

## 1. Product Overview

"משתחררים" הוא כלי קבלת החלטות (Decision Engine) לחיילים משוחררים שעוזר
להם להבין מה הצעד הבא שלהם אחרי השירות הצבאי.

המוצר מוביל משתמשים בתהליך מונחה שמתחיל במידע שימושי ומסתיים בהמלצה על
מסלולי קריירה מתאימים ודרכי התחלה מעשיות.

הארכיטקטורה של המוצר משלבת: Static SEO site + interactive features

עמודי SEO: Guides, Checklist, Career Path Pages, Editorial Course Pages,
Course Pages

פיצ'רים אינטראקטיביים: Quiz, Results, Auth, Saved Items, User Area

Framework decision: Next.js with App Router

------------------------------------------------------------------------

## 2. Target Users

### Pre‑Discharge Soldiers

חיילים לפני שחרור שמתחילים לחשוב על העתיד המקצועי שלהם.

### Recently Discharged Soldiers

חיילים שהשתחררו לאחרונה ומחפשים כיוון קריירה או הכשרה מקצועית.

------------------------------------------------------------------------

## 3. Problem Statement

חיילים משוחררים מתקשים להבין:

-   מה לעשות אחרי הצבא
-   אילו זכויות מגיעות להם
-   האם ללמוד או לעבוד
-   איזה מקצוע מתאים להם
-   איך להשתמש בפיקדון הצבאי

המוצר נותן: מידע אמין → שאלון התאמה → מסלולי קריירה → קורסים רלוונטיים.

------------------------------------------------------------------------

## 4. Product Goals

### Primary Goals

1.  לעזור לחיילים משוחררים לבחור כיוון קריירה
2.  ליצור חוויית החלטה פשוטה וברורה
3.  לבנות אמון עם מידע אמין
4.  להמיר משתמשים ללידים לקורסים

------------------------------------------------------------------------

## 5. Core Product Flow

Homepage / SEO\
→ Guide או Checklist\
→ Quiz\
→ Results (3 Career Paths)\
→ Career Path Page\
→ Courses

------------------------------------------------------------------------

## 6. Main Components

### Homepage

Entry point לשאלון ולהבנת המוצר.

### Checklist

Checklist קל עם אפשרות שמירה אישית.

### SEO Guides

מאמרים שמובילים לשאלון.

### Intent Pages

Intent pages are SEO landing pages designed to answer
specific career and post-army questions.

Examples:

איך להיות QA Tester  
כמה מרוויח Data Analyst  
מקצועות בהייטק בלי תואר  
קורס QA עם פיקדון

These pages capture high-intent search queries and connect users to the decision flow.

Typical flow:

Intent Page  
→ Quiz  
→ Career Path Page  
→ Courses

Purpose:

• capture long-tail SEO traffic  
• answer specific user questions  
• guide users into the decision engine

### Quiz

שאלון התאמה לקריירה.

Modes: - Quick Quiz (5 questions) - Deep Quiz (10 questions)

### Results

הצגת 3 מסלולי קריירה מתאימים.

### Career Path Pages

עמודי מקצוע שהם גם: SEO page\
Trust page\
Conversion bridge to courses

### Courses

Directory קטן של 10‑30 קורסים curated.

### Course Comparison

השוואה לפי:

-   duration
-   salary range
-   deposit relevance
-   difficulty
-   learning mode

### Editorial Course Pages

עמודי SEO כמו: Best QA Courses\
Top Digital Marketing Courses

------------------------------------------------------------------------

## 7. User Accounts

Optional registration.

Benefits: - Save quiz results - Save courses - Save checklist progress

Login methods: Google\
Email

------------------------------------------------------------------------

## 8. Admin / Content Management

Admin panel לניהול:

-   Career Paths
-   Courses
-   Editorial Ratings
-   SEO Articles
-   Checklist Items

------------------------------------------------------------------------

## 9. Conversion Points

-   Course provider click
-   Lead form submission
-   Future newsletter capture

------------------------------------------------------------------------

## 10. Analytics

Events to track:

-   Quiz start
-   Quiz completion
-   Results view
-   Career page views
-   Course clicks
-   Lead submissions

------------------------------------------------------------------------

## 11. Monetization

-   Affiliate commissions
-   Lead generation
-   Future sponsored listings

------------------------------------------------------------------------

## 12. Trust & Disclosure

-   Affiliate disclosure
-   Salary estimates as ranges
-   Deposit eligibility caution
-   Links to official sources

------------------------------------------------------------------------

## 13. Phase 1 Scope

Included:

-   Homepage
-   Checklist
-   Quiz
-   Matching engine
-   Results
-   Career paths
-   Courses
-   Course comparison
-   Editorial course pages
-   SEO articles
-   Admin panel
-   Analytics

Not included:

-   Community
-   Forum
-   Job board
-   Open marketplace
-   Complex AI
