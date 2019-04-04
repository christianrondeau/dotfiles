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
alias gg="git"
alias ggs="git status"
alias gga="git add"
alias ggaa="git add --all"
alias ggai="git add --interactive"
alias ggc="git commit"
alias ggca="git commit --amend"
alias ggcaa="git commit --amend --no-edit"
alias ggp="git push"
alias ggp="git push --force-with-lease"
alias ggu="git pull --ff-only"
alias ggd="git diff"
alias ggds="git diff --staged"
alias ggl='git log --graph --color --all --decorate --format="%C(auto)%d %s"'
alias ggll='git log --graph --color --all --decorate --format="%C(auto)%h %d %s %Cblue %ar %an"'
alias ggx="git show -s --format='%Cgreen%h %Cblue%an %Cred%cr%Creset%n%s'"
alias ggroot="pushd (git rev-parse --show-toplevel)"
