---
name: code-review
description: Review a diff or set of changes for correctness, security, performance, consistency with existing conventions, and missing tests/logs. Use before finishing a task, before commit/PR, or when asked to review.
---
# Code Review

1. Get the change: `git diff` (staged + unstaged) or the given files. Read the diff, then only the surrounding code needed.
2. Check in priority order:
   1. **Correctness**: logic, edge cases, error handling, concurrency, resource leaks.
   2. **Security**: input validation, injection, authz, secrets, unsafe deserialization, dependency risk.
   3. **Performance**: N+1, unbounded loops/memory, needless I/O, hot-path allocation.
   4. **Consistency**: matches existing patterns/naming/libs; no duplicated helpers.
   5. **Tests & docs**: behavior covered; devlog entry exists.
   6. **Scope**: unrelated changes, dead code, debug leftovers.
3. Report grouped by severity, each item `path:line — problem — suggested fix`:
   🔴 Must fix · 🟡 Should fix · 🟢 Nit (max 3)
4. End with a one-line verdict: ship / fix first.
No praise padding, no restating the diff. If nothing is wrong, say so briefly.
