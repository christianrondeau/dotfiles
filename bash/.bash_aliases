# Common
case "$(realpath $(which grep))" in
	*/busybox)
		alias ls='ls -A'
		;;
	*)
		alias ls='ls -A --color=auto'
		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'
		;;
esac

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
alias gu="git pull --ff-only"
alias gd="git diff"
alias gl='git log --graph --color --all --decorate --format="%C(auto)%d %s"'
alias gll='git log --graph --color --all --decorate --format="%C(auto)%h %d %s %Cblue %ar %an"'
alias gx="git show -s --format='%Cgreen%h %Cblue%an %Cred%cr%Creset%n%s'"
