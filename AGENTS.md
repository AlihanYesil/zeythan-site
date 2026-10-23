# AGENTS.md — Project Operating Rules (read this first)

Works for any AI coding tool (Claude Code, Codex, Cursor, Gemini CLI, Copilot...).
Claude Code users: `CLAUDE.md` imports this file.

## 1. Start of every session (mandatory, cheap)
1. Read `docs/devlog/INDEX.md` (project snapshot + numbered history). Do NOT read all entries.
2. Open only the entries relevant to your task (follow the links in the index).
3. If the project is new to you or the snapshot is empty/stale: run the `onboard` skill (`.commandcode/skills/onboard/SKILL.md`).

## 2. Golden rules
- **Existing code is the source of truth.** Before writing code, find 2-3 similar files and copy their structure, naming, error handling, test style, and dependencies. Never introduce a new library/pattern if the repo already has one for the job (`analyze-codebase` skill).
- **Measure before optimizing, verify after.** No speculative micro-optimizations. Use the `optimize` skill.
- **Smallest correct change.** No drive-by refactors, no unrelated reformatting, no new abstractions without 2+ real call sites.
- **Token/context discipline.** Search (grep/glob) before reading; read ranges, not whole files; delegate broad exploration to the `codebase-explorer` agent; never paste large outputs back.
- **Never invent.** If an API, flag, or file is unknown, check the code/docs; if still unknown, say so.
- **Ask only when blocked** by a decision that is expensive to reverse. Otherwise state the assumption and proceed.

## 3. End of every task (mandatory)
Run the `dev-log` skill: create a numbered entry and update `docs/devlog/INDEX.md`.
Quick way: `bash scripts/devlog-new.sh <type> "<title>"` then fill in the entry.
Types: `feat | fix | perf | refactor | docs | chore | decision`.
Skip logging only for trivial typo-level edits.

## 4. Skills and agents map
| Need | Use |
|---|---|
| Understand a new/unfamiliar repo | skill `onboard` |
| Before any change in existing code | skill `analyze-codebase` |
| Performance / memory / bundle / query cost | skill `optimize` + agent `optimizer` |
| Restructure without behavior change | skill `refactor` |
| Bug, failing test, error trace | skill `debug` + agent `debugger` |
| Add/repair tests | skill `test-writer` + agent `test-writer` |
| Review a diff before finishing | skill `code-review` + agent `code-reviewer` |
| Broad read-only search of the repo | agent `codebase-explorer` |
| Keep the devlog correct | skill `dev-log` + agent `devlog-keeper` |

## 5. Language
Devlog entries and user-facing explanations: **Turkish** (change here if needed). Code, identifiers, commit messages: follow existing repo convention.
