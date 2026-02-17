# Skill Design Conventions

## File Format

Every skill is a single `SKILL.md` file at `skills/{name}/SKILL.md`.

### YAML Frontmatter (required)

```yaml
---
name: skill-name
description: "When to use this skill - triggers and context"
---
```

### Standard Sections (in order)

1. **Overview** - What the skill does (2-3 sentences)
2. **Hard Gate** - Non-negotiable prerequisites wrapped in `<HARD-GATE>` tags
3. **Checklist** - Numbered steps that MUST become tasks (TaskCreate)
4. **Process Flow** - Graphviz dot diagram showing the decision flow
5. **Step N details** - One section per checklist item with guidance
6. **Red Flags** - Table of rationalizations that mean STOP

### Hard Gates

Use sparingly. Only for steps that, if skipped, would make the skill produce wrong output.

```markdown
<HARD-GATE>
You MUST [prerequisite] before [action]. [Consequence of skipping].
</HARD-GATE>
```

### Red Flags Table

```markdown
| Thought | Reality |
|---------|---------|
| "I already know..." | [Why you should check anyway] |
```

## Naming

- Skill names: lowercase, hyphenated (`project-memory`, `code-review`)
- Directory matches skill name: `skills/bootstrap/SKILL.md`
