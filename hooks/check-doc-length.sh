#!/usr/bin/env bash
# Check all .claude-docs/ and CLAUDE.md files for >200 line violations.
# Run manually or add as a git pre-commit hook.
# Exit code: 0 = all pass, 1 = violations found

set -euo pipefail

LIMIT=200
violations=0

# Find the repo root (run from anywhere in the repo)
repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

# Check all .claude-docs/ markdown files
while IFS= read -r -d '' file; do
    lines=$(wc -l < "$file")
    if [ "$lines" -gt "$LIMIT" ]; then
        rel_path="${file#"$repo_root"/}"
        echo "OVER LIMIT: $rel_path ($lines lines, limit: $LIMIT)"
        violations=$((violations + 1))
    fi
done < <(find "$repo_root"/.claude-docs -name '*.md' -print0 2>/dev/null)

# Check CLAUDE.md files
while IFS= read -r -d '' file; do
    lines=$(wc -l < "$file")
    if [ "$lines" -gt "$LIMIT" ]; then
        rel_path="${file#"$repo_root"/}"
        echo "OVER LIMIT: $rel_path ($lines lines, limit: $LIMIT)"
        violations=$((violations + 1))
    fi
done < <(find "$repo_root" -maxdepth 2 -name 'CLAUDE.md' -print0 2>/dev/null)

if [ "$violations" -gt 0 ]; then
    echo ""
    echo "$violations file(s) exceed $LIMIT lines. Split oversized files into focused sub-files."
    exit 1
else
    echo "All documentation files are within the $LIMIT-line limit."
    exit 0
fi
