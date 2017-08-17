# Common
alias ..="cd .."
switch (realpath (which grep))
	case '*busybox'
		alias ls="ls -A"
	case '*'
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
alias gaa="git add --all"
alias gaa="git add --interactive"
alias gc="git commit"
alias gca="git commit --amend"
alias gcaa="git commit --amend --no-edit"
alias gp="git push"
alias gu="git pull --ff-only"
alias gd="git diff"
alias gds="git diff --staged"
alias gl='git log --graph --color --all --decorate --format="%C(auto)%d %s"'
alias gll='git log --graph --color --all --decorate --format="%C(auto)%h %d %s %Cblue %ar %an"'
alias gx="git show -s --format='%Cgreen%h %Cblue%an %Cred%cr%Creset%n%s'"
alias groot="pushd (git rev-parse --show-toplevel)"
