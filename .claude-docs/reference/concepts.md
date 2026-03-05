# Core Concepts

## Why 200 Lines?

Claude reads entire files on each reference. Large files mean:
- Slower lookups as Claude processes irrelevant content
- Higher token usage per file read
- Risk of important details being lost in noise

200 lines is the threshold where a single file remains scannable in one pass without wasting context. Files exceeding this should be split by semantic topic.

## Why Semantic Naming?

Files named by topic (`error-handling.md`) are discoverable by future sessions. Files named by date (`2026-02-17-notes.md`) require reading the index to know what's inside. Semantic names let Claude match learnings to the right file without reading every file first.

**Good:** `caching-patterns.md`, `api-conventions.md`, `docker-troubleshoot.md`
**Bad:** `session-notes.md`, `2026-02-17.md`, `misc.md`, `todo.md`

## Why CLAUDE.md as Coordination Point?

CLAUDE.md is automatically loaded into context at conversation start. By placing the Documentation Index here, every session immediately knows:
- What documentation exists
- Where each topic lives
- Which directories to search

Without the index, Claude would need to scan the filesystem to discover docs — slow and unreliable. The index is the routing table that makes capture fast and review comprehensive.

## Why 4 Categories?

The four directories map to the four questions Claude asks when working:

| Directory | Question | Example |
|-----------|----------|---------|
| `reference/` | "What is this?" | Architecture, tech stack, data models |
| `conventions/` | "How should I do this?" | Code style, naming, error handling patterns |
| `tasks/` | "How do I perform this operation?" | Deploying, releasing, running migrations |
| `troubleshoot/` | "What went wrong and how do I fix it?" | Known bugs, environment issues, gotchas |

Every piece of project knowledge fits one of these categories. If it doesn't, it's either too broad (split it) or too specific (put it in the closest match).

## Why Bootstrap Before Capture?

Capture routes learnings to existing files using the CLAUDE.md index. Without the index, capture has nowhere to route — it would have to guess file locations or create files without structure. Bootstrap establishes the skeleton that capture fills in over time.

## Why Report Before Fix (Review)?

Review's hard gate requires presenting findings before changing anything. This prevents well-intentioned but destructive "cleanup" — like deleting an orphaned file that actually contains critical knowledge, or splitting a file in a way that breaks the author's intended grouping.
