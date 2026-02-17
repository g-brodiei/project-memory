# git-cliff Troubleshooting

## Commits Skipped / Empty Changelog

**Symptom:** `git-cliff` outputs empty changelog or warns about skipped commits.

**Cause 1:** `conventional_commits = true` but commit messages don't use `feat:`, `fix:`, etc. prefixes.

**Fix:** Either rewrite commits to conventional format or set `conventional_commits = false` with custom `commit_parsers`.

**Cause 2:** Using `--workdir` flag, which adds an `include_paths` filter with absolute paths that don't match any commit file paths.

**Fix:** Run from the repo root without `--workdir`:
```bash
# BAD
git-cliff --workdir /absolute/path/to/repo

# GOOD
cd /path/to/repo && git-cliff
```

## No Version Sections (All Commits in One Block)

**Symptom:** Changelog has no `## [X.Y.Z]` headings, all commits appear under one section.

**Cause:** No git tags exist. git-cliff uses tags matching `tag_pattern` to separate releases.

**Fix:** Create tags at release commits:
```bash
git tag v1.0.0 <commit-sha>
git tag v1.1.0 <commit-sha>
```

## Config Not Found

**Symptom:** `"cliff.toml" is not found, using the default configuration`

**Fix:** Ensure `cliff.toml` exists in the directory you're running from, or specify with `--config path/to/cliff.toml`.
