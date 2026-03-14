\# supabase-schema-to-type-sync



type: review-only



purpose:

verify alignment between Supabase schema, TypeScript types, queries/mutations, and documented data contracts.



use when:

\- migrations changed

\- database-facing types changed

\- Supabase queries or mutations changed

\- quiz results, slugs, publication flags, or persisted contracts changed



primary focus:

\- schema/type alignment

\- nullability and optionality

\- query and mutation assumptions

\- relation and join assumptions

\- enums, flags, and core data contracts



does not do:

\- migration generation

\- live database validation

\- RLS audit

\- auto-fixing in version 1



main file:

\- `SKILL.md`

