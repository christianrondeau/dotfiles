# Linux-like Shortcuts

function which($name)
{
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function rm-history
{
	Clear-History
	Remove-Item (Get-PSReadlineOption).HistorySavePath
	[Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory()
	Clear-Host
}

# Fuzzy Find History

function fzf-hist {
	Invoke-Expression (cat (Get-PSReadlineOption | select -ExpandProperty historysavepath) | Invoke-Fzf)
}

# Git Shortcuts

function ggs { git status }
function gga($file) { git add $file }
function ggai { git add --interactive }
function ggaa { git add --all }
function ggc($msg) { if($msg) { git commit -m $msg } else { git commit } }
function ggca { git commit --amend }
function ggcaa { git commit --amend --no-edit }
function ggp { git push }
function ggu { git pull --ff-only }
function ggd { git diff }
function ggds { git diff --staged }
function ggl { git log --graph --color --all --decorate --format="%C(auto)%d %s" }
function ggll { git log --graph --color --all --decorate --format="%C(auto)%h %d %s %Cblue %ar %an" }
function ggx { git show -s --format='%Cgreen%h %Cblue%an %Cred%cr%Creset%n%s' }
function ggroot { pushd (git rev-parse --show-toplevel) }
