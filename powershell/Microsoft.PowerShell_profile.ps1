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

$ProfileInfo = Get-Item $PROFILE
if(($ProfileInfo).LinkType -eq "SymbolicLink") {
	$ProfileScriptsPath = Split-Path $ProfileInfo.Target
} else {
	$ProfileScriptsPath = Split-Path $ProfileInfo.FullName
}

if (Test-Path("$ProfileScriptsPath\Microsoft.PowerShell_functions.ps1")) {
	. "$ProfileScriptsPath\Microsoft.PowerShell_functions.ps1"
}

if (Test-Path("$ProfileScriptsPath\Microsoft.PowerShell_prompt.ps1")) {
	. "$ProfileScriptsPath\Microsoft.PowerShell_prompt.ps1"
}

if (Test-Path("$ProfileScriptsPath\Microsoft.PowerShell_aliases.ps1")) {
	. "$ProfileScriptsPath\Microsoft.PowerShell_aliases.ps1"
}

if (Test-Path("$ProfileScriptsPath\Microsoft.PowerShell_local.ps1")) {
	. "$ProfileScriptsPath\Microsoft.PowerShell_local.ps1"
}
