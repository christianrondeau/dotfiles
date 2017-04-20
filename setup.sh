#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root" 2>&1
	exit 1
fi

apt-get update
apt-get upgrade -y

cd $(dirname "$0")

#TODO: bash

stow git
if [ hash vim 2>/dev/null ]; then
	apt-get install git -y
fi
#TODO: autocrlf = true on cygwin

stow vim
if [ hash vim 2>/dev/null ]; then
	apt-get install vim -y
fi

