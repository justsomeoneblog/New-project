function Read-HookInput {
  param([object[]]$PipelineInput = @())

  $raw = ""
  if ($PipelineInput.Count -gt 0) {
    $raw = ($PipelineInput | ForEach-Object { [string]$_ }) -join [Environment]::NewLine
  }

  if ([string]::IsNullOrWhiteSpace($raw)) {
    $raw = [Console]::In.ReadToEnd()
  }

  if ([string]::IsNullOrWhiteSpace($raw)) {
    return [pscustomobject]@{}
  }

  try {
    return $raw | ConvertFrom-Json
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

  return $Text -match "(?i)(superpowers-approved|approved by user|user approved|explicitly authorized|allow-risk|plan approved|duyet|da duyet)"
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
