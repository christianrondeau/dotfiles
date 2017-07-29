#function fish_mode_prompt; end

# function fish_prompt
# 	set -l last_status $status
# 	set -l fish_prompt_dim 946638
# 	
# 	printf "\n\033[K"
# 	if test $last_status -ne 0
# 		set_color $fish_color_error
# 		printf "[E$last_status] "
# 	end
# 
# 	set_color normal
# 	if [ $COMPUTERNAME ]
# 		echo -n $COMPUTERNAME
# 	else
# 		echo -n (hostname)
# 	end
# 	set_color $fish_prompt_dim
# 	echo -n ':'
# 	set_color $fish_color_cwd
# 	echo -n (prompt_pwd)
# 
# 	set -l git_branch (git rev-parse --abbrev-ref HEAD ^ /dev/null)
# 	if [ $status -eq 0 ]
# 		set -l git_dirty_count (git status --porcelain  | wc -l | sed "s/ //g")
# 		if [ $git_dirty_count -gt 0 ]
# 			set_color $fish_color_error
# 			echo -n ' ['$git_branch']'
# 		else
# 			set_color green
# 			echo -n ' ['$git_branch']'
# 		end
# 	end
# 
# 	printf "\n"
# 
# 	if set -q __fish_vi_mode
# 		switch $fish_bind_mode
# 		case default
# 			set_color black --background green
# 			printf "λ"
# 		case insert
# 			set_color $fish_prompt_dim
# 			printf "λ"
# 		case visual
# 			set_color black --background blue
# 			printf "λ"
# 		case replace-one
# 			set_color black --background red
# 			printf "λ"
# 		end
# 		set_color normal
# 	else
# 		set_color $fish_prompt_dim
# 		printf "λ"
# 	end
# 
# 	set_color $fish_prompt_normal
# 	printf " "
# end
