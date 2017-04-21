#!/bin/bash

############ Functions

is_installed() {
	hash $1 2> /dev/null;
}

install() {
	if ! is_installed $1; then
		$PKG install $1 $PKGARGS
	fi
}

is_os() {
	[[ "$OSTYPE" == "$1" ]];
}

############ Identify OS

if is_os "linux-android"; then
	PKG=apt
	PKGARGS="-y"
elif is_os "linux-gnu"; then
	PKG=apt-get
	PKGARGS="-y"
elif is_os "cygwin"; then
	PKG=apt-cyg
	PKGARGS=""
else
  echo "Unknown OS: '$OSTYPE'" 2>&1
	exit 1
fi

############ Sanity check

if is_os "linux-gnu"; then
	# Require root
	if [ "$EUID" -ne 0 ]; then
		echo "Please run as root" 2>&1
		exit 2
	fi
fi

############ Prepare

if is_os "cygwin"; then
	if ! is_installed "curl"; then
		echo "Please install curl using setup.exe" 2>&1
		exit 3
	fi
	if ! is_installed "apt-cyg"; then
		echo "Installing apt-cyg"
		curl https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg > ~/apt-cyg
		install ~/apt-cyg /bin
		rm ~/apt-cyg
	fi
fi

if [[ $0 != "/proc"* ]]; then
	cd $(dirname "$0")
fi

install stow
install curl

############ Bash

stow bash
if is_os "cygwin"; then
	stow bash-cygwin
elif is_os "linux-android"; then
	stow bash-termux
	stow termux
fi
source ~/.bash_profile

############ Git

stow git
install git

############ Vim

stow vim
install vim

############ Tmux

stow tmux
install tmux

############ Fish

stow fish
install fish

############ Complete

echo "Environment setup complete!"
