#!/bin/bash

if [[ "$0" != "/proc"* ]]; then
	cd $(dirname "$0")
fi

source bootstrap-scripts/functions.sh

############ Update packages

if $(hash termux-info 2>/dev/null); then # termux
	echo 'Updating Termux packages'
	apt update && apt upgrade -y
elif $(hash apt-get 2>/dev/null); then # ubuntu
	echo 'Updating apt packages'
	sudo apt-get update && sudo apt-get upgrade -y
elif $(hash apk 2>/dev/null); then # alpine
	echo 'Updating apk packages'
	sudo apk update && sudo apk upgrade -y
fi

############ Update dotfiles

if is_installed git; then
	echo 'Updating dotfiles'
	git pull --ff-only
fi

############ Update fisherman plugins

if is_installed fish; then
	echo 'Updating fish plugins'
	fish -c "fisher"
fi

############ Update vim plugins

if is_installed vim; then
	echo 'Updating vim plugins'
	vim -c 'PlugUpdate' -c 'qa!'
fi

############ Update git repos

if [ -f ~/.gitlist ]; then
	repos=`cat ~/.gitlist`
	for path in $repos
	do
		fullpath=${path/\~/$HOME}
		pushd $fullpath
		git pull --ff-only
		if [ -z "$(git status --porcelain)" ]; then 
			if [ -f ./package-lock.json ]; then
				npm install
				git checkout package-lock.json --force
			elif  [ -f ./yarn.lock ]; then
				yarn install
				git checkout yarn.lock --force
			fi
		fi
		popd
	done
fi

