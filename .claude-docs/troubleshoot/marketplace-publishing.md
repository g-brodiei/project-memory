# Marketplace Publishing Troubleshooting

## Duplicate Version Field

**Problem**: Plugin entry in `marketplace.json` includes a `version` field that duplicates the one in `plugin.json`.

**Symptom**: Marketplace listing may show conflicting version info or fail validation.

**Fix**: Only define `version` in `plugin.json`. The `marketplace.json` plugins array entries should NOT include a version field.

**BAD**:
```json
{
  "plugins": [{
    "name": "project-memory",
    "version": "1.0.0",
    "source": "./"
  }]
}
```

**GOOD**:
```json
{
  "plugins": [{
    "name": "project-memory",
    "source": "./",
    "description": "..."
  }]
}
```

## marketplace.json Structure

Required fields in the root object:
- `name` - plugin collection name
- `owner.name` - GitHub username
- `metadata.description` - short description
- `plugins[]` - array of plugin entries (name, source, description, author)
