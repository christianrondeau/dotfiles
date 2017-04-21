function fish_prompt
	set -l git_branch (git branch ^/dev/null | sed -n '/\* /s///p')
	echo -n (hostname)':'(prompt_pwd)' ['"$git_branch"']'
	printf '\nλ '
end
