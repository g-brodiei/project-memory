# Team Collaboration

## Who Updates Docs?

Anyone who learns something new should capture it. The capture skill is designed for individual session-end use — each team member runs it independently after their work session.

**Guidelines:**
- Capture after any session where you discovered a pitfall, pattern, or architectural insight
- Don't wait for "documentation sprints" — capture in the moment while context is fresh
- Review skill can be run by any team member to audit overall health

## Merge Conflicts in .claude-docs/

Documentation files are append-heavy, which means merge conflicts are common when multiple people capture learnings to the same file.

**Prevention:**
- Keep files focused on narrow topics (reduces chance of two people editing the same file)
- Split files proactively when they grow — smaller files mean fewer conflicts
- Use the 200-line limit as a forcing function for splits

**Resolution:**
- Accept both additions when conflicts are in different sections
- If both added to the same section, combine the content and remove duplicates
- For CLAUDE.md index conflicts, include all new entries from both branches
- After resolving, run `project-memory:review` to verify nothing was lost

## Coordinating Capture Across Team Members

When multiple team members work on related features:

1. **Don't duplicate** — before capturing, read the target file to check if someone already documented the same learning
2. **Reference, don't repeat** — if a related doc exists, add a cross-reference rather than restating the same information
3. **Prefer specificity** — two focused files (`auth-oauth.md`, `auth-session.md`) are better than one bloated `auth.md`

## Running Review as a Team

Schedule periodic review runs (e.g., start of sprint) to catch:
- Orphaned files from deleted features
- Stale docs from refactored code
- Oversized files that need splitting

One person runs review and shares the findings report with the team. The team decides which fixes to apply.
