# Create a new AI log entry from ai-log/TEMPLATE.md and append it to ai-log/INDEX.md
# Usage: .\scripts\new-ai-log.ps1 -Member hoang -Topic crisis-detector-regex
param(
    [Parameter(Mandatory = $true)][ValidatePattern('^[a-z0-9-]+$')][string]$Member,
    [Parameter(Mandatory = $true)][ValidatePattern('^[a-z0-9-]+$')][string]$Topic
)
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$date = Get-Date -Format 'yyyy-MM-dd'
$name = "${date}_${Member}_${Topic}.md"
$sessions = Join-Path $root 'ai-log\sessions'
$path = Join-Path $sessions $name

if (Test-Path $path) { throw "Already exists: ai-log/sessions/$name" }
New-Item -ItemType Directory -Force $sessions | Out-Null

$utf8 = New-Object System.Text.UTF8Encoding $false
$template = [IO.File]::ReadAllText((Join-Path $root 'ai-log\TEMPLATE.md'), $utf8)
$content = $template.Replace('{{DATE}}', $date).Replace('{{MEMBER}}', $Member).Replace('{{TOPIC}}', $Topic)
[IO.File]::WriteAllText($path, $content, $utf8)

$row = "| $date | $Member | $Topic | [sessions/$name](sessions/$name) |`n"
[IO.File]::AppendAllText((Join-Path $root 'ai-log\INDEX.md'), $row, $utf8)

Write-Host "Created ai-log/sessions/$name"
