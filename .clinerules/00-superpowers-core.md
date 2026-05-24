# Superpowers Core for Cline

This workspace installs Superpowers as Cline project skills under `.cline/skills/`. These are not reference docs; they are Cline skills that should be activated with Cline's `use_skill` tool when relevant.

If Cline reports that skills are unavailable, tell the user to enable Cline Skills in Settings -> Features -> Enable Skills. Do not fall back to treating `.cline/skills/` as passive documentation unless the user asks for that.

At the start of a task, use the `using-superpowers` skill first, then activate any other Superpowers skill whose `name` and `description` match the user's request.

Priority order:

1. Explicit user instructions in the current Cline task.
2. Existing project instructions and workspace rules.
3. Active Superpowers Cline skills under `.cline/skills/`.
4. These bootstrap `.clinerules/` guardrails.

When an upstream Superpowers doc says to use a tool that Cline does not have, translate the intent instead of naming the unavailable tool.

Use these mappings:

- `invoke Skill tool` means call Cline's `use_skill` tool for the relevant skill under `.cline/skills/`.
- `TodoWrite` means maintain a visible Markdown checklist or use Cline's task UI if available.
- `subagent` means Cline's read-only `use_subagents` research tool, or a separate Cline task if the user asks for manual `/newtask` splitting.
- `dispatch agents` means use Cline subagents only for read-only research, or propose independent task prompts when the user wants manual control.
- `implementation action` means file edits, state-changing commands, dependency installs, commits, pushes, and PR creation.

Keep adapted behavior practical. Do not force heavyweight process for trivial read-only answers.
