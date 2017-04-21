# Add ~/bin to the path
export PATH="$HOME/bin:$PATH";

# Source all dotfiles
for file in ~/.bash_{prompt,os,aliases}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Append to bash history instead of overwriting
shopt -s histappend;

# Autocorrect in cd
shopt -s cdspell;

# Ignore duplicate commands, ignore commands starting with a space
export HISTCONTROL=ignoreboth:erasedups

# Keep the last 5000 entries
export HISTSIZE=5000

# Bash 4 features
# * autocd: `**/folder` will enter `./foo/bar/folder`
# * Recursive globbing:  `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Autocomplete
if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# SSH Autocomplete
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

