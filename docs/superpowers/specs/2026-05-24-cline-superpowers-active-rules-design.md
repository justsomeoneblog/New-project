# Cline Superpowers Active Rules Design

## Goal

Create a workspace-local Cline rules kit that adapts the Superpowers workflow for the Cline VS Code extension. The output should be cloneable/copyable into a project and should make Cline behave close to Superpowers while staying compatible with Cline tools and terminology.

## Chosen Approach

Use approach 2B: active Cline rules translated from Superpowers, plus a vendor copy of upstream Superpowers docs for reference.

The active rules live in `.clinerules/` and are written for Cline. They should not paste upstream skill files verbatim when the upstream text refers to non-Cline tools such as `Skill`, `TodoWrite`, Claude Code subagents, Codex-specific tools, or harness-specific commands. Instead, each rule should preserve the intent and map it to Cline behavior.

The upstream docs mirror lives under `docs/superpowers/` and stays close to the source repository so users can compare the adapted rules against the original instructions.

## File Layout

```text
.clinerules/
  00-superpowers-core.md
  10-superpowers-brainstorming.md
  20-superpowers-planning.md
  30-superpowers-debugging.md
  40-superpowers-testing.md
  50-superpowers-code-review.md
  60-superpowers-git-workflow.md
  70-superpowers-multi-agent-doc-reading.md
docs/
  superpowers/
    CLINE-USAGE.md
    skills/
      ...
```

## Rule Responsibilities

`00-superpowers-core.md` establishes precedence and tells Cline that Superpowers docs are reference material. User instructions and project rules remain higher priority than the adapted Superpowers rules.

`10-superpowers-brainstorming.md` adapts the brainstorming workflow for Cline. For unclear or creative work, Cline should clarify intent, propose options, present a design, and wait for approval before editing files.

`20-superpowers-planning.md` adapts planning/spec behavior. For multi-step changes, Cline should write a concise plan with files, risks, and verification before implementation.

`30-superpowers-debugging.md` adapts systematic debugging. Cline should reproduce or inspect the issue first, identify evidence, then make the smallest defensible fix.

`40-superpowers-testing.md` adapts test-first guidance. For bug fixes or behavior changes, Cline should prefer writing or updating focused tests before implementation when practical.

`50-superpowers-code-review.md` adapts review workflows. When asked to review, findings come first, ordered by severity, with file and line references.

`60-superpowers-git-workflow.md` adapts branch, commit, and completion guidance for Cline. It should avoid destructive git commands unless explicitly requested.

`70-superpowers-multi-agent-doc-reading.md` handles the user's requested multi-agent behavior. Cline may propose splitting independent documentation-reading tasks, but it must not automatically open `/newtask` or create sub-tasks. If the user chooses to open a separate task, that task is read-only by default and should only read or summarize docs unless the user explicitly authorizes edits.

## Cline Tool Mapping

Adapt upstream Superpowers terms as follows:

- `invoke Skill tool` -> read the relevant file under `docs/superpowers/skills/.../SKILL.md`.
- `TodoWrite` -> use a visible Markdown checklist or Cline's available task UI if present.
- `subagent` -> a separate Cline task proposed to the user, usually through `/newtask`.
- `dispatch agents` -> propose independent read-only documentation tasks; do not start them automatically.
- `implementation action` -> file edits, command execution that changes state, dependency installation, commits, or PR creation.
- `must use skill` -> consult the adapted rule first; use the upstream docs only as supporting reference.

## Source Handling

Use a vendor copy of upstream Superpowers docs instead of a submodule or sync script. This makes the kit usable immediately after clone/copy. The initial implementation should copy the relevant upstream `skills/` content into `docs/superpowers/skills/` and add `docs/superpowers/CLINE-USAGE.md` explaining how to update the mirror later.

## Safety Boundaries

The adapted rules must not tell Cline to override explicit user instructions. They should also avoid requiring heavy process for trivial read-only questions.

For multi-agent doc reading, Cline can suggest task splits such as "read planning docs", "read debugging docs", or "read review docs", but the user decides whether to open those tasks.

Read-only documentation tasks must not edit files, run formatters, install packages, commit, or push unless the user changes the task scope.

## Verification

After implementation, verify:

- `.clinerules/` contains only Markdown rules compatible with Cline workspace rules.
- The rules refer to local docs paths that exist.
- The upstream mirror is present under `docs/superpowers/skills/`.
- No adapted rule instructs Cline to call unavailable Claude/Codex-only tools directly.
- The multi-agent docs rule says Cline can propose task splits but cannot open them automatically.

