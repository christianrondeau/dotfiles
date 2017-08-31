if test -d /usr/local/bin
	set PATH /usr/local/bin $PATH
end

if test -d ~/bin
	set PATH ~/bin $PATH
end

if test -d ~/dotfiles/bin
	set PATH ~/dotfiles/bin $PATH
end

if test -d ~/go/bin
	set PATH ~/go/bin $PATH
	set -x GOPATH ~/go
end

. "$HOME/.config/fish/aliases.fish"

set fish_greeting ""
fish_vi_key_bindings
