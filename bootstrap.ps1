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

	echo "Creating link $link"
 New-Item -Path $link -ItemType SymbolicLink -Value $target
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
	Stow powershell (Get-Item $PROFILE).Directory
} finally {
	popd
}

# TODO:
# 3. Setup environment variables
# 4. Check if admin
# 5. Check chocolatey
# 6. Install packages
# 7. Install posh-git: `choco install poshgit`
# 8. Set ReadLine for CTRL+R
