#Requires -RunAsAdministrator

Set-StrictMode -version Latest

if (Test-Path ~/.gitlist) {
	cat ~/.gitlist | ? {
		pushd $_
		pwd
		git pull --ff-only
		if(-not (git status --porcelain)) {
			if (Test-Path package-lock.json) {
				npm install
				git checkout package-lock.json --force
			}
			elseif (Test-Path yarn.lock) {
				yarn install
				git checkout yarn.lock --force
			}
		}
		popd
	}
}

$DotFilesPath = Split-Path $MyInvocation.MyCommand.Path
pushd $DotFilesPath
try {
	# Dotfiles
	git pull --ff-only

	# Chocolatey
	cup all -y

	# Vim Plugins
	gvim -c "PlugUpdate" -c "qa!"

	# Windows Update
	if(Get-Command -Module PSWindowsUpdate) {
		Get-WUInstall –MicrosoftUpdate –AcceptAll # –AutoReboot
	}
} finally {
	popd
}
