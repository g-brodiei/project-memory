# Tech Stack

## Core

- **Platform**: Claude Code Plugin System
- **Language**: Markdown (SKILL.md files with YAML frontmatter)
- **No runtime dependencies** - pure documentation/skill definitions

## Plugin System

- **Plugin manifest**: `.claude-plugin/plugin.json` - name, description, version, author, repository
- **Marketplace manifest**: `.claude-plugin/marketplace.json` - owner, plugins array for marketplace listing
- **Skill format**: `skills/{name}/SKILL.md` with YAML frontmatter (`name`, `description`)
- **Hook format**: `hooks/hooks.json` + shell scripts, auto-discovered by Claude Code

## Installation

```bash
/plugin marketplace add g-brodiei/project-memory
/plugin install project-memory@project-memory
```

## Versioning

- Single version in `plugin.json` (not in marketplace plugin entries)
- Git tags for releases
