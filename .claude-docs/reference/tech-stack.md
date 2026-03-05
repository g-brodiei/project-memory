# Tech Stack

## Core

- **Platform**: Claude Code Plugin System
- **Language**: Markdown (SKILL.md files with YAML frontmatter)
- **No runtime dependencies** — pure documentation/skill definitions, no package.json or build step
- **Shell scripts**: Bash 4+ for hook scripts (session-start check, doc length validation)

## System Requirements

- Claude Code with plugin support enabled
- Git (for stale detection via `git log`/`git blame` in review skill)
- Bash 4+ (for hook scripts — uses associative arrays and `${CLAUDE_PLUGIN_ROOT}`)
- python3 (used in session-start hook for JSON parsing, with `pwd` fallback)

## Plugin System

- **Plugin manifest**: `.claude-plugin/plugin.json` — name, description, version, author, repository
- **Marketplace manifest**: `.claude-plugin/marketplace.json` — owner, plugins array for marketplace listing
- **Skill format**: `skills/{name}/SKILL.md` with YAML frontmatter (`name`, `description`)
- **Hook format**: `hooks/hooks.json` + shell scripts, auto-discovered by Claude Code

## Installation

### From Marketplace

```bash
/plugin marketplace add g-brodiei/project-memory
/plugin install project-memory@project-memory
```

### From Source

```bash
git clone https://github.com/g-brodiei/project-memory.git
/plugin install /path/to/project-memory
```

## Versioning

- Single version in `plugin.json` (not in marketplace plugin entries)
- Git tags for releases (e.g., `v1.3.0`)
- `git-cliff` for automated CHANGELOG generation from conventional commits
