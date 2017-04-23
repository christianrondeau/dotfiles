#!/bin/bash

shopt -s nullglob
shopt -s dotglob

if [[ "$0" != "/proc"* ]]; then
	cd $(dirname "$0")
fi

############ functions

is_installed() {
	hash $1 2> /dev/null;
}

install() {
	if [[ "$PKG" != "" ]] && ! is_installed $1; then
		$PKG install $1 $PKGARGS
	fi
}

is_os() {
	if [[ " $1 " =~ " $OSTYPE " ]]; then
		return 0
	else
		return 1
	fi
}

if is_os "msys"; then
	# stub stow
	function stow() {
		cd $1
		for f in *; do
			if ! [ -d "$f" ]; then
				ln -s -f `realpath $f` `realpath ~/$f`
			fi
		done
		cd ..
	}
fi

############ OS configuration

if is_os "linux-android"; then
	PKG=apt
	PKGARGS="-y"
elif is_os "linux-gnu"; then
	PKG=apt-get
	PKGARGS="-y"
elif is_os "cygwin"; then
	PKG=apt-cyg
	PKGARGS=""
elif is_os "msys"; then
	PKG=""
	PKGARGS=""
else
  echo "Unknown OS: '$OSTYPE'" 2>&1
	exit 1
fi

############ sanity check

if is_os "linux-gnu"; then
	# Require root
	if [ "$EUID" -ne 0 ]; then
		echo "Please run as root" 2>&1
		exit 2
	fi
fi

if is_os "cygwin" && ! is_installed "curl"; then
	echo "Please install curl using setup.exe" 2>&1
	exit 3
fi

############ prepare

if is_os "cygwin" && ! is_installed "apt-cyg"; then
	echo "Installing apt-cyg"
	curl https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg > ~/apt-cyg
	install ~/apt-cyg /bin
	rm ~/apt-cyg
fi

install stow
install curl

############ bash

stow bash
if is_os "cygwin"; then
	stow bash-cygwin
elif is_os "linux-android"; then
	stow bash-termux
	stow termux
fi
source ~/.bash_profile

############ mintty

if is_os "msys"; then
	stow mintty
fi

############ git

stow git
install git

############ vim

stow vim
install vim
vim -c "PlugInstall" -c "qa!"

############ neovim

stow neovim
# install neovim

############ tmux

if ! is_os "msys"; then
	stow tmux
	install tmux
fi

############ fish

if ! is_os "msys"; then
	stow fish
	install fish
fi

############ done

echo "Environment setup complete!"
