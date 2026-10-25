---
name: debug
description: Systematic root-cause debugging for errors, stack traces, failing tests, flaky behavior, and regressions. Use when something is broken, throws, or behaves unexpectedly.
---
# Debug (reproduce → isolate → root cause → fix → guard)

1. **Reproduce**: get the exact command/input/error. If you can't, gather logs/env/versions; don't guess-fix.
2. **Read the evidence**: full error + stack trace; find the first frame in project code.
3. **Isolate**: bisect (`git bisect`, disable code paths, minimal repro). Form 1-3 hypotheses ranked by likelihood; test each with a cheap experiment.
4. **Root cause** in one sentence ("X happens because Y"). A patched symptom is not a fix.
5. **Fix** minimally, in the style of surrounding code (`analyze-codebase`).
6. **Guard**: add a regression test that fails before and passes after.
7. **Verify**: run the failing case + related suite.
8. **Log** via `dev-log` (`fix`): symptom, root cause, fix, test added.
