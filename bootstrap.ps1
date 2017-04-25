#Requires -RunAsAdministrator
Set-StrictMode -version Latest

# Functions

function StowFile([string]$link, [string]$target) {
	$file = Get-Item $link -ErrorAction SilentlyContinue

	if($file) {
		if ($file.LinkType -ne "SymbolicLink") {
			throw "$($file.Name) already exists and is not a symbolic link"
		}
		if ($file.Target -ne $target) {
			throw "$($file.Name) already exists and points to '$($file.Target)', it should point to '$target'"
		} else {
			echo "$($file.Name) already linked"
			return
		}
	}

	echo "Creating link"
	(New-Item -Path $link -ItemType SymbolicLink -Value $target).Target
}

function Stow([string]$package, [string]$target) {
	ls $DotFilesPath\$package | % {
		if(-not $_.PSIsContainer) {
			StowFile (Join-Path -Path $target -ChildPath $_.Name) $_.FullName
		}
	}
}

# Bootstrap

$DotFilesPath = Split-Path $MyInvocation.MyCommand.Path
pushd $DotFilesPath
try {
	Stow powershell (Split-Path -Path $PROFILE)
	Stow conemu ($env:APPDATA)
} finally {
	popd
}

choco install ag hackfont vim poshgit clink far conemu everything curl 7zip fiddler4 git gitextensions GoogleChrome greenshot launchy paint.net putty sharpkeys -y

# TODO:
# * Setup environment variables
# * Check chocolatey
# * Profiles
# * Download vimproc, fullscreen
# * Install sharpkeys CapsLock
# * Setup putty at startup
# * configure launchy with chocolatey
# * configure conemu ConEmu.xml to APPDATA one
# * Configure python for Vim (can we use python 3 now?)
# * Group by profiles, like the .sh version
# * Add other softwre, like Skype
