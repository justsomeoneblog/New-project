# Cline Superpowers Hooks, Workflows, and Rules Design

## Goal

Extend the existing Cline-native Superpowers kit so it works more like upstream Superpowers inside the Cline VS Code extension. The result should be usable immediately after cloning or copying the repo into a project.

The kit must remain Cline-native:

- Skills live in `.cline/skills/`.
- Rules live in `.clinerules/`.
- Slash workflows live in `.clinerules/workflows/`.
- Windows hooks live in `.clinerules/hooks/`.

Do not reintroduce a passive legacy docs mirror for Superpowers.

## Chosen Scope

Use the full workflow set, close to upstream Superpowers:

- Planning and spec workflow.
- Debugging workflow.
- Code review workflow.
- Finishing workflow.
- Parallel research workflow.
- TDD workflow.
- Branch/worktree workflow.
- Review-feedback intake workflow.
- Skill-writing workflow.

Hooks should be strict but conditional. They should block or strongly warn for risky operations, while allowing small, low-risk edits.

Hooks target Windows and VS Code only, using PowerShell scripts.

## Rules

Keep the existing `.clinerules/*.md` bootstrap rules and update them where needed so they describe the complete system:

- `.cline/skills/` contains the real project skills.
- `.clinerules/workflows/` contains reusable slash workflows.
- `.clinerules/hooks/` contains lifecycle and tool guardrails.
- Cline should use `use_skill` for relevant skills.
- Cline subagents are read-only research agents.

Rules should not tell Cline to treat skills as documentation. Skills are active Cline project skills.

## Workflows

Create these Markdown workflows under `.clinerules/workflows/`:

- `superpowers-plan.md`
- `superpowers-debug.md`
- `superpowers-review.md`
- `superpowers-finish.md`
- `superpowers-parallel-research.md`
- `superpowers-tdd.md`
- `superpowers-branch.md`
- `superpowers-receive-review.md`
- `superpowers-write-skill.md`

Each workflow should:

1. State when to use it.
2. Name the required Cline skills.
3. Give Cline a short execution sequence.
4. Preserve Cline-specific constraints, especially read-only subagents.

The workflows are reusable slash commands, not replacements for skills.

## Hooks

Create Windows PowerShell hooks under `.clinerules/hooks/`:

- `TaskStart.ps1`
- `UserPromptSubmit.ps1`
- `PreToolUse.ps1`
- `PostToolUse.ps1`
- `TaskComplete.ps1`

Hook behavior:

`TaskStart.ps1` injects context reminding Cline that Superpowers is installed as project skills and should be activated with `use_skill`.

`UserPromptSubmit.ps1` detects risky task language and suggests the matching Superpowers workflow or skills. Risky language includes auth, database, schema, migration, dependency, package install, git, branch, merge, push, infrastructure, deployment, payment, security, and broad multi-file changes.

`PreToolUse.ps1` is the strict conditional gate. It should block or emit a strong warning for risky tool use when the tool input does not show evidence of planning, approval, or verification. It should target:

- Destructive git commands such as hard reset, force checkout, branch delete, and force push.
- Dependency installation or package manager commands.
- Database/schema/migration commands.
- Broad delete/move operations.
- Bulk edits or file writes in risky areas.

Small, ordinary edits should not be blocked.

`PostToolUse.ps1` reminds Cline to verify after edits, tests, builds, database commands, and git operations.

`TaskComplete.ps1` reminds Cline that final answers must include verification evidence, changed files, and remaining risk when relevant.

## Hook Output Contract

Hooks should output JSON that Cline can consume. When in doubt, hooks should prefer adding context or warning text over failing silently.

The implementation should use a small shared PowerShell helper for parsing hook input and producing JSON so each hook remains short.

## Safety Boundaries

Hooks must not run destructive commands. They only inspect hook input and emit context, warnings, or blocks.

Hooks must not require internet access.

Hooks must not assume a Node, Python, or project app stack exists.

Hooks should be understandable and editable by a user who knows basic PowerShell.

## Verification

After implementation, verify:

- `.clinerules/workflows/` contains all nine workflows.
- `.clinerules/hooks/` contains all five PowerShell hooks plus any shared helper.
- `.cline/skills/` still contains valid Cline skills and `SKILL.md` frontmatter names match directory names.
- No active Cline rule, skill, workflow, or hook references the legacy docs mirror path.
- Hook scripts parse with PowerShell.
- Hook scripts do not contain destructive filesystem or git commands.
- Git status is clean after commit.
