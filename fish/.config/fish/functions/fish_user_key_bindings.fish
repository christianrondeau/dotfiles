set -g __fish_vi_mode 1
fish_vi_key_bindings
function fish_user_key_bindings
	bind -M insert \e\[1~ beginning-of-line 2> /dev/null
	bind -M insert \e\[3~ delete-char 2> /dev/null
	bind -M insert \e\[4~ end-of-line 2> /dev/null
end
