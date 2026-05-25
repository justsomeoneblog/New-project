param(
  [Parameter(ValueFromPipeline = $true)]
  [string[]]$HookInput
)

. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$inputObject = Read-HookInput -PipelineInput $HookInput
$userPromptSubmit = Get-HookProperty $inputObject @("userPromptSubmit")
$prompt = [string](Get-HookProperty $userPromptSubmit @("prompt"))

if (Test-RiskyPrompt $prompt) {
  $context = @"
Superpowers strict-mode note: this prompt looks risky or multi-step.

Before editing, prefer the matching workflow:
- Planning or multi-file work: /superpowers-plan.md
- Bug or failure: /superpowers-debug.md
- Behavior change or bug fix: /superpowers-tdd.md
- Branch/worktree/git setup: /superpowers-branch.md
- Review or merge readiness: /superpowers-review.md or /superpowers-finish.md

If you continue without a workflow, explicitly explain why the task is small and low-risk.
"@
  Write-HookResponse -ContextModification $context
  exit 0
}

Write-HookResponse
