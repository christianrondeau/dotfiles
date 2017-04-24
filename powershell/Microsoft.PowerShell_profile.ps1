$Host.UI.RawUI.BackgroundColor = "Black"

Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PsReadlineOption -EditMode Vi

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module posh-git

if (Test-Path("$PSScriptRoot\Microsoft.PowerShell_prompt.ps1")) {
	. "$PSScriptRoot\Microsoft.PowerShell_prompt.ps1"
}

if (Test-Path("$PSScriptRoot\Microsoft.PowerShell_aliases.ps1")) {
	. "$PSScriptRoot\Microsoft.PowerShell_aliases.ps1"
}

if (Test-Path("$PSScriptRoot\Microsoft.PowerShell_local.ps1")) {
	. "$PSScriptRoot\Microsoft.PowerShell_local.ps1"
}
