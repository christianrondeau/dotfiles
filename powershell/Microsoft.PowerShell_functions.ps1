# Linux-like Shortcuts

function which($name)
{
    Get-Command $name | Select-Object -ExpandProperty Definition
}

# Git Shortcuts

function Git-Status { git status }
function Git-Add { git add }
function Git-AddAll  { git add -A }
function Git-Commit { git commit }
function Git-Amend  { git commit --amend }
function Git-Push { git push }
function Git-Pull { git pull }
function Git-Diff { git diff }
function Git-Log  { git log --graph --color --all --decorate --format="%C(auto)%d %s" }
function Git-LogVerbose  { git log --graph --color --all --decorate --format="%C(auto)%h %d %s %Cblue %ar %an" }
function Git-Current  { git show -s --format='%Cgreen%h %Cblue%an %Cred%cr%Creset%n%s' }
function Git-Root() { pushd (git rev-parse --show-toplevel) }
