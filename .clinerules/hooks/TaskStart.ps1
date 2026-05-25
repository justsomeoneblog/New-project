param(
  [Parameter(ValueFromPipeline = $true)]
  [string[]]$HookInput
)

. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$inputObject = Read-HookInput -PipelineInput $HookInput
$context = @"
Superpowers is installed as Cline project skills in .cline/skills/.

At task start:
- Use use_skill for using-superpowers.
- Use additional Superpowers skills when their descriptions match the task.
- Use .clinerules/workflows/*.md slash workflows for explicit flows.
- Cline subagents are read-only research agents; main Cline performs edits.
"@

Write-HookResponse -ContextModification $context
