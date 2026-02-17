# project-memory

Structured documentation bootstrapping, session-end learning capture, and documentation health auditing for any Claude Code project.

## Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| `project-memory:bootstrap` | Discover project and scaffold `.claude-docs/` | Starting a new project or missing `.claude-docs/` |
| `project-memory:capture` | Capture session learnings into structured docs | End of any work session with new learnings |
| `project-memory:review` | Audit documentation health | Periodically, or when docs feel stale/bloated |

## How It Works

The three skills share **CLAUDE.md as their coordination point**:

```
bootstrap -----> Creates .claude-docs/ + CLAUDE.md index (run once or on major changes)
capture -> Reads CLAUDE.md index -> writes to .claude-docs/ + MEMORY.md (session-end)
review ---------> Reads CLAUDE.md index -> audits .claude-docs/ -> reports/fixes (on-demand)
```

Skills are independent and non-sequential. None invokes another.

## Installation

```bash
/plugin marketplace add g-brodiei/project-memory
/plugin install project-memory@project-memory
```

## Documentation Structure

The plugin creates and maintains this structure:

```
.claude-docs/
  conventions/    # How-to: coding standards, style guides, workflow rules
  reference/      # What-is: architecture, tech stack, directory layout
  tasks/          # Step-by-step: guides for common operations
  troubleshoot/   # Fix-it: known issues and solutions
CLAUDE.md         # Index pointing to all .claude-docs/ files
MEMORY.md         # Persistent session memory (<200 lines, loaded every prompt)
```

## Conventions

| Rule | Detail |
|------|--------|
| Max 200 lines | Any doc exceeding 200 lines must be split into focused sub-files |
| Semantic naming | Files named by topic: `error-handling.md` not `2026-02-17-errors.md` |
| Split naming | `error-handling.md` -> `error-handling-http.md`, `error-handling-db.md` |
| 4 directories | conventions/, reference/, tasks/, troubleshoot/ |
| CLAUDE.md as index | All doc files referenced from nearest CLAUDE.md Documentation Index |
| MEMORY.md <200 lines | Compress older entries. Loaded into every system prompt |
