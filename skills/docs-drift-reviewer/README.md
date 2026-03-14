\# docs-drift-reviewer



type: review-only



purpose:

detect implementation-to-doc drift and relevant doc inconsistency against the project source of truth.



use when:

\- a feature batch was completed

\- routing, SEO, env, schema, or quiz behavior changed

\- you want to verify that implementation still matches `/docs`



primary focus:

\- code-to-doc drift

\- relevant doc-to-doc inconsistency

\- scope, routing, SEO, env, and data drift signals



does not do:

\- build/lint/test execution

\- auto-fixing

\- generic code review



main file:

\- `SKILL.md`

