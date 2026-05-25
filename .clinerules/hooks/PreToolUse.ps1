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
  $message = "Superpowers strict hook blocked a destructive command. Do not retry this command now. Switch to a safe non-destructive step: inspect git status, read relevant files, or write a short risk plan. Retry only if the exact destructive operation was already explicitly requested, and include # superpowers-approved in the command text."
  Write-HookResponse -Cancel $true -ErrorMessage $message
  exit 0
}

if (((Test-DependencyCommand $combinedText) -or (Test-DatabaseCommand $combinedText)) -and -not $hasApproval) {
  $context = @"
Superpowers strict-mode warning: this dependency or database/schema command is risky.

Continue with a safe step before this command:
- Use /superpowers-plan.md to outline the change.
- Inspect current files and existing scripts.
- Document verification and rollback risk.
- Continue only when the command was already requested or the risk is clearly understood.
"@
  Write-HookResponse -ContextModification $context
  exit 0
}

if ((Test-WriteTool $toolName) -and (Test-RiskyPathOrArea $combinedText) -and -not $hasApproval) {
  $context = @"
Superpowers strict-mode warning: this tool touches a risky file or area.

Before proceeding, ensure one of these is true:
- You wrote or are following a plan from /superpowers-plan.md.
- You are following /superpowers-tdd.md or /superpowers-debug.md.
- This is a small, low-risk edit and you can explain why.

Verify after the tool runs and report the exact verification evidence.
"@
  Write-HookResponse -ContextModification $context
  exit 0
}

Write-HookResponse
