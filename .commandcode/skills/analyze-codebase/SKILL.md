---
name: analyze-codebase
description: Study existing code and conventions BEFORE making changes so new code matches the current structure. Use before adding features, modules, endpoints, components, or tests in an existing repository, or whenever asked to "mevcut yapıya uygun" / "follow existing patterns".
---
# Analyze Codebase (pattern-first)

Rule: new code must look like it was written by the same team.

## Steps
1. **Locate the neighborhood**: grep for the feature's nouns/verbs; find the 2-3 closest existing implementations (same layer, same kind).
2. **Extract the pattern** from them (6-10 bullets, kept in scratch, not in the repo):
   - file/folder placement and naming
   - layering (controller/service/repo, component/hook/store, etc.)
   - error handling and logging style
   - validation, typing, config/env access
   - data access / API client usage
   - tests: location, framework, fixtures, naming
   - existing helpers/utilities that already solve part of the task (reuse > rewrite)
3. **Check dependencies**: use what's installed. Adding a dependency requires a stated reason and no equivalent in the repo.
4. **Check git history** when intent is unclear: `git log --oneline -n 15 -- <path>`.
5. **Plan** the minimal diff: files to touch/create (1 line each) and which pattern each follows.
6. Implement. Match formatter/linter config; run them.
7. Self-check: would a reviewer see a new style, new lib, or duplicate helper? If yes, fix.

## Anti-patterns
Rewriting working code "to be cleaner"; mixing styles in one file; creating utils that already exist; adding config layers nobody uses.
