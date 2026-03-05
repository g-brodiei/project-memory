# project-memory

[![Version](https://img.shields.io/badge/version-1.3.0-blue.svg)](https://github.com/g-brodiei/project-memory)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-purple.svg)](https://github.com/g-brodiei/project-memory)

Structured documentation bootstrapping, session-end learning capture, and documentation health auditing for any Claude Code project.

## Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| `project-memory:bootstrap` | Discover project and scaffold `.claude-docs/` | Starting a new project or missing `.claude-docs/` |
| `project-memory:capture` | Capture session learnings into structured docs | End of any work session with new learnings |
| `project-memory:review` | Audit documentation health | Periodically, or when docs feel stale/bloated |

Skills are independent and can be run in any order. Bootstrap is recommended first to establish the `.claude-docs/` structure, but capture and review will prompt you to bootstrap if needed.

## What Bootstrap Creates

```
your-project/
  .claude-docs/
    conventions/    # code-style.md, git-workflow.md, ...
    reference/      # architecture.md, tech-stack.md, ...
    tasks/          # deploying.md, development-setup.md, ...
    troubleshoot/   # known-issues.md, environment-setup.md, ...
  CLAUDE.md         # Documentation Index linking to all the above
```

File names and content are generated from your actual project scan — the above are examples.

## SessionStart Hook

When installed, the plugin automatically checks if the current project has been bootstrapped. If `.claude-docs/` or `CLAUDE.md` is missing, it shows a reminder to run `project-memory:bootstrap`. No files are created — purely informational.

## How It Works

The three skills share **CLAUDE.md as their coordination point**:

```
bootstrap -----> Creates .claude-docs/ + CLAUDE.md index (run once or on major changes)
capture -> Reads CLAUDE.md index -> writes to .claude-docs/ (session-end)
review ---------> Reads CLAUDE.md index -> audits .claude-docs/ -> reports/fixes (on-demand)
```

Skills are independent and non-sequential. None invokes another.

## Installation

### From Marketplace (recommended)

```bash
/plugin marketplace add g-brodiei/project-memory
/plugin install project-memory@project-memory
```

### From Source

```bash
git clone https://github.com/g-brodiei/project-memory.git
/plugin install /path/to/project-memory
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
```

## Conventions

| Rule | Detail |
|------|--------|
| Max 200 lines | Any doc exceeding 200 lines must be split into focused sub-files |
| Semantic naming | Files named by topic: `error-handling.md` not `2026-02-17-errors.md` |
| Split naming | `error-handling.md` -> `error-handling-http.md`, `error-handling-db.md` |
| 4 directories | conventions/, reference/, tasks/, troubleshoot/ |
| CLAUDE.md as index | All doc files referenced from nearest CLAUDE.md Documentation Index |
