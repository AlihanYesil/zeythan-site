---
name: optimize
description: Optimization workflow for runtime speed, memory, bundle size, database/query cost, network calls, build time, and token/context usage. Use when asked to optimize, speed up, reduce size/cost/latency, fix slowness, or when reviewing code for performance. Measure first, change second, verify third.
---
# Optimize (measure → target → change → verify)

## Steps
1. **Define the metric** and target (p95 latency, LCP, bundle KB, RSS MB, queries/request, build seconds). If none given, pick the user-visible one.
2. **Baseline**: measure with the repo's own tooling or a minimal profiler/benchmark (`time`, `hyperfine`, language profiler, EXPLAIN, Lighthouse, bundle analyzer). Record numbers. No baseline → no optimization.
3. **Find the bottleneck** by profiling/tracing, not guessing; rank by share of total cost. Work top-down on the biggest one only.
4. **Choose the cheapest effective fix**, in this order:
   1. Do less work (remove, skip, early-exit, batch, dedupe, lazy-load)
   2. Better algorithm/data structure (O(n²)→O(n), index, hash lookup)
   3. Cache/memoize (explicit invalidation + size bound)
   4. I/O: N+1 → join/batch, parallelize independent calls, pagination/streaming, compression
   5. Concurrency/low-level tuning — only if 1-4 are exhausted
5. **Preserve behavior**: run tests before/after; add a test if the path is untested.
6. **Re-measure** with the same method. Keep the change only if the gain is meaningful and justifies the complexity. Revert otherwise.
7. **Log** via `dev-log` with a `perf` entry: baseline → after, method, trade-offs.

## Checklists (scan only what's relevant)
- Backend: N+1 queries, missing indexes, unbounded lists, sync I/O in hot path, repeated parsing/serialization, chatty network calls, no timeouts.
- Frontend: re-render storms, large bundles, unoptimized images, blocking scripts, missing virtualization, layout thrash.
- Data/ML: vectorization, batch size, dtype, redundant copies, I/O format.
- Build/CI: cache deps and outputs, parallelize, skip unchanged work.
- AI context cost: search before reading, read ranges, summarize outputs, reuse the devlog index.

## Never
Optimize without numbers; sacrifice correctness/readability for <5% gain; add caches without invalidation; micro-optimize cold code.
