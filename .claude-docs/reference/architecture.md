# Architecture

## Overview

project-memory is a Claude Code plugin providing 4 skills for managing structured project documentation.

## Skill System

```
bootstrap ----------> Creates .claude-docs/ + CLAUDE.md index (run once per project)
capture ------------> Reads CLAUDE.md index -> writes to .claude-docs/ (session-end)
review -------------> Reads CLAUDE.md index -> audits .claude-docs/ -> reports/fixes (on-demand)
propose-directory --> Validates + creates new .claude-docs/ directories (invoked by others or standalone)
```

Skills are independent and non-sequential. bootstrap, capture, and review invoke propose-directory when they detect documentation that doesn't fit existing categories. CLAUDE.md serves as the coordination point between all three.

## Plugin Structure

```
.claude-plugin/
  plugin.json         # Plugin metadata (name, description, version, author)
  marketplace.json    # Marketplace listing (owner, plugins array)
hooks/
  hooks.json          # Hook event definitions (auto-discovered by Claude Code)
  session-start.sh    # Checks bootstrap status on session start
skills/
  bootstrap/SKILL.md  # Scaffolds .claude-docs/ from project scan
  capture/SKILL.md    # Routes session learnings to docs
  review/SKILL.md     # Audits documentation health
  propose-directory/SKILL.md  # Validates + creates new doc directories
```

## Documentation Structure (Created by bootstrap)

```
.claude-docs/
  conventions/    # How-to: coding standards, style guides, workflow rules
  reference/      # What-is: architecture, tech stack, directory layout
  tasks/          # Step-by-step: guides for common operations
  troubleshoot/   # Fix-it: known issues and solutions
CLAUDE.md         # Index pointing to all .claude-docs/ files
```

## Key Design Decisions

- **200-line limit**: All doc files must stay under 200 lines for AI readability
- **Semantic naming**: Files named by topic (`error-handling.md`), never by date
- **CLAUDE.md as index**: All doc files must be referenced from nearest CLAUDE.md
