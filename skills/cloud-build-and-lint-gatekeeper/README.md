\# cloud-build-and-lint-gatekeeper



type: enforcement-oriented



purpose:

run the approved technical verification gate for the current batch using repo-native commands.



use when:

\- a batch is ready for technical validation

\- you want a pass/fail/blocked result before commit or push

\- you need the repo-native verification loop to run in the cloud workflow



primary focus:

\- command detection

\- type-check

\- lint

\- tests

\- build sanity

\- gate status reporting



does not do:

\- architecture review

\- docs review

\- auto-repair in version 1



main file:

\- `SKILL.md`

