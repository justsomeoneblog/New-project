param(
  [Parameter(ValueFromPipeline = $true)]
  [string[]]$HookInput
)

. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$inputObject = Read-HookInput -PipelineInput $HookInput
$toolName = Get-PreToolName $inputObject
$parametersText = Get-ToolParametersText $inputObject "preToolUse"
$combinedText = "$toolName $parametersText"
$hasApproval = Test-ApprovalEvidence $combinedText

if ((Test-DestructiveCommand $combinedText) -and -not $hasApproval) {
  $message = "Superpowers strict hook blocked a destructive command. Use /superpowers-plan.md or /superpowers-branch.md, explain the risk, ask the user for explicit approval, then retry only if approved. If approved, include # superpowers-approved in the command text."
  Write-HookResponse -Cancel $true -ErrorMessage $message
  exit 0
}

if (((Test-DependencyCommand $combinedText) -or (Test-DatabaseCommand $combinedText)) -and -not $hasApproval) {
  $message = "Superpowers strict hook blocked a dependency or database/schema command without explicit approval. Use /superpowers-plan.md, document verification and rollback risk, ask the user for approval, then retry only if approved. If approved, include # superpowers-approved in the command text."
  Write-HookResponse -Cancel $true -ErrorMessage $message
  exit 0
}

if ((Test-WriteTool $toolName) -and (Test-RiskyPathOrArea $combinedText) -and -not $hasApproval) {
  $context = @"
Superpowers strict-mode warning: this tool touches a risky file or area.

Before proceeding, ensure one of these is true:
- The user approved a plan from /superpowers-plan.md.
- You are following /superpowers-tdd.md or /superpowers-debug.md.
- This is a small, low-risk edit and you can explain why.

Verify after the tool runs and report the exact verification evidence.
"@
  Write-HookResponse -ContextModification $context
  exit 0
}

Write-HookResponse
