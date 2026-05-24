# Cline Superpowers Active Rules Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a workspace-local Cline rules kit that adapts Superpowers workflows into Cline-compatible active rules and mirrors upstream Superpowers docs for reference.

**Architecture:** Keep active Cline instructions in small Markdown files under `.clinerules/`. Keep upstream source material in `docs/superpowers/skills/` as read-only reference docs. Add `docs/superpowers/CLINE-USAGE.md` to explain how Cline should use the adapted rules and how maintainers can refresh the vendor copy.

**Tech Stack:** Markdown, Git, PowerShell, Cline workspace rules.

---

## File Structure

- Create `.clinerules/00-superpowers-core.md`: global precedence, source mapping, and Cline compatibility rules.
- Create `.clinerules/10-superpowers-brainstorming.md`: Cline adaptation of Superpowers brainstorming.
- Create `.clinerules/20-superpowers-planning.md`: Cline adaptation of planning and spec handoff.
- Create `.clinerules/30-superpowers-debugging.md`: Cline adaptation of systematic debugging.
- Create `.clinerules/40-superpowers-testing.md`: Cline adaptation of test-first behavior.
- Create `.clinerules/50-superpowers-code-review.md`: Cline adaptation of review workflows.
- Create `.clinerules/60-superpowers-git-workflow.md`: Cline adaptation of safe branch, commit, and completion behavior.
- Create `.clinerules/70-superpowers-multi-agent-doc-reading.md`: Cline adaptation for manual multi-agent documentation reading.
- Create `docs/superpowers/CLINE-USAGE.md`: usage, update, and safety notes.
- Create `docs/superpowers/skills/`: vendor copy of upstream `obra/superpowers/skills/`.

### Task 1: Import Upstream Superpowers Skills

**Files:**
- Create: `docs/superpowers/skills/`
- Read source: `https://github.com/obra/superpowers/tree/main/skills`

- [ ] **Step 1: Fetch upstream into a temporary directory**

Run this from the repository root:

```powershell
$temp = Join-Path $env:TEMP "superpowers-upstream"
if (Test-Path -LiteralPath $temp) {
  Remove-Item -LiteralPath $temp -Recurse -Force
}
git clone --depth 1 https://github.com/obra/superpowers.git $temp
```

Expected: `$temp\skills` exists and contains upstream skill directories such as `using-superpowers`, `brainstorming`, `writing-plans`, `systematic-debugging`, and `verification-before-completion`.

- [ ] **Step 2: Copy upstream skills into the local docs mirror**

Run this from the repository root:

```powershell
New-Item -ItemType Directory -Force -Path "docs/superpowers" | Out-Null
if (Test-Path -LiteralPath "docs/superpowers/skills") {
  Remove-Item -LiteralPath "docs/superpowers/skills" -Recurse -Force
}
Copy-Item -LiteralPath "$temp/skills" -Destination "docs/superpowers/skills" -Recurse
```

Expected: `docs/superpowers/skills/using-superpowers/SKILL.md` and `docs/superpowers/skills/brainstorming/SKILL.md` exist.

- [ ] **Step 3: Remove the temporary clone**

```powershell
Remove-Item -LiteralPath $temp -Recurse -Force
```

Expected: the temporary directory is gone and the project only contains the vendor copy.

- [ ] **Step 4: Verify the mirror**

```powershell
Test-Path "docs/superpowers/skills/using-superpowers/SKILL.md"
Test-Path "docs/superpowers/skills/brainstorming/SKILL.md"
Test-Path "docs/superpowers/skills/writing-plans/SKILL.md"
```

Expected: all three commands print `True`.

### Task 2: Create Core Cline Rule

**Files:**
- Create: `.clinerules/00-superpowers-core.md`

- [ ] **Step 1: Create the rule file**

Create `.clinerules/00-superpowers-core.md` with this content:

```markdown
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
```

Expected: the rule is always active because it is a Markdown file in `.clinerules/` and does not reference unavailable tools as callable Cline tools.

### Task 3: Create Brainstorming Rule

**Files:**
- Create: `.clinerules/10-superpowers-brainstorming.md`

- [ ] **Step 1: Create the rule file**

Create `.clinerules/10-superpowers-brainstorming.md` with this content:

```markdown
# Superpowers Brainstorming for Cline

Use this rule when the user asks for creative work, feature design, behavior changes, architecture changes, or unclear implementation work.

Before editing files for those tasks:

1. Inspect the existing project context that affects the request.
2. Ask concise clarifying questions when requirements are ambiguous.
3. Propose two or three viable approaches with trade-offs when the choice matters.
4. Recommend one approach and explain why.
5. Present a short design and wait for user approval before implementation.

For tiny, obvious, low-risk changes, keep the design to a few sentences. For larger changes, cover architecture, affected files, data flow, error handling, and verification.

Reference docs:

- `docs/superpowers/skills/brainstorming/SKILL.md`
- `docs/superpowers/skills/writing-plans/SKILL.md`
```

Expected: the rule preserves the Superpowers approval gate while using Cline-compatible wording.

### Task 4: Create Planning Rule

**Files:**
- Create: `.clinerules/20-superpowers-planning.md`

- [ ] **Step 1: Create the rule file**

Create `.clinerules/20-superpowers-planning.md` with this content:

```markdown
# Superpowers Planning for Cline

Use this rule after the user approves a design or when a task needs multiple coordinated edits.

For multi-step implementation:

1. Write a concise plan before editing files.
2. Identify files to create or modify.
3. Break work into small steps that can be verified independently.
4. Include expected verification commands and outcomes.
5. Update the plan as steps complete when the task is long enough to need tracking.

Plans should be detailed enough for another Cline task to continue the work, but not padded with process for simple one-file edits.

Reference docs:

- `docs/superpowers/skills/writing-plans/SKILL.md`
- `docs/superpowers/skills/executing-plans/SKILL.md`
- `docs/superpowers/skills/subagent-driven-development/SKILL.md`
```

Expected: the rule encourages planning without requiring non-Cline tools.

### Task 5: Create Debugging Rule

**Files:**
- Create: `.clinerules/30-superpowers-debugging.md`

- [ ] **Step 1: Create the rule file**

Create `.clinerules/30-superpowers-debugging.md` with this content:

```markdown
# Superpowers Debugging for Cline

Use this rule for bugs, test failures, regressions, unexpected behavior, or build failures.

Debugging sequence:

1. Reproduce the failure or inspect the reported evidence.
2. State what is known and what is still unknown.
3. Trace the smallest relevant path through the code.
4. Form one concrete hypothesis at a time.
5. Make the smallest fix that explains the evidence.
6. Verify the fix with the most focused command available, then broaden verification when risk justifies it.

Do not guess at fixes before collecting evidence unless the user explicitly asks for a speculative answer.

Reference docs:

- `docs/superpowers/skills/systematic-debugging/SKILL.md`
- `docs/superpowers/skills/verification-before-completion/SKILL.md`
```

Expected: the rule maps Superpowers debugging discipline to Cline.

### Task 6: Create Testing Rule

**Files:**
- Create: `.clinerules/40-superpowers-testing.md`

- [ ] **Step 1: Create the rule file**

Create `.clinerules/40-superpowers-testing.md` with this content:

```markdown
# Superpowers Testing for Cline

Use this rule for bug fixes, behavior changes, and risky refactors.

Testing guidance:

1. Prefer writing or updating a focused test that demonstrates the desired behavior before changing implementation.
2. Run the focused test and confirm it fails for the expected reason when practical.
3. Implement the smallest change that makes the test pass.
4. Run the focused test again.
5. Run broader verification when the change touches shared behavior or user-facing workflows.

If adding a test is impractical, explain why and use the strongest available manual or command-line verification.

Reference docs:

- `docs/superpowers/skills/test-driven-development/SKILL.md`
- `docs/superpowers/skills/verification-before-completion/SKILL.md`
```

Expected: the rule preserves TDD preference without blocking documentation-only work.

### Task 7: Create Code Review Rule

**Files:**
- Create: `.clinerules/50-superpowers-code-review.md`

- [ ] **Step 1: Create the rule file**

Create `.clinerules/50-superpowers-code-review.md` with this content:

```markdown
# Superpowers Code Review for Cline

Use this rule when the user asks for a review, PR review, critique, or inspection of changes.

Review stance:

1. Findings come first.
2. Order findings by severity.
3. Include file and line references when available.
4. Focus on bugs, behavioral regressions, security risks, data loss, missing tests, and maintainability issues that affect the request.
5. Keep summaries brief and secondary.

If there are no findings, say that clearly and mention remaining test gaps or residual risk.

Reference docs:

- `docs/superpowers/skills/requesting-code-review/SKILL.md`
- `docs/superpowers/skills/receiving-code-review/SKILL.md`
```

Expected: the rule is compatible with Cline review tasks and does not assume GitHub tooling.

### Task 8: Create Git Workflow Rule

**Files:**
- Create: `.clinerules/60-superpowers-git-workflow.md`

- [ ] **Step 1: Create the rule file**

Create `.clinerules/60-superpowers-git-workflow.md` with this content:

```markdown
# Superpowers Git Workflow for Cline

Use this rule when work touches branches, commits, PRs, or completion handoff.

Git safety:

1. Check repository status before staging, committing, switching branches, or pushing.
2. Do not overwrite or revert user changes unless the user explicitly asks.
3. Avoid destructive commands such as `git reset --hard`, forced checkout, or broad deletes unless the user explicitly authorizes them.
4. Stage only files relevant to the task.
5. Use clear commit messages that describe the behavior or documentation change.

Completion guidance:

1. Verify the work before claiming it is complete.
2. Report what changed, what was verified, and any remaining risk.
3. If a PR or branch cleanup is appropriate, ask or follow the user's explicit instruction.

Reference docs:

- `docs/superpowers/skills/using-git-worktrees/SKILL.md`
- `docs/superpowers/skills/finishing-a-development-branch/SKILL.md`
- `docs/superpowers/skills/verification-before-completion/SKILL.md`
```

Expected: the rule matches safe Cline git behavior.

### Task 9: Create Multi-Agent Documentation Reading Rule

**Files:**
- Create: `.clinerules/70-superpowers-multi-agent-doc-reading.md`

- [ ] **Step 1: Create the rule file**

Create `.clinerules/70-superpowers-multi-agent-doc-reading.md` with this content:

```markdown
# Superpowers Multi-Agent Documentation Reading for Cline

Use this rule when a task would benefit from multiple independent documentation-reading tracks.

Cline may propose splitting work into separate documentation-reading tasks, but Cline must not automatically open `/newtask` or create a new task. The user decides whether to open another task.

Good candidates for proposed read-only tasks:

- Read planning docs and summarize the implementation workflow.
- Read debugging docs and summarize the debugging checklist.
- Read code review docs and summarize review expectations.
- Read git workflow docs and summarize branch or completion guidance.

Default behavior for separate documentation tasks:

1. Read only the relevant local docs under `docs/superpowers/skills/`.
2. Summarize findings with file references.
3. Do not edit files.
4. Do not run formatters, install packages, commit, push, or create PRs.
5. Do not change scope from read-only unless the user explicitly authorizes it.

Suggested wording:

> This can be split into independent documentation-reading tasks. I can propose the task prompts, and you can decide whether to open them with `/newtask`.

Reference docs:

- `docs/superpowers/skills/dispatching-parallel-agents/SKILL.md`
- `docs/superpowers/skills/subagent-driven-development/SKILL.md`
```

Expected: the rule implements the user's choice: Cline may suggest task splits, but manual user action controls multi-agent execution.

### Task 10: Create Cline Usage Documentation

**Files:**
- Create: `docs/superpowers/CLINE-USAGE.md`

- [ ] **Step 1: Create the usage file**

Create `docs/superpowers/CLINE-USAGE.md` with this content:

```markdown
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
```

Expected: users can understand how to clone/copy the kit into a Cline workspace.

### Task 11: Verify Cline Compatibility

**Files:**
- Read: `.clinerules/*.md`
- Read: `docs/superpowers/CLINE-USAGE.md`
- Read: `docs/superpowers/skills/*/SKILL.md`

- [ ] **Step 1: Verify required paths exist**

```powershell
Test-Path ".clinerules/00-superpowers-core.md"
Test-Path ".clinerules/70-superpowers-multi-agent-doc-reading.md"
Test-Path "docs/superpowers/CLINE-USAGE.md"
Test-Path "docs/superpowers/skills/using-superpowers/SKILL.md"
```

Expected: all commands print `True`.

- [ ] **Step 2: Check adapted rules for direct unavailable tool instructions**

```powershell
Select-String -Path ".clinerules/*.md" -Pattern "invoke Skill tool|TodoWrite|Claude Code subagent|Codex tool" -CaseSensitive
```

Expected: no matches, except explanatory mappings in `00-superpowers-core.md` if the exact terms are present as quoted source terminology.

- [ ] **Step 3: Check multi-agent rule keeps user control**

```powershell
Select-String -Path ".clinerules/70-superpowers-multi-agent-doc-reading.md" -Pattern "must not automatically open `/newtask`|user decides"
```

Expected: matches confirm that Cline proposes task splits but does not start them automatically.

- [ ] **Step 4: Check git status**

```powershell
git status --short
```

Expected: only `.clinerules/`, `docs/superpowers/CLINE-USAGE.md`, `docs/superpowers/skills/`, and this plan are changed.

### Task 12: Commit Implementation

**Files:**
- Stage: `.clinerules/`
- Stage: `docs/superpowers/CLINE-USAGE.md`
- Stage: `docs/superpowers/skills/`
- Stage: `docs/superpowers/plans/2026-05-24-cline-superpowers-active-rules.md`

- [ ] **Step 1: Stage files**

```powershell
git add -- .clinerules docs/superpowers/CLINE-USAGE.md docs/superpowers/skills docs/superpowers/plans/2026-05-24-cline-superpowers-active-rules.md
```

Expected: files are staged.

- [ ] **Step 2: Commit files**

```powershell
git commit -m "feat: adapt superpowers rules for cline"
```

Expected: commit succeeds and contains the Cline rules, usage docs, upstream skills mirror, and implementation plan.
