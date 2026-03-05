---
name: capture
description: "Use at session end to capture learnings, patterns, and pitfalls into structured documentation"
---

# Capture Session Learnings

## Overview

Capture session learnings and route them to the right documentation files. Reads the CLAUDE.md index to discover where docs live, then writes learnings to semantically matching files.

<HARD-GATE>
You MUST read the CLAUDE.md Documentation Index before writing to any file. No blind writes. If CLAUDE.md has no index or lacks a `## Documentation Index` heading with at least one markdown link, run project-memory:bootstrap first or ask the user to fix CLAUDE.md manually.
</HARD-GATE>

## Checklist

You MUST create a task for each item and complete them in order:

1. **Summarize session learnings** — root cause, solution, patterns, pitfalls discovered
2. **Read CLAUDE.md Documentation Index** — discover where all docs live
3. **Categorize each learning** — convention, pitfall, architecture, workflow, troubleshooting
4. **Route each learning to best target file** — match semantically to existing docs
5. **Propagate to broader documentation** — search all docs for stale references to changed concepts
6. **Create new files if no match** — focused file + add to CLAUDE.md index
7. **Split oversized files** — any file exceeding 200 lines gets split
8. **Verify constraints** — all files <200 lines, new files indexed

## Process Flow

```dot
digraph capture {
    "Analyze session work" [shape=box];
    "Read CLAUDE.md index" [shape=box];
    "Categorize learnings" [shape=box];
    "Match to existing file?" [shape=diamond];
    "Append to existing file" [shape=box];
    "Propagate to broader docs" [shape=box];
    "Create new focused file" [shape=box];
    "Add to CLAUDE.md index" [shape=box];
    "File > 200 lines?" [shape=diamond];
    "Split into sub-files" [shape=box];
    "Verify constraints" [shape=box];
    "Done" [shape=doublecircle];

    "Analyze session work" -> "Read CLAUDE.md index";
    "Read CLAUDE.md index" -> "Categorize learnings";
    "Categorize learnings" -> "Match to existing file?";
    "Match to existing file?" -> "Append to existing file" [label="yes"];
    "Match to existing file?" -> "Create new focused file" [label="no"];
    "Create new focused file" -> "Add to CLAUDE.md index";
    "Append to existing file" -> "Propagate to broader docs";
    "Add to CLAUDE.md index" -> "Propagate to broader docs";
    "Propagate to broader docs" -> "File > 200 lines?";
    "File > 200 lines?" -> "Split into sub-files" [label="yes"];
    "File > 200 lines?" -> "Verify constraints" [label="no"];
    "Split into sub-files" -> "Verify constraints";
    "Verify constraints" -> "Done";
}
```

## Step 1: Analyze Session Work

Review the conversation to extract:

- **Root Cause**: What was the underlying problem?
- **Solution Applied**: What fix was implemented?
- **Pattern/Anti-Pattern**: What generalizable pattern emerged?
- **Prevention**: How can this be avoided in the future?
- **Code Examples**: Any BAD/GOOD patterns worth documenting?

## Step 2: Read CLAUDE.md Documentation Index

Find and read ALL CLAUDE.md files in the project:
- Root `CLAUDE.md`
- Subdirectory `CLAUDE.md` files (e.g., `backend/CLAUDE.md`, `frontend/CLAUDE.md`)

Extract the Documentation Index sections to build a map of:
- Which `.claude-docs/` directories exist
- What files are in each directory
- What topics each file covers

This map is your routing table. Every learning must go through this map.

## Step 3: Categorize Each Learning

Assign each learning to a category:

| Category | Target Directory | Examples |
|----------|-----------------|----------|
| Convention | `conventions/` | Code style, naming, error handling patterns |
| Architecture | `reference/` | System design, data flow, component relationships |
| Workflow | tasks/ or conventions/ | Development process, deployment, testing |
| Troubleshooting | `troubleshoot/` | Bug fixes, environment issues, known gotchas |
| Pitfall | `troubleshoot/` | One-line warnings for common mistakes |

## Step 4: Route to Best Target File

For each learning, find the semantically closest file from the CLAUDE.md index:

1. **Read the target file** to confirm the learning fits
2. **Find the right section** within the file
3. **Append** the learning matching the file's existing style
4. Include BAD/GOOD code examples where the file already uses them
5. Update "Last Updated" dates if present

**Routing priority:**
1. Exact topic match (e.g., error handling lesson -> `error-handling.md`)
2. Broader topic match (e.g., HTTP error -> `error-handling.md` or `api-conventions.md`)
3. Category match (e.g., new convention -> any file in `conventions/`)
4. No match -> create new file (Step 6)

## Step 5: Propagate to Broader Documentation

When a session introduces new concepts (enum values, renamed fields, new options, changed thresholds), other docs beyond `.claude-docs/` may contain stale references.

**When to propagate:**
- Enum/option values added, removed, or renamed
- Field or variable names changed
- Default values or thresholds updated
- API endpoints renamed or restructured

**When NOT to propagate:**
- Changelog entries (historical record — leave as-is)
- Archived plans or completed sprint docs
- Git commit messages or release notes
- Comments that quote old behavior for context (e.g., "previously X, now Y")

**Steps:**
1. **Identify what changed** — new values added, terms renamed, options expanded, thresholds updated
2. **Search ALL `.md` files** for stale references to the old state:
   - `docs/prd/` — product requirements
   - `.claude/agents/` — agent configurations
   - `.claude/skills/` — skill definitions
   - `.claude/commands/` — command docs
   - `backend/.claude-docs/` and `frontend/.claude-docs/` — stack-specific docs
   - Any other directories containing living documentation
3. **Update stale references** to reflect the new state (e.g., add new enum value to frequency lists, update renamed fields)
4. **Skip historical files** — don't update `docs/plans/reports/`, changelogs, archive directories, or completed plan files. Only update *living* docs that guide future work

**Example:** Adding `"2W"` (bi-weekly) rebalancing requires updating frequency lists in PRDs, agent configs that reference available frequencies, and skill files that enumerate rebalancing options.

**Example of what NOT to propagate:** CHANGELOG says "removed legacy polling mode". Do NOT update it to mention the new mode — changelogs record what happened at that point in time.

## Step 6: Create New Files If No Match

When a learning doesn't fit any existing file:

1. Create a new `.md` file in the appropriate `.claude-docs/` subdirectory
2. Use semantic naming: `{topic}.md` (e.g., `caching-patterns.md`)
3. Add the file to the nearest CLAUDE.md Documentation Index
4. Keep under 200 lines

**Naming for stack-specific docs:** Place in the relevant package's `.claude-docs/`:
- Backend learning -> `backend/.claude-docs/conventions/...`
- Frontend learning -> `frontend/.claude-docs/conventions/...`
- Cross-stack -> root `.claude-docs/conventions/...`

## Step 7: Split Oversized Files

If any file exceeds 200 lines after your additions:

1. Identify semantic sections within the file
2. Split into focused sub-files: `{topic}-{subtopic}.md`
3. Example: `error-handling.md` (300 lines) becomes:
   - `error-handling-http.md`
   - `error-handling-db.md`
   - `error-handling-async.md`
4. Update the CLAUDE.md index to reference the new files
5. Delete the original oversized file

## Step 8: Verify Constraints

Before finishing, verify:

- [ ] All updated/created `.claude-docs/` files are under 200 lines
- [ ] All new files are indexed in the relevant CLAUDE.md
- [ ] Broader docs searched for stale references to changed concepts
- [ ] Code examples included where applicable
- [ ] No blind writes (every file was read before editing)

## Output Format

After completing all steps, report:

```
Session Capture: [topic]

## Lessons Learned
- **Problem**: [description]
- **Root Cause**: [explanation]
- **Solution**: [fix applied]
- **Patterns**: [generalizable rules]

## Documentation Updated
- `[path/to/file]`: [what was updated]

## Files Created (if any)
- `[path/to/new-file]` - [description]

## Verification
- [x] All files under 200 lines
- [x] New files indexed in CLAUDE.md
- [x] Code examples included where applicable
```

## Red Flags

These thoughts mean STOP — you're bypassing the routing:

| Thought | Reality |
|---------|---------|
| "I know where this goes" | Read CLAUDE.md index first. Projects evolve. |
| "I'll just dump it in one file" | Route to the best semantic match. Details go in .claude-docs/. |
| "This file is close enough" | Read the file first. Wrong routing = lost knowledge. |
| "I'll organize it later" | Unrouted knowledge is lost knowledge. Route now. |
| "No docs exist yet" | Run project-memory:bootstrap first. |
| "This isn't worth documenting" | If you learned it the hard way, document it. |
