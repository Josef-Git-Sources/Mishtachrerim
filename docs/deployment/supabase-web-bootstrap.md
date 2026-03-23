# Supabase Web Bootstrap Guide

**Audience:** Beginner. No local tools required.
**What this covers:** Initializing the Mishtachrerim database using only a web browser.
**What this does NOT cover:** Auth UI, Google login, admin features, or production hardening.

---

## Before You Start

You need two browser tabs open:
- **GitHub** — to read the SQL files in this repo
- **Supabase Dashboard** → your project → **SQL Editor**

You do NOT need: Node, npm, the Supabase CLI, or a local terminal.

---

## Step 0 — Create a Supabase Project

If you haven't already:

1. Go to [https://supabase.com](https://supabase.com) and sign in
2. Click **New project**
3. Choose a name (e.g. `mishtachrerim`), set a strong database password, choose a region close to your users (e.g. `eu-central-1` for Israel)
4. Wait for the project to finish provisioning (~60 seconds)

---

## Step 1 — Collect Your Environment Variables

You will need these three values. Find them in the Supabase Dashboard:

**Settings → API** (left sidebar)

| Variable | Where to find it | Required? |
|---|---|---|
| `NEXT_PUBLIC_SUPABASE_URL` | "Project URL" | ✅ Required now |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | "anon public" key | ✅ Required now |
| `NEXT_PUBLIC_SITE_URL` | Your deployment URL (e.g. Vercel) | ✅ Required now |
| `SUPABASE_SERVICE_ROLE_KEY` | "service_role" key | ❌ Not needed yet — future admin features only |

> **Warning:** Never commit any of these values to git. Copy `.env.local.example` to `.env.local` and fill them in locally or in your hosting provider's environment settings.

> **Warning:** The `service_role` key bypasses all database security. Do not use it in the app until Phase 2 admin features are built. It is safe to leave `SUPABASE_SERVICE_ROLE_KEY` unset for now — the app does not read it.

---

## Step 2 — Run the Migrations in the SQL Editor

Go to: **Supabase Dashboard → SQL Editor** (left sidebar)

Run the following SQL files **in the exact order listed**. Each step depends on the previous one.

**Option A (below) is recommended for beginners** — it lets you validate each step before moving on. Option B is a convenience shortcut if you prefer a single copy-paste.

---

### Option A — Recommended: Run Each File Individually

Run these files in order. After each one, check for errors before proceeding to the next.

#### File 1 of 7: `supabase/migrations/001_initial_schema.sql`

**What it does:** Creates all database tables, extensions, and indexes.
**Safe to re-run:** Yes — all statements use `CREATE ... IF NOT EXISTS`.
**Destructive:** No.

1. Open `supabase/migrations/001_initial_schema.sql` in GitHub
2. Click the **Raw** button
3. Select all text (Ctrl+A / Cmd+A) and copy
4. Paste into the Supabase SQL Editor and click **Run**

**Validate:** Click **Table Editor** in the left sidebar. You should see these tables:
- `career_paths`, `courses`, `course_career_paths`
- `quiz_questions`, `quiz_answers`, `quiz_answer_scores`
- `quiz_results`, `quiz_result_careers`
- `users`, `guides`, `checklist_items`, `leads`

---

#### File 2 of 7: `supabase/migrations/002_quiz_seed_data.sql`

**What it does:** Inserts 10 career path stubs (unpublished), 10 quiz questions, all answer options, and all answer→career score mappings.
**Safe to re-run:** Yes — all inserts use `ON CONFLICT DO NOTHING`.
**Destructive:** No.
**Depends on:** File 1 must have run first.

**Validate:** In Table Editor → `quiz_questions`: you should see 10 rows (q1–q10).
In `quiz_answers`: you should see ~36 rows total.
In `career_paths`: you should see 10 rows, all with `is_published = false`.

---

#### File 3 of 7: `supabase/migrations/003_career_path_content.sql`

**What it does:** Updates the 10 career path stubs with full Hebrew content and sets `is_published = true`.
**Safe to re-run:** Yes — these are `UPDATE` statements; re-running overwrites with the same values.
**Destructive:** No.
**Depends on:** File 2 must have run first (stubs must exist before they can be updated).

**Validate:** In Table Editor → `career_paths`: all 10 rows should now show `is_published = true` and have non-empty `short_description`.

---

#### File 4 of 7: `supabase/migrations/004_course_seed_data.sql`

**What it does:** Inserts 5 courses and links them to their career paths via the junction table.
**Safe to re-run:** Yes — courses use `ON CONFLICT DO UPDATE`, junction rows use `ON CONFLICT DO NOTHING`.
**Destructive:** No.
**Depends on:** File 3 must have run first.

> **Important:** This file has a pre-flight safety check. If it detects that any required career path is missing or not published, it will stop immediately with a clear error message. This means File 3 was not run correctly — go back and re-run File 3 before continuing.

**Validate:** In Table Editor → `courses`: you should see 5 rows, all with `is_published = true`.
In `course_career_paths`: you should see 5 rows linking each course to its career path.

---

#### File 5 of 7: `supabase/migrations/005_intent_page_seed.sql`

**What it does:** Inserts 4 intent pages (QA and Data Analyst focused queries) into `career_paths`.
**Safe to re-run:** Yes — uses `ON CONFLICT DO UPDATE`.
**Destructive:** No.
**Depends on:** File 1 only.

**Validate:** In Table Editor → `career_paths`: row count should be 14 (10 career + 4 intent).

---

#### File 6 of 7: `supabase/migrations/006_intent_page_seed_5b.sql`

**What it does:** Inserts 8 more intent pages (QA, Data Analyst, Digital Marketing, UX/UI) into `career_paths`.
**Safe to re-run:** Yes — uses `ON CONFLICT DO UPDATE`.
**Destructive:** No.
**Depends on:** File 1 only.

**Validate:** In Table Editor → `career_paths`: row count should be 22 (10 career + 12 intent).

---

#### File 7 of 7: `supabase/migrations/007_quiz_hebrew_text.sql`

**What it does:** Updates all 10 quiz questions and 36 quiz answers from English placeholder text to Hebrew. Does not change score mappings or any other data.
**Safe to re-run:** Yes — these are `UPDATE` statements; re-running overwrites with the same values.
**Destructive:** No.
**Depends on:** File 2 must have run first (the rows being updated must exist).

**Validate:** In SQL Editor:
```sql
SELECT question_key, question_text FROM public.quiz_questions ORDER BY display_order;
-- All question_text values should now be in Hebrew.
```

---

### Option B — Single Combined File (Convenience)

A combined file with all 7 migrations in the correct order is available at:

```
supabase/manual_bootstrap.sql
```

Open that file in GitHub (browse to it in the repo on the `claude/mishtachrerim-implementation-QjUtM` branch), click the **Raw** button, select all, copy, paste into the Supabase SQL Editor, and click **Run**.

If it runs without errors, skip to **Step 3 — Validate**.

If you see an error, switch to Option A and run each file individually to identify which migration failed.

> **Note:** The combined file contains only the exact content of the 7 migration files in order. No statements were added, removed, or changed.

---

## Step 3 — Validate the Full Setup

Run these SQL queries in the SQL Editor to confirm the database is ready.

**Validate career paths:**
```sql
SELECT slug, page_type, is_published FROM public.career_paths ORDER BY page_type, slug;
```
Expected: 10 rows with `page_type = 'career'` (all `is_published = true`), 12 rows with `page_type = 'intent'` (all `is_published = true`).

**Validate quiz data:**
```sql
SELECT COUNT(*) FROM public.quiz_questions WHERE is_active = true;
-- Expected: 10

SELECT COUNT(*) FROM public.quiz_answers;
-- Expected: 36

SELECT COUNT(*) FROM public.quiz_answer_scores;
-- Expected: 82
```

**Validate courses:**
```sql
SELECT slug, is_published FROM public.courses ORDER BY slug;
-- Expected: 5 rows, all is_published = true
```

**Validate course-career links:**
```sql
SELECT COUNT(*) FROM public.course_career_paths;
-- Expected: 5
```

---

## Step 4 — Configure Environment Variables in Your Hosting Provider

Set these in your hosting platform (e.g. Vercel → Project Settings → Environment Variables):

```
NEXT_PUBLIC_SUPABASE_URL=https://your-project-ref.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-public-key
NEXT_PUBLIC_SITE_URL=https://your-deployment-url.vercel.app
```

**Do not set** `SUPABASE_SERVICE_ROLE_KEY` yet. It is not used by the current code.

After setting environment variables, trigger a redeploy.

---

## Step 5 — Smoke Test the Live Deployment

Visit these URLs after deployment to confirm the funnel works end to end:

| URL | What to check |
|---|---|
| `/quiz` | Quiz questions load (5 questions in default/quick mode) |
| `/quiz?mode=deep` | 10 questions load |
| `/career/qa-tester` | Career page renders with Hebrew content and a linked course |
| `/career/how-to-become-qa` | Intent page renders with content |
| `/career/data-analyst` | Career page renders |

To validate quiz submission end to end:
1. Open `/quiz`, complete all questions, and submit
2. You should be redirected to `/results/[uuid]`
3. The results page should show 3 ranked career recommendations with links

---

## What You Do NOT Need to Do Before First Deployment

- ❌ Set up Google OAuth — login pages are placeholder stubs in this phase
- ❌ Configure Supabase Auth redirect URLs — auth is not implemented yet
- ❌ Enable Row Level Security — RLS is not configured in these migrations; tables are accessible via the anon key by default, which is what the public funnel requires
- ❌ Set `SUPABASE_SERVICE_ROLE_KEY` — not used in Phase 1 code

---

## Risks and Caveats

| Risk | Severity | Notes |
|---|---|---|
| RLS not enabled | Medium — address before going to real production | All tables are accessible to the anon key. This is intentional for Phase 1. Before launching with real users or lead data, enable RLS and add policies. |
| No rate limiting on `/api/quiz/submit` | Low for validation, address before production | Quiz submission has no rate limiting. Not a concern for early testing. |
| `provider_url` is NULL for all courses | Low | Courses have `provider_url = NULL` in the seed data. Course detail pages render without external links for now. |
| Migrations 005 and 006 only need File 1, not Files 2–4 | Informational | Intent pages are independent of quiz and course data. They could theoretically run right after File 1, but running them after File 4 (as shown above) is the correct and safe order for a clean setup. |

---

## If Something Goes Wrong

**"relation does not exist" error in File 2, 3, or 4:**
File 1 did not run successfully. Re-run File 1 and verify the tables exist before continuing.

**"Pre-flight failed: required career path slugs not found or not published" in File 4:**
File 3 did not run successfully (or File 2 didn't run before File 3). Re-run Files 2 and 3 in order, then re-run File 4.

**Quiz page shows no questions:**
File 2 did not run. Run File 2 then File 3 in order.

**Career pages 404:**
File 3 did not run, so `is_published = false` for all career paths. Run File 3.

**Environment variable error on startup:**
The app throws at startup if any of the three required vars are missing. Check your hosting platform's environment settings and redeploy.

