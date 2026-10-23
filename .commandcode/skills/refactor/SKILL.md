---
name: refactor
description: Safely restructure existing code without changing behavior, following the repo's current architecture. Use when asked to clean up, simplify, deduplicate, split large files/functions, rename, or migrate patterns incrementally.
---
# Refactor (behavior-preserving)

1. State the goal in one sentence and the **behavior that must not change**.
2. Ensure a safety net: existing tests pass; if the area is untested, add characterization tests first (`test-writer`).
3. Apply `analyze-codebase`: target structure must match existing conventions, not personal taste.
4. Work in small steps; each step compiles and passes tests. Order: rename/move → extract → dedupe → simplify.
5. Don't mix behavior, API, or formatting-only changes in. Public API changes need explicit user approval.
6. Run tests, linter, type-check after each step. Compare before/after complexity honestly.
7. Log via `dev-log` (`refactor`), listing moved/renamed files so history stays traceable.
