---
name: dev-log
description: Record each completed development step as a numbered devlog entry and keep docs/devlog/INDEX.md up to date so any other AI or developer can understand the project history step by step. Use at the end of every feature, fix, optimization, refactor, or decision, and when the user says "kaydet", "logla", "geliştirmeyi indexle".
---
# Dev Log (numbered index → detail entries)

Structure (ADR/changelog hybrid):
```
docs/devlog/INDEX.md            # snapshot + numbered table, links to entries
docs/devlog/TEMPLATE.md         # entry template
docs/devlog/entries/NNNN-<type>-<slug>.md
```
Numbers are sequential, zero-padded, never reused or renumbered. Past entries are **not rewritten**; corrections are new entries that reference the old one (`Supersedes: #0007`).

## Steps
1. `bash scripts/devlog-new.sh <type> "<short title>"` → creates the next entry from the template and appends a row to INDEX.md. (If the script can't run, do it manually: next number = last + 1.)
2. Fill the entry (Turkish, concise, factual). Required sections: Özet, Bağlam/Neden, Yapılanlar (file list with 1-line purpose), Kararlar ve alternatifler, Etki (numbers for `perf`), Doğrulama (exact commands/results), Sonraki adımlar.
3. Update the INDEX.md row: set Status (`done | in-progress | reverted | superseded`) and a ≤ 12-word summary. If an entry supersedes another, mark the old row `superseded`.
4. If architecture, commands, or conventions changed, update the **Project Snapshot** in INDEX.md.
5. Reference real file paths and commit hashes (if committed) so entries are traceable. No secrets.

## Quality bar
A new AI reading only INDEX.md must know: what the project is, how to run it, what was done in order, and which entry to open for any detail. An entry must let someone verify the work without the chat history.
