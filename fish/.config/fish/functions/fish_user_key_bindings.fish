function fish_user_key_bindings
	if type -q fzf_key_bindings
		fzf_key_bindings
	end

	bind \cr reverse_history_search
	bind -M insert \cr reverse_history_search

	bind -M insert \e\[1~ beginning-of-line 2> /dev/null
	bind -M insert \e\[3~ delete-char 2> /dev/null
	bind -M insert \e\[4~ end-of-line 2> /dev/null
end

