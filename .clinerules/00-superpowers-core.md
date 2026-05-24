# Superpowers Core for Cline

This workspace contains a Cline adaptation of the Superpowers workflow. Treat the adapted `.clinerules/` files as active Cline instructions and treat `docs/superpowers/skills/` as reference documentation copied from upstream Superpowers.

Priority order:

1. Explicit user instructions in the current Cline task.
2. Existing project instructions and workspace rules.
3. These adapted Superpowers Cline rules.
4. Upstream Superpowers docs under `docs/superpowers/skills/`.

When an upstream Superpowers doc says to use a tool that Cline does not have, translate the intent instead of naming the unavailable tool.

Use these mappings:

- `invoke Skill tool` means read the relevant local file under `docs/superpowers/skills/.../SKILL.md`.
- `TodoWrite` means maintain a visible Markdown checklist or use Cline's task UI if available.
- `subagent` means a separate Cline task that the user chooses to open, usually with `/newtask`.
- `dispatch agents` means propose independent task splits; do not start them automatically.
- `implementation action` means file edits, state-changing commands, dependency installs, commits, pushes, and PR creation.

Keep adapted behavior practical. Do not force heavyweight process for trivial read-only answers.
