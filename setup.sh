#!/bin/bash

if [[ "$OSTYPE" == "linux-android" ]]; then
	PKG=apt
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	PKG=apt-get
elif [[ "$OSTYPE" == "cygwin" ]]; then
	PKG=apt-cyg
else
  echo "Unknown OS: '$OSTYPE'" 2>&1
	exit 1
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# Require root
	if [ "$EUID" -ne 0 ]; then
		echo "Please run as root" 2>&1
		exit 2
	fi
fi


######################################### Prepare

$PKG update
$PKG upgrade -y

cd $(dirname "$0")

if [ hash stow 2>/dev/null ]; then
	$PKG install stow -y
fi

######################################### Bash

stow bash

######################################### Git

stow git
if [ hash vim 2>/dev/null ]; then
	$PKG install git -y
fi
#TODO: autocrlf = true on cygwin
#TODO: different email on different machines (env variables?)

######################################### Vim

stow vim
if [ hash vim 2>/dev/null ]; then
	$PKG install vim -y
fi

