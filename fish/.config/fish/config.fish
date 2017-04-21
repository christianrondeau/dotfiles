function fish_prompt
	set -l last_status $status
	
	printf "\n\033[K"
	set_color $fish_prompt_hostname
	echo -n (hostname)
	set_color brblack
	echo -n ':'
	set_color $fish_color_cwd
	echo -n (prompt_pwd)

	set -l git_branch (git rev-parse --abbrev-ref HEAD ^ /dev/null)
	if [ $status -eq 0 ]
		set -l git_dirty_count (git status --porcelain  | wc -l | sed "s/ //g")
		if [ $git_dirty_count -gt 0 ]
			set_color $fish_color_error
			echo -n ' ['$git_branch']'
		else
			set_color green
			echo -n ' ['$git_branch']'
		end
	end

	set_color brblack
	printf "\nλ "
end
