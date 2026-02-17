# Releasing

## Prerequisites

- `git-cliff` installed (`pip install git-cliff`)
- `cliff.toml` in repo root (configured for conventional commits)
- All commits follow conventional commit format

## Steps

### 1. Bump Version

Edit `.claude-plugin/plugin.json` and update the `version` field.

```bash
# Example: 1.1.0 -> 1.2.0
```

Commit: `chore: bump version to X.Y.Z`

### 2. Tag the Release

```bash
git tag vX.Y.Z
```

### 3. Regenerate Changelog

```bash
git-cliff -o CHANGELOG.md
```

Commit: `docs: update CHANGELOG for vX.Y.Z`

### 4. Push

```bash
git push origin main --tags
```

### 5. Create GitHub Release

```bash
gh release create vX.Y.Z --title "vX.Y.Z" --notes "$(git-cliff --latest)"
```

**Important:** Create releases in chronological order. Creating an older release after a newer one may mark the older one as "Latest" on GitHub.

## git-cliff Usage

| Command | Purpose |
|---------|---------|
| `git-cliff -o CHANGELOG.md` | Regenerate full changelog |
| `git-cliff --latest` | Show only the latest release notes |
| `git-cliff --unreleased` | Show unreleased changes |

**Gotcha:** Do not use `--workdir` flag — it adds an absolute path filter that prevents commit matching. Run from the repo root instead.
