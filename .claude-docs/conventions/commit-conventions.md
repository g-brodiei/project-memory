# Commit Conventions

## Format

All commits follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <description>

[optional body]

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

## Types

| Type | Purpose | Changelog Group |
|------|---------|-----------------|
| `feat` | New feature or capability | Added |
| `fix` | Bug fix | Fixed |
| `docs` | Documentation only | Documentation |
| `chore` | Maintenance, version bumps | Miscellaneous |
| `refactor` | Code restructuring, no behavior change | Changed |
| `perf` | Performance improvement | Performance |
| `test` | Test additions or fixes | Testing |
| `ci` | CI/CD changes | CI |

## Rules

- Type prefix is **required** on every commit
- Description starts lowercase after the colon
- Body is optional but recommended for non-trivial changes
- Co-Authored-By line included when AI-assisted
- Breaking changes: add `!` after type (e.g., `feat!: remove legacy API`)

## Examples

```
feat: add SessionStart hook to check bootstrap status
fix: remove duplicate version from marketplace plugin entry
docs: bootstrap project documentation with .claude-docs/ structure
chore: bump version to 1.1.0
```
