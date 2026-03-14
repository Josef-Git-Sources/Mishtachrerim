\# post-batch-architecture-reviewer



type: review-only



purpose:

review a completed implementation batch for architecture adherence, boundary correctness, and scope control.



use when:

\- Claude Code finished an implementation batch

\- routing or data-layer structure changed

\- you want to catch architectural violations before accepting the batch



primary focus:

\- routing consistency

\- server/client boundaries

\- auth and data-layer patterns

\- premature abstractions

\- scope creep



does not do:

\- docs drift review

\- build/lint/test execution

\- generic style review



main file:

\- `SKILL.md`

