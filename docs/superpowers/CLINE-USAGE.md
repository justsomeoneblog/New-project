# Using Superpowers with Cline

This repository adapts Superpowers for the Cline VS Code extension.

## What Is Active

The active Cline rules are in `.clinerules/`. They are translated for Cline and may be loaded by Cline as workspace rules.

The upstream Superpowers docs are mirrored under `docs/superpowers/skills/`. Treat those files as reference docs, not as direct Cline rules.

## How To Use

Open this repository or copy `.clinerules/` and `docs/superpowers/` into another project root.

In Cline, keep the workspace rules enabled. Ask Cline to use Superpowers behavior normally, for example:

```text
Use the Superpowers planning rule and make a plan before implementing this.
```

For documentation research, ask Cline to read specific local docs:

```text
Read docs/superpowers/skills/systematic-debugging/SKILL.md and summarize how it applies here.
```

## Multi-Agent Documentation Reading

Cline may suggest independent documentation-reading tasks, but it should not open `/newtask` automatically. You decide whether to open extra tasks.

Recommended pattern:

1. Ask the main Cline task to propose documentation-reading splits.
2. Open separate Cline tasks manually if useful.
3. Keep those tasks read-only unless you explicitly authorize edits.
4. Paste summaries back into the main task when needed.

## Updating The Vendor Copy

To refresh upstream docs:

```powershell
$temp = Join-Path $env:TEMP "superpowers-upstream"
if (Test-Path -LiteralPath $temp) {
  Remove-Item -LiteralPath $temp -Recurse -Force
}
git clone --depth 1 https://github.com/obra/superpowers.git $temp
Remove-Item -LiteralPath "docs/superpowers/skills" -Recurse -Force
Copy-Item -LiteralPath "$temp/skills" -Destination "docs/superpowers/skills" -Recurse
Remove-Item -LiteralPath $temp -Recurse -Force
```

Review `.clinerules/` after refreshing upstream docs because Cline rules are translated adaptations, not generated verbatim.
