# Hook Design Conventions

## File Structure

Hooks live in `hooks/` at the plugin root. Claude Code auto-discovers `hooks/hooks.json` — no `plugin.json` modification needed.

```
hooks/
  hooks.json          # Hook event definitions
  session-start.sh    # Script referenced by hooks.json
```

## hooks.json Format

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ${CLAUDE_PLUGIN_ROOT}/hooks/session-start.sh"
          }
        ]
      }
    ]
  }
}
```

- Use `${CLAUDE_PLUGIN_ROOT}` for paths — resolved by Claude Code at runtime
- Omit `matcher` to run on every event of that type

## Hook Script Pattern

### stdin JSON

Hook scripts receive JSON on stdin with context about the event. For `SessionStart`:
```json
{"cwd": "/path/to/user/project"}
```

Parse with python3, fall back to `pwd`:
```bash
CWD=""
if read -r input 2>/dev/null; then
    CWD=$(python3 -c "import sys,json; print(json.loads(sys.argv[1]).get('cwd',''))" "$input" 2>/dev/null || true)
fi
if [ -z "$CWD" ]; then
    CWD="$(pwd)"
fi
```

### JSON Output

To inject context into the session, output `additionalContext` JSON:
```bash
escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "$(escape_for_json "$message")"
  }
}
EOF
```

### Silent Exit

If no action needed, produce no output and `exit 0`. Only output JSON when there's something to communicate.

### Rules

- Always `exit 0` — non-zero exits may block the session
- Use `set -euo pipefail` at the top
- Keep scripts informational — never create files in the user's project
