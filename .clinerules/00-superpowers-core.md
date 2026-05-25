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

## Cline-Native Superpowers Layout

This project uses all three Cline customization layers:

- Skills: `.cline/skills/`
- Rules: `.clinerules/*.md`
- Workflows: `.clinerules/workflows/*.md`
- Hooks: `.clinerules/hooks/*.ps1`

Use skills for task-specific behavior, workflows for explicit slash-command flows, rules for persistent guidance, and hooks for deterministic safety checks.

Available Superpowers workflows:

- `/superpowers-plan.md`
- `/superpowers-debug.md`
- `/superpowers-review.md`
- `/superpowers-finish.md`
- `/superpowers-parallel-research.md`
- `/superpowers-tdd.md`
- `/superpowers-branch.md`
- `/superpowers-receive-review.md`
- `/superpowers-write-skill.md`

Hooks are strict but conditional. They can block dangerous commands and inject warnings before risky operations. If a hook blocks an operation, explain the reason, use the named Superpowers workflow or skill, ask the user for explicit approval when needed, then retry only after the risk is understood.

For risky commands that were explicitly approved by the user, include a clear marker in the command text such as `# superpowers-approved`. Do not add this marker unless the user has approved the risky operation.
