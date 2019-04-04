#!/bin/bash

if [ -f ~/.gitlist ]; then
	repos=`cat ~/.gitlist`
	for path in $repos
	do
		pushd $path
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
