# Skills

This directory contains the project-specific guardrail skills for the משתחררים / הצעד הבא platform.

These skills are designed to improve quality, consistency, and safety when working in a cloud-only, documentation-driven workflow with Claude Code.

## Principles

These skills are intentionally:

- narrow
- reusable
- project-specific
- guardrail-oriented
- phase-aware

They are not broad generic helpers.
They exist to reduce the highest-risk failure modes in this project.

## Current Skills

### 1. [docs-drift-reviewer](./docs-drift-reviewer/README.md)
**Type:** review-only  
**Purpose:** detect implementation-to-doc drift and relevant doc inconsistency against the project source of truth.

Use when:
- a feature batch was completed
- routing or data behavior changed
- SEO behavior changed
- you want to verify code still matches `/docs`

---

### 2. [post-batch-architecture-reviewer](./post-batch-architecture-reviewer/README.md)
**Type:** review-only  
**Purpose:** review a completed implementation batch for architecture adherence, boundary correctness, and scope control.

Use when:
- Claude Code finished a batch
- you want to verify routing, auth, server/client boundaries, and data-layer consistency
- you want to catch premature abstractions or scope creep

---

### 3. [cloud-build-and-lint-gatekeeper](./cloud-build-and-lint-gatekeeper/README.md)
**Type:** enforcement-oriented  
**Purpose:** run the approved technical verification gate for the current batch using repo-native commands.

Use when:
- a batch is ready for validation
- you want to run the mechanical gate before commit/push/deploy
- you need a clear PASS / FAIL / BLOCKED result

---

### 4. [strict-rtl-hebrew-ui-inspector](./strict-rtl-hebrew-ui-inspector/README.md)
**Type:** review-only  
**Purpose:** inspect RTL correctness and Hebrew UI quality from code, markup, classnames, and UI structure.

Use when:
- UI components or pages changed
- Hebrew/RTL behavior may have been affected
- you want to catch LTR leakage, BiDi issues, directional icon mistakes, or RTL layout regressions

---

### 5. [app-router-seo-and-metadata-auditor](./app-router-seo-and-metadata-auditor/README.md)
**Type:** review-only  
**Purpose:** audit SEO-critical App Router implementation behavior, including metadata, canonical logic, index/noindex rules, route-role correctness, and page-intent correctness.

Use when:
- public routes changed
- `generateMetadata` changed
- canonical or indexability logic changed
- career / intent / guides / editorial / course route behavior changed

---

### 6. [supabase-schema-to-type-sync](./supabase-schema-to-type-sync/README.md)
**Type:** review-only  
**Purpose:** verify alignment between Supabase schema, TypeScript types, queries/mutations, and documented data contracts.

Use when:
- migrations changed
- database-facing types changed
- Supabase queries or mutations changed
- quiz results, career linkage, slugs, publication flags, or persisted contracts changed

## Suggested Usage Order

These skills were designed with a practical review sequence in mind:

1. [docs-drift-reviewer](./docs-drift-reviewer/README.md)
2. [post-batch-architecture-reviewer](./post-batch-architecture-reviewer/README.md)
3. [strict-rtl-hebrew-ui-inspector](./strict-rtl-hebrew-ui-inspector/README.md) *(when UI changed)*
4. [app-router-seo-and-metadata-auditor](./app-router-seo-and-metadata-auditor/README.md) *(when public SEO routes changed)*
5. [supabase-schema-to-type-sync](./supabase-schema-to-type-sync/README.md) *(when schema/types/data access changed)*
6. [cloud-build-and-lint-gatekeeper](./cloud-build-and-lint-gatekeeper/README.md)

Not every batch needs every skill.
Apply the ones relevant to the changed surface.

## Current Status

These six skills are the core guardrail set for the project.

Lower-priority future skills may be added later, but only if they solve a real workflow problem and justify their maintenance cost.