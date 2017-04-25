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
} finally {
	popd
}

choco install silversearcher-ag hackfont vim poshgit -y

# TODO:
# * Setup environment variables
# * Check chocolatey
# * Profiles
# * Download vimproc, fullscreen
