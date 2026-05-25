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
- `subagent` means Cline's `use_subagents` tool for reading files, searching the codebase, and finding documentation. Subagents must not edit files or run state-changing commands.
- `dispatch agents` means use Cline subagents for independent read/search/documentation tasks, then have the main Cline task synthesize the results.
- `implementation action` means file edits, state-changing commands, dependency installs, commits, pushes, and PR creation.

Keep adapted behavior practical. Do not force heavyweight process for trivial read-only answers.

Avoid freezing on human-action prompts. Do not ask the user to take an action unless the task is genuinely blocked. Prefer to continue with a safe read/search/plan step, state the assumption, and keep moving.

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

Hooks are strict but conditional. They can block truly destructive commands and inject warnings before risky operations. If a hook blocks an operation, report the reason and switch to the safest non-destructive next step, such as reading files, searching documentation, or writing a plan.

For risky commands that were already explicitly requested by the user, include a clear marker in the command text such as `# superpowers-approved`. Do not add this marker unless the user has already requested or confirmed that exact risky operation.
