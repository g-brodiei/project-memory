# project-memory

Claude Code plugin that gives Claude persistent project knowledge through structured documentation. It bootstraps a `.claude-docs/` system, captures session learnings into the right files, and audits documentation health over time.

## Documentation Index

### .claude-docs/reference/
- [architecture.md](.claude-docs/reference/architecture.md) - Plugin architecture, skill system, design decisions
- [tech-stack.md](.claude-docs/reference/tech-stack.md) - Plugin system, manifest formats, system requirements
- [concepts.md](.claude-docs/reference/concepts.md) - Why 200-line limit, semantic naming, CLAUDE.md coordination, 4-category structure

### .claude-docs/conventions/
- [skill-design.md](.claude-docs/conventions/skill-design.md) - SKILL.md format, sections, naming conventions
- [hook-design.md](.claude-docs/conventions/hook-design.md) - Hook script pattern, JSON I/O, hooks.json format
- [commit-conventions.md](.claude-docs/conventions/commit-conventions.md) - Conventional commits format, types, rules

### .claude-docs/tasks/
- [releasing.md](.claude-docs/tasks/releasing.md) - Version bump, git-cliff changelog, GitHub release workflow
- [team-collaboration.md](.claude-docs/tasks/team-collaboration.md) - Doc ownership, merge conflicts, coordinating capture
- [migration.md](.claude-docs/tasks/migration.md) - Migrating from README-only or wiki-style docs

### .claude-docs/troubleshoot/
- [marketplace-publishing.md](.claude-docs/troubleshoot/marketplace-publishing.md) - Duplicate version field, marketplace.json structure
- [git-cliff.md](.claude-docs/troubleshoot/git-cliff.md) - Empty changelog, missing versions, --workdir bug
- [skill-execution.md](.claude-docs/troubleshoot/skill-execution.md) - Bootstrap no-files, capture missing CLAUDE.md, review false positives
