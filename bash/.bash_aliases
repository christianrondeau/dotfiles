# Common
if [[ "$OSTYPE" == "linux-android" ]]; then
	alias ls='ls -A'
else
	alias ls='ls -A --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# PowerShell
if [[ "$OSTYPE" == "cygwin" ]]; then
	alias posh="powershell -File "
fi

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
alias gx="git show -s --format='%Cgreen%h %Cblue%an %Cred%cr%Creset%n%s'"
