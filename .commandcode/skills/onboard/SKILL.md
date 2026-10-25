---
name: onboard
description: Scan an unfamiliar or newly handed-over project and produce a compact project snapshot plus devlog index. Use when starting work on a repo for the first time, when switching to a different AI/tool, when docs/devlog/INDEX.md snapshot is empty or stale, or when the user says "projeyi tara", "onboard", "devral".
---
# Onboard

Goal: in minimal tokens, understand the project and (re)fill the **Project Snapshot** in `docs/devlog/INDEX.md`.

## Steps
1. Read `docs/devlog/INDEX.md`. If entries exist, read the last 3 and any marked `in-progress`. Stop here if the snapshot is fresh (matches repo reality in step 3).
2. Detect stack cheaply: list root files; read manifests only (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `pom.xml`, `composer.json`, `Dockerfile`, CI config, `Makefile`).
3. Map structure: top-2 levels of the tree (skip `node_modules`, `.git`, `dist`, `build`, `vendor`, `.venv`). Identify entry points, main modules, config, tests.
4. Extract commands: install, run, test, lint, build (from manifests/README/CI). Verify they exist; don't guess.
5. Note conventions: naming, folder layout, error handling, logging, state/data access patterns, test framework — from 2-3 representative files.
6. Note risks/hotspots: largest files, TODO/FIXME clusters, missing tests, obvious perf smells. Do not fix now.
7. Write the snapshot into INDEX.md between the SNAPSHOT markers (keep it under ~40 lines).
8. If the project already has history but no devlog, add a first entry `chore: onboarding snapshot` via `scripts/devlog-new.sh`. For a mature repo, optionally backfill major milestones from `git log` as `done` entries (clearly marked "backfilled").

## Output to user
5-10 lines: stack, structure, how to run/test, conventions, top 3 risks, suggested next steps.
