---
name: test-writer
description: Write or repair tests that match the repository's existing test framework, layout, and style. Use when adding coverage, writing regression tests, characterization tests before refactoring, or fixing failing/flaky tests.
---
# Test Writer

1. Find existing tests nearest to the target; copy framework, location, naming, fixtures, mocking style. Use the repo's test command.
2. Test behavior, not implementation. Cover happy path, boundaries, error paths, and the specific bug (for regressions).
3. Keep tests deterministic: control network/time/randomness; isolate state.
4. One reason to fail per test; descriptive names; arrange-act-assert.
5. Run new tests, then the suite. For regressions, confirm the test fails without the fix.
6. Don't change production code just to pass tests unless it's a real bug (then use `debug`).
