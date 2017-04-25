function Git-Status { git status }
Set-Alias -Name ggs -Value Git-Status

function Git-Add { git add }
Set-Alias -Name gga -Value Git-Add

function Git-AddAll  { git add -A }
Set-Alias -Name ggaa -Value Git-AddAll

function Git-Commit { git commit }
Set-Alias -Name ggc -Value Git-Commit

function Git-Amend  { git commit --amend }
Set-Alias -Name ggca -Value Git-Amend

function Git-Push { git push }
Set-Alias -Name ggp -Value Git-Push

function Git-Pull { git pull }
Set-Alias -Name ggu -Value Git-Pull

function Git-Diff { git diff }
Set-Alias -Name ggd -Value Git-Diff

function Git-Log  { git log --oneline --graph --color --all --decorate }
Set-Alias -Name ggl -Value Git-Log
