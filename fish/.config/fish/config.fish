if test -d /usr/local/bin
	set PATH /usr/local/bin $PATH
end

if test -d /usr/local/bin
	set PATH ~/bin $PATH
end

if test -d /usr/local/bin
	set PATH ~/dotfiles/bin $PATH
end

. "$HOME/.config/fish/prompt.fish"
. "$HOME/.config/fish/aliases.fish"

set fish_greeting ""
set -g __fish_vi_mode 1
fish_vi_key_bindings
