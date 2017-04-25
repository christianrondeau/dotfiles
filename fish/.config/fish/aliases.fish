# Common
alias ..="cd .."
if [ "$OSTYPE" = "linux-android" ]
	alias ls="ls -A"
else
	alias ls='ls -A --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
end

# PowerShell
if [ "$OSTYPE" = "cygwin" ]
	alias posh="powershell -File "
end

# Git
alias g="git"
alias gs="git status"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gca="git commit --amend"
alias gp="git push"
alias gu="git pull"
alias gd="git diff"
alias gl="git log --oneline --graph --color --all --decorate"
