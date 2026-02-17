#!/usr/bin/env bash
# SessionStart hook for project-memory plugin
# Checks if the current project has been bootstrapped and reminds users if not.

set -euo pipefail

# Read cwd from stdin JSON (hook receives JSON on stdin)
CWD=""
if read -r input 2>/dev/null; then
    CWD=$(python3 -c "import sys,json; print(json.loads(sys.argv[1]).get('cwd',''))" "$input" 2>/dev/null || true)
fi
if [ -z "$CWD" ]; then
    CWD="$(pwd)"
fi

# Check bootstrap status
missing=""

if [ ! -d "$CWD/.claude-docs" ]; then
    missing="no .claude-docs/ directory"
elif [ ! -f "$CWD/CLAUDE.md" ]; then
    missing="no CLAUDE.md file"
elif ! grep -q "Documentation Index" "$CWD/CLAUDE.md" 2>/dev/null; then
    missing="no Documentation Index section in CLAUDE.md"
fi

# If everything is bootstrapped, exit silently
if [ -z "$missing" ]; then
    exit 0
fi

# Escape string for JSON embedding
escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

message="project-memory: This project has not been bootstrapped yet (${missing}). Run \`project-memory:bootstrap\` to create structured documentation."
message_escaped=$(escape_for_json "$message")

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "${message_escaped}"
  }
}
EOF

exit 0
