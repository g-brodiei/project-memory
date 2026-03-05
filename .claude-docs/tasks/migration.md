# Migrating Existing Documentation

## From README-Only Projects

Many projects keep all documentation in a single README.md. To migrate:

1. Run `project-memory:bootstrap` — it will scan the project and create `.claude-docs/` without touching your README
2. Identify sections in your README that fit the 4-category structure:
   - "Architecture" or "How it works" -> `reference/architecture.md`
   - "Development setup" or "Contributing" -> `tasks/development.md`
   - "Troubleshooting" or "FAQ" -> `troubleshoot/` files
   - "Code style" or "Conventions" -> `conventions/` files
3. Copy (don't move) relevant content from README to `.claude-docs/` files
4. Keep your README as the public-facing document — it serves a different audience than `.claude-docs/`

**Don't delete README content.** README is for humans browsing GitHub. `.claude-docs/` is for Claude sessions.

## From Wiki-Style Documentation

Projects with `docs/` or `wiki/` directories:

1. Run `project-memory:bootstrap` to create the `.claude-docs/` skeleton
2. Map existing wiki pages to the 4 categories:
   - API references, data models -> `reference/`
   - Style guides, PR templates -> `conventions/`
   - Deployment guides, runbooks -> `tasks/`
   - Known issues, debugging guides -> `troubleshoot/`
3. For each wiki page, create a focused `.claude-docs/` file with the key information Claude needs
4. Keep the original wiki — `.claude-docs/` is a Claude-optimized subset, not a replacement

## Mapping Content to Categories

| Existing Content | Target Category | Example File |
|-----------------|-----------------|--------------|
| Architecture diagrams | `reference/` | `architecture.md` |
| API documentation | `reference/` | `api-endpoints.md` |
| Setup instructions | `tasks/` | `development-setup.md` |
| Deployment runbooks | `tasks/` | `deploying.md` |
| Code style guides | `conventions/` | `code-style.md` |
| PR review checklist | `conventions/` | `review-process.md` |
| Bug workarounds | `troubleshoot/` | `known-issues.md` |
| Environment issues | `troubleshoot/` | `environment-setup.md` |

## After Migration

1. Add all new files to CLAUDE.md Documentation Index
2. Run `project-memory:review` to verify all files are indexed and under 200 lines
3. Use `project-memory:capture` going forward to keep docs current
