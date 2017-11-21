#Requires -RunAsAdministrator

Set-StrictMode -version Latest

if ($env:GITPATH) {
	$repos = @(Get-ChildItem -Path $env:GITPATH | ?{ $_.PSIsContainer })
	echo "Updating $($repos.Length) repositories"
	foreach ($repo in $repos) {
		echo "updating $($repo.Name)"
		pushd $repo.FullName
		try {
			git pull --ff-only
		} finally {
			popd
		}
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
