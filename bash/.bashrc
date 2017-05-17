if [[ "$OSTYPE" != "linux-android" ]]; then
	[ -n "$PS1" ] && source ~/.bash_profile;
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
