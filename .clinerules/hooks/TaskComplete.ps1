param(
  [Parameter(ValueFromPipeline = $true)]
  [string[]]$HookInput
)

. "$PSScriptRoot\SuperpowersHookCommon.ps1"

$context = @"
Superpowers completion reminder:

Final responses should include verification evidence when work changed files or behavior. Mention changed areas, commands run, results observed, and any remaining risk. Do not claim success without fresh evidence.
"@

Write-HookResponse -ContextModification $context
