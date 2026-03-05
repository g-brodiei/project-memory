# Skill Execution Troubleshooting

## Bootstrap Finds No Files

**Symptom:** Bootstrap scan reports no tech stack detected.

**Causes:**
- Project has no standard manifest files (package.json, pyproject.toml, etc.)
- Project is documentation-only or uses an unusual build system
- Working directory is wrong (e.g., running from home directory)

**Fix:** Verify `pwd` is the project root. If the project genuinely has no manifest files, bootstrap will still create the `.claude-docs/` structure — populate `reference/tech-stack.md` manually with whatever tools the project uses.

## Capture Fails on Missing CLAUDE.md

**Symptom:** Capture hard gate rejects with "no index found."

**Causes:**
- CLAUDE.md doesn't exist yet
- CLAUDE.md exists but has no `## Documentation Index` heading
- CLAUDE.md has the heading but no markdown links under it

**Fix:** Run `project-memory:bootstrap` to create the full structure, or manually add a `## Documentation Index` section with at least one `[file](path)` link to CLAUDE.md.

## Review Reports False Stale Positives

**Symptom:** Review flags files as stale that are actually current.

**Causes:**
- Doc was written correctly but the file was never committed (git blame shows no history)
- Doc references source files that were renamed but the content is still accurate
- Doc covers stable architecture that rarely changes — age alone doesn't mean staleness

**Fix:** Review uses two signals: doc age AND source code activity on referenced files. If the doc's subject hasn't changed in the codebase, it's not truly stale. Dismiss the warning or touch the file to reset the clock if you've verified accuracy.

## Bootstrap Runs But Creates Empty Files

**Symptom:** `.claude-docs/` directories exist but files have minimal or placeholder content.

**Causes:**
- Bootstrap was interrupted before completing the scan
- Project scan found files but couldn't determine their purpose

**Fix:** Re-run `project-memory:bootstrap`. It will not overwrite existing files — only fill in missing ones. If files remain sparse, the project may need manual documentation of its architecture.
