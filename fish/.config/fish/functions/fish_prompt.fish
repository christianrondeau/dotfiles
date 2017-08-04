# initialize variables
if not set -q __fish_prompt_hostname
	if [ $COMPUTERNAME ]
		set -g __fish_prompt_hostname $COMPUTERNAME
	else
		set -g __fish_prompt_hostname (hostname | cut -d . -f 1)
	end
end
set -g __fish_prompt_prefix "λ "
set -g __fish_prompt_dim 946638

# Prompt
function fish_prompt

	# Start with a clean line
	printf "\n\033[K"

	# Error notice
	set -l last_status $status
	if test $last_status -ne 0
		set -l __fish_prompt_status "[E$last_status] "
	end

	# Pwd
	set -l __fish_prompt_pwd (prompt_pwd)

	# Git status
	set -l __fish_prompt_git_color white
	set -l __fish_prompt_git ''
	set -l git_branch (git rev-parse --abbrev-ref HEAD ^ /dev/null)
	if [ $status -eq 0 ]
		set -l git_dirty_count (git status --porcelain  | wc -l | sed "s/ //g")
		if [ $git_dirty_count -gt 0 ]
			set __fish_prompt_git_color red
			set __fish_prompt_git " ⎇ $git_branch ± $git_dirty_count"
		else
			set __fish_prompt_git_color green
			set __fish_prompt_git " ⎇ $git_branch"
		end
	end

	if test (string length "$__fish_prompt_status$__fish_prompt_hostname:$__fish_prompt_pwd$__fish_prompt_git") -le $COLUMNS
		# host:pwd [b]
		set_color $fish_color_error
		echo -n $__fish_prompt_status
		set_color normal
		echo -n $__fish_prompt_hostname
		set_color $__fish_prompt_dim
		echo -n ':'
		set_color $fish_color_cwd
		echo -n $__fish_prompt_pwd
		set_color $__fish_prompt_git_color
		echo -n $__fish_prompt_git
	else
		set_color $fish_color_error
		echo -n $__fish_prompt_status
		set_color normal
		echo -n .
		set_color $__fish_prompt_dim
		echo -n ':'
		set_color $fish_color_cwd
		echo -n (basename $PWD)
		set_color $__fish_prompt_git_color
		echo -n " ⎇"
	end

	# Input line
	echo

	# Adjust color based on vi mode
	set __fish_prompt_prefix_background normal
	set __fish_prompt_prefix_color $__fish_prompt_dim
	if test "$fish_key_bindings" = "fish_vi_key_bindings"
		switch $fish_bind_mode
		case default
			set __fish_prompt_prefix_background green
			set __fish_prompt_prefix_color black
			set_color $fish_prompt_dim
		case visual
			set __fish_prompt_prefix_background blue
			set __fish_prompt_prefix_color black
		case replace-one
			set __fish_prompt_prefix_background red
			set __fish_prompt_prefix_color black
		end
	end

	set_color --background $__fish_prompt_prefix_background
	set_color $__fish_prompt_prefix_color
	echo -n $__fish_prompt_prefix
	set_color normal
end
