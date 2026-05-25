# Cline Superpowers Hooks Workflows Rules Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add Cline-native Superpowers hooks, workflows, and rule wiring so the kit is usable immediately in Cline on Windows.

**Architecture:** Keep Superpowers skills in `.cline/skills/` and add reusable slash workflows under `.clinerules/workflows/`. Add Windows-only PowerShell hooks under `.clinerules/hooks/` with a shared helper module for JSON parsing, risk detection, and JSON responses. Update core rules to tell Cline how skills, workflows, and hooks work together.

**Tech Stack:** Markdown, PowerShell 5+, Cline workspace rules, Cline project skills, Cline hooks.

---

## File Structure

- Modify `.clinerules/00-superpowers-core.md`: add complete layout, workflow, and hook guidance.
- Create `.clinerules/workflows/superpowers-plan.md`: planning/spec workflow.
- Create `.clinerules/workflows/superpowers-debug.md`: systematic debugging workflow.
- Create `.clinerules/workflows/superpowers-review.md`: pre-completion code review workflow.
- Create `.clinerules/workflows/superpowers-finish.md`: verification and finishing workflow.
- Create `.clinerules/workflows/superpowers-parallel-research.md`: read-only subagent research workflow.
- Create `.clinerules/workflows/superpowers-tdd.md`: test-driven development workflow.
- Create `.clinerules/workflows/superpowers-branch.md`: branch/worktree workflow.
- Create `.clinerules/workflows/superpowers-receive-review.md`: incoming review feedback workflow.
- Create `.clinerules/workflows/superpowers-write-skill.md`: skill writing workflow.
- Create `.clinerules/hooks/SuperpowersHookCommon.ps1`: shared PowerShell helper.
- Create `.clinerules/hooks/TaskStart.ps1`: inject startup context.
- Create `.clinerules/hooks/UserPromptSubmit.ps1`: detect risky prompts and suggest workflows.
- Create `.clinerules/hooks/PreToolUse.ps1`: strict conditional risk gate.
- Create `.clinerules/hooks/PostToolUse.ps1`: post-tool verification reminder.
- Create `.clinerules/hooks/TaskComplete.ps1`: completion verification reminder.

### Task 1: Update Core Rule Wiring

**Files:**
- Modify: `.clinerules/00-superpowers-core.md`

- [ ] **Step 1: Append the Cline-native workflow and hook section**

Append this section to `.clinerules/00-superpowers-core.md`:

```markdown
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
```

Expected: the core rule explains skills, rules, workflows, hooks, and the approval marker.

### Task 2: Add Full Superpowers Workflow Set

**Files:**
- Create: `.clinerules/workflows/superpowers-plan.md`
- Create: `.clinerules/workflows/superpowers-debug.md`
- Create: `.clinerules/workflows/superpowers-review.md`
- Create: `.clinerules/workflows/superpowers-finish.md`
- Create: `.clinerules/workflows/superpowers-parallel-research.md`
- Create: `.clinerules/workflows/superpowers-tdd.md`
- Create: `.clinerules/workflows/superpowers-branch.md`
- Create: `.clinerules/workflows/superpowers-receive-review.md`
- Create: `.clinerules/workflows/superpowers-write-skill.md`

- [ ] **Step 1: Create `superpowers-plan.md`**

```markdown
# Superpowers Plan Workflow

Use this workflow for feature design, architecture changes, multi-file edits, or any task where the implementation path is unclear.

Required Cline skills:

- `using-superpowers`
- `brainstorming`
- `writing-plans`

Workflow:

1. Activate `using-superpowers`.
2. Activate `brainstorming`.
3. Inspect the relevant project context before proposing changes.
4. Ask concise clarifying questions when requirements are ambiguous.
5. Present two or three approaches with trade-offs.
6. Present the selected design and wait for user approval.
7. Activate `writing-plans`.
8. Write the implementation plan under `.cline/superpowers/plans/`.
9. Do not edit implementation files until the user approves the plan or explicitly asks to proceed.
```

- [ ] **Step 2: Create `superpowers-debug.md`**

```markdown
# Superpowers Debug Workflow

Use this workflow for bugs, regressions, failed tests, build errors, and unexpected behavior.

Required Cline skills:

- `using-superpowers`
- `systematic-debugging`
- `verification-before-completion`

Workflow:

1. Activate `using-superpowers`.
2. Activate `systematic-debugging`.
3. Reproduce the failure or inspect the provided evidence.
4. State known facts and unknowns before changing code.
5. Trace the smallest relevant execution path.
6. Test one hypothesis at a time.
7. Make the smallest fix that explains the evidence.
8. Activate `verification-before-completion`.
9. Verify with the focused failing case first, then broaden verification when risk justifies it.
```

- [ ] **Step 3: Create `superpowers-review.md`**

```markdown
# Superpowers Review Workflow

Use this workflow before merging, before a PR, after major implementation work, or whenever the user asks for review.

Required Cline skills:

- `using-superpowers`
- `requesting-code-review`
- `verification-before-completion`

Workflow:

1. Activate `using-superpowers`.
2. Activate `requesting-code-review`.
3. Inspect the diff and relevant files.
4. Use Cline subagents only for read-only review when useful.
5. Put findings first, ordered by severity, with file and line references.
6. If there are no findings, say so and identify remaining test or verification risk.
7. Activate `verification-before-completion` before claiming the branch is ready.
```

- [ ] **Step 4: Create `superpowers-finish.md`**

```markdown
# Superpowers Finish Workflow

Use this workflow when implementation is complete and the user wants to commit, merge, push, or open a PR.

Required Cline skills:

- `using-superpowers`
- `verification-before-completion`
- `finishing-a-development-branch`

Workflow:

1. Activate `using-superpowers`.
2. Activate `verification-before-completion`.
3. Run the strongest relevant verification available for this repo.
4. Read the command output and report exact evidence.
5. Activate `finishing-a-development-branch`.
6. Check git status before staging or committing.
7. Stage only task-relevant files.
8. Commit only after verification evidence is available.
9. Ask before merge, push, PR creation, or destructive cleanup unless the user already gave explicit instructions.
```

- [ ] **Step 5: Create `superpowers-parallel-research.md`**

```markdown
# Superpowers Parallel Research Workflow

Use this workflow when there are two or more independent research tracks.

Required Cline skills:

- `using-superpowers`
- `dispatching-parallel-agents`
- `subagent-driven-development`

Workflow:

1. Activate `using-superpowers`.
2. Activate `dispatching-parallel-agents`.
3. Identify independent domains.
4. Use Cline `use_subagents` only for read-only research.
5. Give each subagent one focused prompt, exact scope, and required output.
6. Subagents must not edit files, install packages, commit, push, or create PRs.
7. Main Cline task reviews subagent findings and performs any edits.
8. If the user wants manual task splitting, propose `/newtask` prompts instead of opening tasks automatically.
```

- [ ] **Step 6: Create `superpowers-tdd.md`**

```markdown
# Superpowers TDD Workflow

Use this workflow for bug fixes, behavior changes, and risky refactors.

Required Cline skills:

- `using-superpowers`
- `test-driven-development`
- `verification-before-completion`

Workflow:

1. Activate `using-superpowers`.
2. Activate `test-driven-development`.
3. Write or update the smallest focused test that captures the behavior.
4. Run the focused test and confirm it fails for the expected reason when practical.
5. Implement the smallest code change that makes the test pass.
6. Run the focused test again.
7. Activate `verification-before-completion`.
8. Run broader verification when the change touches shared behavior or user-facing flows.
```

- [ ] **Step 7: Create `superpowers-branch.md`**

```markdown
# Superpowers Branch Workflow

Use this workflow before starting isolated feature work, switching branches, or preparing a worktree.

Required Cline skills:

- `using-superpowers`
- `using-git-worktrees`

Workflow:

1. Activate `using-superpowers`.
2. Activate `using-git-worktrees`.
3. Check current git status and branch.
4. Do not overwrite or revert user changes.
5. Prefer the existing workspace when the user has already chosen it.
6. If a new branch or worktree is needed, explain why and ask before creating it.
7. Never use destructive git commands unless the user explicitly requests and confirms them.
```

- [ ] **Step 8: Create `superpowers-receive-review.md`**

```markdown
# Superpowers Receive Review Workflow

Use this workflow when the user provides review feedback or asks you to address review comments.

Required Cline skills:

- `using-superpowers`
- `receiving-code-review`
- `systematic-debugging`
- `verification-before-completion`

Workflow:

1. Activate `using-superpowers`.
2. Activate `receiving-code-review`.
3. Read all feedback before reacting.
4. Restate unclear requirements or ask for clarification.
5. Verify each suggestion against the codebase before implementing it.
6. Push back with technical reasoning when feedback is incorrect or conflicts with project constraints.
7. Implement one review item at a time.
8. Activate `verification-before-completion` before reporting completion.
```

- [ ] **Step 9: Create `superpowers-write-skill.md`**

```markdown
# Superpowers Write Skill Workflow

Use this workflow when creating or changing Cline/Superpowers skills.

Required Cline skills:

- `using-superpowers`
- `writing-skills`
- `verification-before-completion`

Workflow:

1. Activate `using-superpowers`.
2. Activate `writing-skills`.
3. Confirm the skill name, trigger description, and target behavior.
4. Keep the skill Cline-native when it is intended for Cline.
5. Use `.cline/skills/<skill-name>/SKILL.md` for project skills.
6. Ensure `name` in frontmatter exactly matches the directory name.
7. Add supporting files under the skill directory only when they are needed.
8. Activate `verification-before-completion` and verify the skill structure before reporting completion.
```

Expected: `.clinerules/workflows/` contains all nine workflow Markdown files.

### Task 3: Add Shared PowerShell Hook Helper

**Files:**
- Create: `.clinerules/hooks/SuperpowersHookCommon.ps1`

- [ ] **Step 1: Create the shared helper**

Create `.clinerules/hooks/SuperpowersHookCommon.ps1` with this content:

```powershell
function Read-HookInput {
  $raw = [Console]::In.ReadToEnd()
  if ([string]::IsNullOrWhiteSpace($raw)) {
    return [pscustomobject]@{}
  }

  try {
    return $raw | ConvertFrom-Json -Depth 64
  } catch {
    return [pscustomobject]@{
      parseError = $_.Exception.Message
      raw = $raw
    }
  }
}

function Write-HookResponse {
  param(
    [bool]$Cancel = $false,
    [string]$ContextModification = "",
    [string]$ErrorMessage = ""
  )

  $response = [ordered]@{
    cancel = $Cancel
  }

  if (-not [string]::IsNullOrWhiteSpace($ContextModification)) {
    $response.contextModification = $ContextModification
  }

  if (-not [string]::IsNullOrWhiteSpace($ErrorMessage)) {
    $response.errorMessage = $ErrorMessage
  }

  $response | ConvertTo-Json -Compress
}

function ConvertTo-FlatText {
  param([object]$Value)

  if ($null -eq $Value) {
    return ""
  }

  if ($Value -is [string]) {
    return $Value
  }

  try {
    return ($Value | ConvertTo-Json -Depth 64 -Compress)
  } catch {
    return [string]$Value
  }
}

function Get-HookProperty {
  param(
    [object]$Object,
    [string[]]$Names
  )

  foreach ($name in $Names) {
    if ($null -ne $Object -and $Object.PSObject.Properties.Name -contains $name) {
      return $Object.$name
    }
  }

  return $null
}

function Get-PreToolName {
  param([object]$InputObject)

  $preToolUse = Get-HookProperty $InputObject @("preToolUse")
  $name = Get-HookProperty $preToolUse @("toolName", "tool")
  if ($null -eq $name) {
    return ""
  }

  return [string]$name
}

function Get-PostToolName {
  param([object]$InputObject)

  $postToolUse = Get-HookProperty $InputObject @("postToolUse")
  $name = Get-HookProperty $postToolUse @("toolName", "tool")
  if ($null -eq $name) {
    return ""
  }

  return [string]$name
}

function Get-ToolParametersText {
  param(
    [object]$InputObject,
    [string]$HookPropertyName
  )

  $hookData = Get-HookProperty $InputObject @($HookPropertyName)
  $parameters = Get-HookProperty $hookData @("parameters")
  return ConvertTo-FlatText $parameters
}

function Test-ApprovalEvidence {
  param([string]$Text)

  return $Text -match "(?i)(superpowers-approved|approved by user|user approved|explicitly authorized|allow-risk|plan approved|duyet|duyệt|da duyet|đã duyệt)"
}

function Test-RiskyPrompt {
  param([string]$Text)

  return $Text -match "(?i)(auth|authentication|authorization|database|schema|migration|dependency|package install|npm install|pnpm add|yarn add|git|branch|merge|push|infra|infrastructure|deploy|deployment|payment|security|multi-file|many files|refactor)"
}

function Test-DestructiveCommand {
  param([string]$Text)

  return $Text -match "(?i)(git\s+reset\s+--hard|git\s+checkout\s+(-f|--force)|git\s+branch\s+-D|git\s+push\b.*--force|Remove-Item\b.*\b-Recurse\b|rm\s+-rf|rmdir\s+/s|del\s+/s)"
}

function Test-DependencyCommand {
  param([string]$Text)

  return $Text -match "(?i)\b(npm|pnpm|yarn|bun)\s+(install|add|remove|update|upgrade)\b|pip\s+install|uv\s+add|poetry\s+add|cargo\s+add|go\s+get|composer\s+require"
}

function Test-DatabaseCommand {
  param([string]$Text)

  return $Text -match "(?i)\b(prisma\s+(migrate|db\s+push)|migrate\s+(dev|deploy|reset)|sequelize\s+db:migrate|typeorm\s+migration|knex\s+migrate|db:push|db:migrate)\b"
}

function Test-RiskyPathOrArea {
  param([string]$Text)

  return $Text -match "(?i)(package\.json|package-lock\.json|pnpm-lock\.yaml|yarn\.lock|Cargo\.toml|go\.mod|schema\.prisma|migrations?|database|db|auth|payment|security|infra|terraform|docker-compose|kubernetes|k8s)"
}

function Test-WriteTool {
  param([string]$ToolName)

  return $ToolName -match "(?i)(write|edit|replace|insert|apply|patch|execute_command|run_command|shell|terminal)"
}
```

Expected: the helper has no destructive commands and can be dot-sourced by every hook.

### Task 4: Add Windows PowerShell Hooks

**Files:**
- Create: `.clinerules/hooks/TaskStart.ps1`
- Create: `.clinerules/hooks/UserPromptSubmit.ps1`
- Create: `.clinerules/hooks/PreToolUse.ps1`
- Create: `.clinerules/hooks/PostToolUse.ps1`
- Create: `.clinerules/hooks/TaskComplete.ps1`

- [ ] **Step 1: Create `TaskStart.ps1`**

```powershell
. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$inputObject = Read-HookInput
$context = @"
Superpowers is installed as Cline project skills in `.cline/skills/`.

At task start:
- Use `use_skill` for `using-superpowers`.
- Use additional Superpowers skills when their descriptions match the task.
- Use `.clinerules/workflows/*.md` slash workflows for explicit flows.
- Cline subagents are read-only research agents; main Cline performs edits.
"@

Write-HookResponse -ContextModification $context
```

- [ ] **Step 2: Create `UserPromptSubmit.ps1`**

```powershell
. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$inputObject = Read-HookInput
$userPromptSubmit = Get-HookProperty $inputObject @("userPromptSubmit")
$prompt = [string](Get-HookProperty $userPromptSubmit @("prompt"))

if (Test-RiskyPrompt $prompt) {
  $context = @"
Superpowers strict-mode note: this prompt looks risky or multi-step.

Before editing, prefer the matching workflow:
- Planning or multi-file work: `/superpowers-plan.md`
- Bug or failure: `/superpowers-debug.md`
- Behavior change or bug fix: `/superpowers-tdd.md`
- Branch/worktree/git setup: `/superpowers-branch.md`
- Review or merge readiness: `/superpowers-review.md` or `/superpowers-finish.md`

If you continue without a workflow, explicitly explain why the task is small and low-risk.
"@
  Write-HookResponse -ContextModification $context
  exit 0
}

Write-HookResponse
```

- [ ] **Step 3: Create `PreToolUse.ps1`**

```powershell
. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$inputObject = Read-HookInput
$toolName = Get-PreToolName $inputObject
$parametersText = Get-ToolParametersText $inputObject "preToolUse"
$combinedText = "$toolName $parametersText"
$hasApproval = Test-ApprovalEvidence $combinedText

if ((Test-DestructiveCommand $combinedText) -and -not $hasApproval) {
  $message = "Superpowers strict hook blocked a destructive command. Use `/superpowers-plan.md` or `/superpowers-branch.md`, explain the risk, ask the user for explicit approval, then retry only if approved. If approved, include `# superpowers-approved` in the command text."
  Write-HookResponse -Cancel $true -ErrorMessage $message
  exit 0
}

if (((Test-DependencyCommand $combinedText) -or (Test-DatabaseCommand $combinedText)) -and -not $hasApproval) {
  $message = "Superpowers strict hook blocked a dependency or database/schema command without explicit approval. Use `/superpowers-plan.md`, document verification and rollback risk, ask the user for approval, then retry only if approved. If approved, include `# superpowers-approved` in the command text."
  Write-HookResponse -Cancel $true -ErrorMessage $message
  exit 0
}

if ((Test-WriteTool $toolName) -and (Test-RiskyPathOrArea $combinedText) -and -not $hasApproval) {
  $context = @"
Superpowers strict-mode warning: this tool touches a risky file or area.

Before proceeding, ensure one of these is true:
- The user approved a plan from `/superpowers-plan.md`.
- You are following `/superpowers-tdd.md` or `/superpowers-debug.md`.
- This is a small, low-risk edit and you can explain why.

Verify after the tool runs and report the exact verification evidence.
"@
  Write-HookResponse -ContextModification $context
  exit 0
}

Write-HookResponse
```

- [ ] **Step 4: Create `PostToolUse.ps1`**

```powershell
. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$inputObject = Read-HookInput
$toolName = Get-PostToolName $inputObject
$parametersText = Get-ToolParametersText $inputObject "postToolUse"
$combinedText = "$toolName $parametersText"

if ((Test-WriteTool $toolName) -or (Test-DependencyCommand $combinedText) -or (Test-DatabaseCommand $combinedText) -or ($combinedText -match "(?i)\b(test|build|lint|git\s+(add|commit|merge|push|checkout|switch))\b")) {
  $context = @"
Superpowers post-tool note: verify before claiming completion.

Use `verification-before-completion` when relevant. Report:
- The command or inspection used.
- The result you observed.
- Remaining risk or missing verification.
"@
  Write-HookResponse -ContextModification $context
  exit 0
}

Write-HookResponse
```

- [ ] **Step 5: Create `TaskComplete.ps1`**

```powershell
. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$context = @"
Superpowers completion reminder:

Final responses should include verification evidence when work changed files or behavior. Mention changed areas, commands run, results observed, and any remaining risk. Do not claim success without fresh evidence.
"@

Write-HookResponse -ContextModification $context
```

Expected: all five hooks output single-line JSON with `cancel`, `contextModification`, and `errorMessage` fields as appropriate.

### Task 5: Verify Hook Behavior

**Files:**
- Read: `.clinerules/hooks/*.ps1`
- Read: `.clinerules/workflows/*.md`

- [ ] **Step 1: Verify hook scripts parse in PowerShell**

Run:

```powershell
$parseErrors = @()
Get-ChildItem ".clinerules/hooks" -Filter "*.ps1" | ForEach-Object {
  $tokens = $null
  $errors = $null
  [System.Management.Automation.Language.Parser]::ParseFile($_.FullName, [ref]$tokens, [ref]$errors) | Out-Null
  if ($errors.Count -gt 0) {
    $parseErrors += "$($_.Name): $($errors[0].Message)"
  }
}
if ($parseErrors.Count -eq 0) { "OK" } else { $parseErrors }
```

Expected: `OK`.

- [ ] **Step 2: Verify `TaskStart` emits context**

Run:

```powershell
'{"hookName":"TaskStart","taskStart":{"taskMetadata":{"initialTask":"test"}}}' | powershell -NoProfile -ExecutionPolicy Bypass -File ".clinerules/hooks/TaskStart.ps1"
```

Expected: JSON with `"cancel":false` and `contextModification` mentioning `.cline/skills/`.

- [ ] **Step 3: Verify risky prompt emits workflow guidance**

Run:

```powershell
'{"hookName":"UserPromptSubmit","userPromptSubmit":{"prompt":"Change auth schema and run database migration"}}' | powershell -NoProfile -ExecutionPolicy Bypass -File ".clinerules/hooks/UserPromptSubmit.ps1"
```

Expected: JSON with `"cancel":false` and `contextModification` mentioning `/superpowers-plan.md`.

- [ ] **Step 4: Verify destructive command is blocked**

Run:

```powershell
'{"hookName":"PreToolUse","preToolUse":{"toolName":"execute_command","parameters":{"command":"git reset --hard HEAD~1"}}}' | powershell -NoProfile -ExecutionPolicy Bypass -File ".clinerules/hooks/PreToolUse.ps1"
```

Expected: JSON with `"cancel":true` and `errorMessage` mentioning `superpowers-approved`.

- [ ] **Step 5: Verify approved risky command passes**

Run:

```powershell
'{"hookName":"PreToolUse","preToolUse":{"toolName":"execute_command","parameters":{"command":"git reset --hard HEAD~1 # superpowers-approved"}}}' | powershell -NoProfile -ExecutionPolicy Bypass -File ".clinerules/hooks/PreToolUse.ps1"
```

Expected: JSON with `"cancel":false`.

- [ ] **Step 6: Verify small ordinary edit is allowed**

Run:

```powershell
'{"hookName":"PreToolUse","preToolUse":{"toolName":"write_to_file","parameters":{"path":"README.md","content":"hello"}}}' | powershell -NoProfile -ExecutionPolicy Bypass -File ".clinerules/hooks/PreToolUse.ps1"
```

Expected: JSON with `"cancel":false` and no warning context.

### Task 6: Verify Cline-Native Structure

**Files:**
- Read: `.cline/skills/*/SKILL.md`
- Read: `.clinerules/workflows/*.md`
- Read: `.clinerules/hooks/*.ps1`
- Read: `.clinerules/*.md`

- [ ] **Step 1: Verify all nine workflows exist**

Run:

```powershell
$expected = @(
  "superpowers-plan.md",
  "superpowers-debug.md",
  "superpowers-review.md",
  "superpowers-finish.md",
  "superpowers-parallel-research.md",
  "superpowers-tdd.md",
  "superpowers-branch.md",
  "superpowers-receive-review.md",
  "superpowers-write-skill.md"
)
$missing = $expected | Where-Object { -not (Test-Path ".clinerules/workflows/$_") }
if ($missing.Count -eq 0) { "OK" } else { $missing }
```

Expected: `OK`.

- [ ] **Step 2: Verify all five hooks and helper exist**

Run:

```powershell
$expected = @(
  "SuperpowersHookCommon.ps1",
  "TaskStart.ps1",
  "UserPromptSubmit.ps1",
  "PreToolUse.ps1",
  "PostToolUse.ps1",
  "TaskComplete.ps1"
)
$missing = $expected | Where-Object { -not (Test-Path ".clinerules/hooks/$_") }
if ($missing.Count -eq 0) { "OK" } else { $missing }
```

Expected: `OK`.

- [ ] **Step 3: Verify skill frontmatter still matches directory names**

Run:

```powershell
$errors = @()
Get-ChildItem -Directory ".cline/skills" | ForEach-Object {
  $skill = Join-Path $_.FullName "SKILL.md"
  if (-not (Test-Path -LiteralPath $skill)) {
    $errors += "Missing SKILL.md: $($_.Name)"
    return
  }
  $nameLine = Select-String -Path $skill -Pattern "^name:\s*(.+)\s*$" | Select-Object -First 1
  if (-not $nameLine) {
    $errors += "Missing name: $($_.Name)"
    return
  }
  $name = $nameLine.Matches[0].Groups[1].Value.Trim()
  if ($name -ne $_.Name) {
    $errors += "Name mismatch: dir=$($_.Name) name=$name"
  }
}
if ($errors.Count -eq 0) { "OK" } else { $errors }
```

Expected: `OK`.

- [ ] **Step 4: Verify active Cline files do not reference the legacy docs mirror**

Run:

```powershell
$pattern = ("docs" + "/superpowers|docs" + "\\superpowers")
rg $pattern .clinerules .cline/skills
```

Expected: no matches and exit code `1`.

- [ ] **Step 5: Verify hooks do not contain destructive commands**

Run:

```powershell
Select-String -Path ".clinerules/hooks/*.ps1" -Pattern "Remove-Item|rm -rf|git reset --hard|git checkout --|git branch -D|git push --force" -CaseSensitive
```

Expected: matches only inside quoted regex strings in `SuperpowersHookCommon.ps1`; no actual command invocations.

### Task 7: Commit Implementation

**Files:**
- Stage: `.clinerules/00-superpowers-core.md`
- Stage: `.clinerules/workflows/`
- Stage: `.clinerules/hooks/`
- Stage: `.cline/superpowers/plans/2026-05-25-cline-superpowers-hooks-workflows-rules.md`

- [ ] **Step 1: Check current status**

Run:

```powershell
git status --short --branch
```

Expected: modified core rule and new workflows/hooks/plan are visible.

- [ ] **Step 2: Stage implementation files**

Run:

```powershell
git add -- .clinerules/00-superpowers-core.md .clinerules/workflows .clinerules/hooks .cline/superpowers/plans/2026-05-25-cline-superpowers-hooks-workflows-rules.md
```

Expected: files are staged.

- [ ] **Step 3: Commit implementation**

Run:

```powershell
git commit -m "feat: add cline superpowers hooks and workflows"
```

Expected: commit succeeds.

- [ ] **Step 4: Verify clean working tree**

Run:

```powershell
git status --short --branch
```

Expected: only the branch header remains.
