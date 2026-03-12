-- ============================================================
-- Migration: 003_career_path_content
-- Project:   Mishtachrerim
-- Phase:     3B
--
-- Populates the 10 base career path rows inserted by 002_quiz_seed_data
-- with real Hebrew content and sets is_published = true.
--
-- Scope:
--   - page_type = 'career' rows only (all 10 base careers)
--   - No intent pages
--   - No schema changes
--
-- title stores the base English career name only.
-- The H1 suffix (— מה זה, כמה מרוויחים ואיך מתחילים) is appended by
-- CareerPageContent at render time.
-- The SEO title suffix (— שכר, זמן הכשרה והאם זה מתאים לכם) is appended
-- by generateMetadata at render time.
--
-- difficulty_level uses three controlled values: נמוך | בינוני | גבוה
-- salary_range includes the qualifier למתחילים within the string.
-- ============================================================


-- ── full-stack-developer ─────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Full Stack Developer',
  short_description = 'Full Stack Developer הוא מפתח שעובד הן על ממשק המשתמש (Front End) והן על הלוגיקה והשרתים (Back End). ההכשרה ארוכה יחסית, אך מובילה לאחד טווחי השכר הגבוהים בשוק ההייטק.',
  long_description  = 'מפתח Full Stack אחראי על פיתוח יישומי web מקצה לקצה — ממשק המשתמש, הלוגיקה העסקית, מסדי הנתונים וחיבורי ה-API. הכלים הנפוצים כוללים JavaScript, Python, React, Node.js ו-SQL.

המקצוע דורש יכולת לימוד עצמאית גבוהה ונכונות לבנות פרויקטים מעשיים לאורך זמן. רקע בתוכנה, סיסטמות או לוגיקה מהצבא הוא יתרון, אך אנשים ללא רקע טכני נכנסים לתחום לאחר הכשרה מספקת.

הדרך הנפוצה להיכנס היא בוטקאמפ פיתוח web או לימוד עצמי ממוקד עם פרויקטים. מדובר במסלול שדורש השקעה של כ-12–18 חודשים לפני חיפוש עבודה ראשון.',
  salary_range      = '15,000–25,000 ₪ למתחילים',
  training_time     = '12–18 חודשים',
  difficulty_level  = 'גבוה',
  example_roles     = 'מפתח Full Stack, מפתח Front End, מפתח Back End, Web Developer',
  is_published      = true
WHERE slug = 'full-stack-developer';


-- ── data-analyst ─────────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Data Analyst',
  short_description = 'Data Analyst הוא מקצוע שמתמקד בניתוח נתונים ועזרה לארגונים לקבל החלטות מבוססות מידע. דורש רקע אנליטי חזק ונכונות להשקיע בלמידה טכנית.',
  long_description  = 'אנליסט נתונים עובד עם כלים כמו SQL, Python, Excel ו-Tableau כדי לנתח מידע עסקי ולהגיש תובנות לצוותי ניהול. העבודה כוללת איסוף נתונים ממקורות שונים, ניקוי, עיבוד והצגה ברורה של ממצאים.

המקצוע מתאים למי שנוח לו עם מספרים, שם לב לפרטים, ויכול לתרגם נתונים גולמיים לתמונה ברורה. רקע מהצבא בתחומי מודיעין, לוגיסטיקה, פיקוד ושליטה, או כל תפקיד שכלל עבודה שיטתית עם נתונים — רלוונטי לתפקיד.

הכניסה לתחום דרך קורס ממוקד דורשת לימוד SQL, Python ובסיסי סטטיסטיקה. פרויקטים אישיים ו-portfolio ב-GitHub מסייעים להדגים יכולות בפני מעסיקים.',
  salary_range      = '12,000–20,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'גבוה',
  example_roles     = 'אנליסט נתונים, Data Analyst, BI Analyst, Business Analyst',
  is_published      = true
WHERE slug = 'data-analyst';


-- ── qa-tester ─────────────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'QA Tester',
  short_description = 'QA Tester הוא מקצוע שמתמקד בבדיקת תוכנות ומערכות לפני שחרורן למשתמשים. אחד ממסלולי הכניסה הנגישים להייטק, גם ללא ניסיון תכנות מוקדם.',
  long_description  = 'בודק תוכנה אחראי על איתור תקלות ובאגים במוצרים דיגיטליים לפני שחרורם ללקוחות. הוא כותב תסריטי בדיקה, מתעד ממצאים, ועובד בשיתוף פעולה עם צוותי הפיתוח.

המקצוע מתאים למי שמדויק, שם לב לפרטים, ויכול לחשוב על תרחישי כשל. לא נדרש רקע בתכנות כדי להתחיל ב-QA ידני — ידע ב-QA אוטומטי מרחיב את אפשרויות הקידום והשכר בשלב מאוחר יותר.

הדרך הנפוצה להיכנס היא קורס QA ממוקד. תפקידי Junior QA הם נקודת כניסה נפוצה, עם אפשרות לעבור לאוטומציה ולניהול בדיקות בהמשך.',
  salary_range      = '9,000–14,000 ₪ למתחילים',
  training_time     = '3–6 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'בודק תוכנה, QA Engineer, Automation Tester, QA Analyst',
  is_published      = true
WHERE slug = 'qa-tester';


-- ── ux-ui-designer ───────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'UX/UI Designer',
  short_description = 'UX/UI Designer הוא מקצוע שמשלב עיצוב חזותי עם הבנת חוויית משתמש. נמצא בצומת של טכנולוגיה ויצירתיות, ודורש בניית portfolio מעשי כחלק מהכשרה.',
  long_description  = 'מעצב UX/UI אחראי על האופן שבו נראים ומרגישים מוצרים דיגיטליים — אתרים, אפליקציות ומערכות. UX מתמקד בחוויה וב-flow של המשתמש; UI מתמקד בעיצוב הוויזואלי. בשוק הישראלי שני התחומים משולבים לרוב בתפקיד אחד.

הכלים הנפוצים הם Figma ו-Adobe XD. המקצוע מתאים למי שמסוגל לחשוב מנקודת מבט המשתמש ומוכן לשלב בין אסתטיקה לפונקציונליות. ניסיון בהדרכה, תכנון תהליכים, או ממשקי מערכת מהצבא יכול להיות רלוונטי.

הכניסה לתחום דורשת קורס ממוקד ובניית portfolio. הפורטפוליו הוא אמצעי הסינון העיקרי בתחום זה — לא פחות חשוב מהתעודה.',
  salary_range      = '10,000–18,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'מעצב UX/UI, Product Designer, UX Researcher, UI Designer',
  is_published      = true
WHERE slug = 'ux-ui-designer';


-- ── digital-marketing ────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Digital Marketing',
  short_description = 'Digital Marketing כולל ניהול קמפיינים ממומנים, SEO, סושיאל מדיה ואימייל מרקטינג. תחום רחב עם כניסה אפשרית ללא רקע טכני ומגוון נתיבי התמחות.',
  long_description  = 'אנשי שיווק דיגיטלי עובדים על קמפיינים ב-Google Ads, Meta Ads, SEO ורשתות חברתיות. המטרה היא להגדיל תנועה, לייצר לידים, ולמדוד אפקטיביות בעזרת נתונים.

לא נדרש רקע טכני מעמיק. יכולת ניתוח נתונים וכתיבה שיווקית הן יתרון ברור. ניסיון בניהול משימות ועמידה ביעדים מהצבא רלוונטי לניהול קמפיינים שוטף.

הכניסה לתחום אפשרית דרך קורס ממוקד ופרויקטים אישיים. הסמכות כמו Google Ads ו-Meta Blueprint עוזרות להציג ידע בסיסי בפני מעסיקים.',
  salary_range      = '8,000–15,000 ₪ למתחילים',
  training_time     = '3–6 חודשים',
  difficulty_level  = 'נמוך',
  example_roles     = 'מנהל קמפיינים, Performance Marketer, מנהל סושיאל מדיה, SEO Specialist',
  is_published      = true
WHERE slug = 'digital-marketing';


-- ── it-support ───────────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'IT Support',
  short_description = 'IT Support הוא תפקיד שמטפל בתשתיות מחשוב, פתרון תקלות ותמיכה טכנית בארגונים. נקודת כניסה נגישה לתחום הטכנולוגי, עם ביקוש יציב.',
  long_description  = 'אנשי IT Support מטפלים בתקלות טכניות, מנהלים חשבונות משתמשים, ומסייעים לעובדים בבעיות יומיומיות. העבודה כוללת תמיכה במחשבים, מערכות הפעלה ורשתות ארגוניות.

אנשים עם רקע תקשוב צבאי — ממ"מים, מפעילי מערכות, אנשי תחזוקה — מגיעים עם ידע ישיר הרלוונטי לתפקיד. ניסיון עם חומרה, מערכות הפעלה ותשתיות מפחית את זמן ההסתגלות לתפקיד.

ניתן להיכנס לתחום גם ללא קורס פורמלי. הסמכות כמו CompTIA A+ ו-Microsoft מאפשרות קידום לתפקידי System Administrator בהמשך.',
  salary_range      = '8,000–13,000 ₪ למתחילים',
  training_time     = '3–6 חודשים',
  difficulty_level  = 'נמוך',
  example_roles     = 'תומך IT, Help Desk Technician, IT Support Specialist, System Administrator',
  is_published      = true
WHERE slug = 'it-support';


-- ── network-technician ───────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Network Technician',
  short_description = 'Network Technician הוא טכנאי שמתמחה בהתקנה, תפעול ואבחון של רשתות תקשורת. מתאים לאנשים עם רקע תקשוב צבאי ולמי שמחפש עבודה טכנית מעשית.',
  long_description  = 'טכנאי רשתות מתקין ומתחזק תשתיות רשת — נתבים, סוויצ׳ים, Firewalls ו-VPN. הוא מאבחן תקלות ומוודא שהתשתית פועלת בצורה תקינה ומאובטחת.

רקע צבאי בתחום תקשוב, קשר, או ניהול מערכות תקשורת רלוונטי ישירות לתפקיד. ידע בציוד תקשורת ופרוטוקולי רשת מהשירות מפחית את עקומת הלמידה.

הסמכות כמו CCNA של Cisco ו-CompTIA Network+ הן אמות המידה הנפוצות בתחום. קורס רשתות ממוקד מכין לתפקידי אדמיניסטרציה ואבטחת רשתות.',
  salary_range      = '9,000–16,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'טכנאי רשתות, Network Administrator, Network Engineer, תומך תשתיות',
  is_published      = true
WHERE slug = 'network-technician';


-- ── project-management ───────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Project Management',
  short_description = 'ניהול פרויקטים הוא מקצוע שעוסק בתכנון, תיאום וביצוע פרויקטים בארגונים. ניסיון פיקודי מהצבא מספק בסיס רלוונטי לתפקיד.',
  long_description  = 'מנהל פרויקטים אחראי על תכנון לוחות זמנים, תיאום בין צוותים, מעקב אחר התקדמות וזיהוי סיכונים. הוא מוודא שהפרויקט מגיע ליעדו בזמן ובמסגרת התקציב.

ניסיון פיקודי, ניהול מבצעים, ניהול לוגיסטי, או עמידה ביעדים תחת לחץ — כולם רלוונטיים לתפקיד. מעסיקים רבים מכירים בניסיון הצבאי כבסיס מקצועי תקף לתחום זה.

לתפקידים בהייטק נדרש לרוב ידע בשיטות Agile ו-Scrum, ולעיתים הסמכה כמו PMP. שילוב של ניסיון תפעולי מהצבא עם קורס ממוקד הוא מסלול כניסה נפוץ.',
  salary_range      = '12,000–22,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'מנהל פרויקטים, Project Manager, Scrum Master, Program Manager',
  is_published      = true
WHERE slug = 'project-management';


-- ── graphic-design ───────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Graphic Design',
  short_description = 'Graphic Design הוא מקצוע שעוסק ביצירת חומרים ויזואליים לדיגיטל ולדפוס. מאפשר עבודה שכירה בסוכנויות ובחברות, או עצמאית כפרילנסר.',
  long_description  = 'מעצב גרפי יוצר חומרי שיווק, לוגואים, פוסטים לרשתות חברתיות ומצגות. הכלים הנפוצים הם Adobe Photoshop, Illustrator ו-Canva.

המקצוע מתאים למי שנוח לו עם כלים ויזואליים ורוצה עבודה שמאפשרת ביטוי עצמי. ניתן להשתלב כשכיר במחלקות שיווק וסוכנויות פרסום, או לעבוד כפרילנסר.

הכניסה לתחום דורשת קורס ממוקד ובניית portfolio. בתחום זה הפורטפוליו הוא אמצעי ההערכה המרכזי — פרויקטים מעשיים חשובים לא פחות מהתעודה.',
  salary_range      = '7,000–14,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'מעצב גרפי, Graphic Designer, מעצב דיגיטל, מעצב שיווקי',
  is_published      = true
WHERE slug = 'graphic-design';


-- ── ecommerce-manager ────────────────────────────────────────────────────────

UPDATE public.career_paths SET
  title             = 'Ecommerce Manager',
  short_description = 'Ecommerce Manager הוא מנהל שמוביל את הפעילות המסחרית של חנות אונליין. תפקיד שמשלב ניהול שוטף, שיווק דיגיטלי וניתוח נתונים.',
  long_description  = 'מנהל איקומרס אחראי על הפעלת חנות אונליין — ניהול מוצרים ומלאי, אופטימיזציה של עמודי מוצר, ניהול קמפיינים שיווקיים ומעקב אחר מדדי ביצוע כמו המרות ועגלות נטושות.

התפקיד מתאים למי שיכול לעבוד עם נתונים, מבין שיווק דיגיטלי, ויודע לנהל מספר ערוצים במקביל. ניסיון בניהול, לוגיסטיקה, או ניהול משאבים מהצבא רלוונטי לתפקיד.

הכניסה לתחום אפשרית דרך ניסיון מעשי עם פלטפורמות כמו Shopify ו-WooCommerce, בשילוב קורס בשיווק דיגיטלי. קיים מגוון תפקידים בתחום — מניהול חנות קטנה ועד ניהול מחלקת מסחר דיגיטלי בחברה גדולה.',
  salary_range      = '10,000–18,000 ₪ למתחילים',
  training_time     = '6–12 חודשים',
  difficulty_level  = 'בינוני',
  example_roles     = 'מנהל חנות אונליין, Ecommerce Manager, מנהל מכירות דיגיטליות, Digital Commerce Specialist',
  is_published      = true
WHERE slug = 'ecommerce-manager';
