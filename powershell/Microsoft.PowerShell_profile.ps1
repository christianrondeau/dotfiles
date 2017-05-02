$Host.UI.RawUI.BackgroundColor = "Black"

Set-PsReadlineOption -EditMode Vi -ViModeIndicator Cursor -HistoryNoDuplicate
Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory -ViMode Insert
Set-PSReadlineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory -ViMode Command

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module posh-git -ErrorAction SilentlyContinue
Import-Module z -ErrorAction SilentlyContinue

if (Test-Path("$PSScriptRoot\Microsoft.PowerShell_prompt.ps1")) {
	. "$PSScriptRoot\Microsoft.PowerShell_prompt.ps1"
}

if (Test-Path("$PSScriptRoot\Microsoft.PowerShell_aliases.ps1")) {
	. "$PSScriptRoot\Microsoft.PowerShell_aliases.ps1"
}

if (Test-Path("$PSScriptRoot\Microsoft.PowerShell_local.ps1")) {
	. "$PSScriptRoot\Microsoft.PowerShell_local.ps1"
}
