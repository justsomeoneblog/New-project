param(
  [Parameter(ValueFromPipeline = $true)]
  [string[]]$HookInput
)

. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$inputObject = Read-HookInput -PipelineInput $HookInput
$toolName = Get-PostToolName $inputObject
$parametersText = Get-ToolParametersText $inputObject "postToolUse"
$combinedText = "$toolName $parametersText"

if ((Test-WriteTool $toolName) -or (Test-DependencyCommand $combinedText) -or (Test-DatabaseCommand $combinedText) -or ($combinedText -match "(?i)\b(test|build|lint|git\s+(add|commit|merge|push|checkout|switch))\b")) {
  $context = @"
Superpowers post-tool note: verify before claiming completion.

Use verification-before-completion when relevant. Report:
- The command or inspection used.
- The result you observed.
- Remaining risk or missing verification.
"@
  Write-HookResponse -ContextModification $context
  exit 0
}

Write-HookResponse
