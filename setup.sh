#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root" 2>&1
	exit 1
fi

######################################### Prepare

apt-get update
apt-get upgrade -y

cd $(dirname "$0")

######################################### Bash

stow bash

######################################### Git

stow git
if [ hash vim 2>/dev/null ]; then
	apt-get install git -y
fi
#TODO: autocrlf = true on cygwin
#TODO: different email on different machines (env variables?)

######################################### Vim

stow vim
if [ hash vim 2>/dev/null ]; then
	apt-get install vim -y
fi

