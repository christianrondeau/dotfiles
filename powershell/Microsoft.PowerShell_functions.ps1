# Linux-like Shortcuts

function which($name)
{
    Get-Command $name | Select-Object -ExpandProperty Definition
}

# Git Shortcuts

function ggs{ git status }
function gga { git add }
function ggaa  { git add -A }
function ggc { git commit }
function ggca  { git commit --amend }
function ggcaa  { git commit --amend --no-edit }
function ggp { git push }
function ggu { git pull --ff-only }
function ggd { git diff }
function ggds { git diff --staged }
function ggl  { git log --graph --color --all --decorate --format="%C(auto)%d %s" }
function ggll  { git log --graph --color --all --decorate --format="%C(auto)%h %d %s %Cblue %ar %an" }
function ggx { git show -s --format='%Cgreen%h %Cblue%an %Cred%cr%Creset%n%s' }
function ggroot { pushd (git rev-parse --show-toplevel) }
