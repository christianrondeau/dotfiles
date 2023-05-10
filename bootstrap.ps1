#Requires -RunAsAdministrator

Set-StrictMode -version Latest

# Functions

function Write-Error([string]$message) {
    [Console]::ForegroundColor = 'red'
    [Console]::Error.WriteLine($message)
    [Console]::ResetColor()
}

function Write-Warn([string]$message) {
    [Console]::ForegroundColor = 'yellow'
    [Console]::Error.WriteLine($message)
    [Console]::ResetColor()
}

function StowFile([String]$link, [String]$target) {
	$file = Get-Item $link -ErrorAction SilentlyContinue

	if($file) {
		if ($file.LinkType -ne "SymbolicLink") {
			Write-Error "$($file.FullName) already exists and is not a symbolic link"
			return
		} elseif ($file.Target -ne $target) {
			Write-Error "$($file.FullName) already exists and points to '$($file.Target)', it should point to '$target'"
			return
		} else {
			Write-Verbose "$($file.FullName) already linked"
			return
		}
	} else {
	$folder = Split-Path $link
		if(-not (Test-Path $folder)) {
			Write-Verbose "Creating folder $folder"
			New-Item -Type Directory -Path $folder
		}
	}
	
	Write-Verbose "Creating link $link to $target"
	(New-Item -Path $link -ItemType SymbolicLink -Value $target -ErrorAction Continue).Target
}

function Stow([String]$package, [String]$target) {
	if(-not $target) {
		Write-Error "Could not define the target link folder of $package"
	}

	ls $DotFilesPath\$package | % {
		if(-not $_.PSIsContainer) {
			StowFile (Join-Path -Path $target -ChildPath $_.Name) $_.FullName
		}
	}
}

function ChocoInstall([String]$package) {
	if(-not ((choco list $package --exact --local-only --limitoutput) -like "$package*")) {
		Write-Verbose "Installing package $package"
		choco install $package -y
	} else {
		Write-Verbose "Package $package already installed"
	}
}

function DownloadFile([string]$url, [string]$target, [string]$hash) {
		if(Test-Path $target) {
			Write-Verbose "$target already downloaded"
		} else {
			Write-Verbose "Downloading $url to $target"
			try {
				(New-Object System.Net.WebClient).DownloadFile($url, $target)
			} catch {
				Write-Error $_
			}
			$targethash = Get-FileHash $target -Algorithm "SHA256"

			$diff = 0
			Compare-Object -Referenceobject $hash -Differenceobject $targethash.Hash | % { If ($_.Sideindicator -ne " ==") { $diff += 1 } }

			if ($diff -ne 0) {
				Write-Error "Downloaded file '$target' from url '$url' does not match expected hash!`nExpected: $hash`nActual  : $($targethash.Hash)"
			}
		}
}

function SetEnvVariable([string]$target, [string]$name, [string]$value) {
	$existing = [Environment]::GetEnvironmentVariable($name,$target)
	if($existing) {
		Write-Verbose "Environment variable $name already set to '$existing'"
	} else {
		Write-Verbose "Adding the $name environment variable to '$value'"
		[Environment]::SetEnvironmentVariable($name, $value, $target)
	}
}

# Sanity Check

if(-not [environment]::Is64BitOperatingSystem) {
	Write-Error "Only 64 bit Windows is supported"
	exit
}

if(-not $env:HOME) {
	$env:HOME = "$($env:HOMEDRIVE)$($env:HOMEPATH)"
}

# Bootstrap

$DotFilesPath = Split-Path $MyInvocation.MyCommand.Path
pushd $DotFilesPath
try {

	# PowerShell
	if($Level -ge $LevelMinimal) {
		StowFile $Global:PROFILE (Get-Item "powershell\Microsoft.PowerShell_profile.ps1").FullName
	}

	# WSL
	if($Level -ge $LevelBasic) {
		StowFile "$env:HOME\.wslconfig" (Get-Item "wsl\.wslconfig").FullName
	}

	# Git
	if($Level -ge $LevelMinimal) {
		ChocoInstall git
	}

	# SilverSearcher (ag)
	if($Level -ge $LevelBasic) {
		ChocoInstall ag
	}

	# Rider / Idea
	if($Level -ge $LevelFull) {
		StowFile "$env:HOME\.ideavimrc" (Get-Item "idea\.ideavimrc").FullName
	}

	# PowerShell Modules
	if($Level -ge $LevelBasic) {
		if(!(Get-Command z -ErrorAction SilentlyContinue)) {
			Install-Module z -AllowClobber -Scope CurrentUser -Force
		}

		if(!(Get-Module posh-git)) {
			Install-Module posh-git -Scope CurrentUser -Force
		}
	}

	# VS Code
	if($Level -ge $LevelBasic) {
		ChocoInstall vscode
		StowFile $env:APPDATA\Code\User\settings.json (Get-Item "vscode\settings.json").FullName
		StowFile $env:APPDATA\Code\User\keybindings.json (Get-Item "vscode\keybindings.json").FullName
	}
	
	# Common Tools
	ChocoInstall GoogleChrome
	ChocoInstall 7zip
	ChocoInstall curl
	ChocoInstall gnuwin32-coreutils.install
	ChocoInstall procexp
	ChocoInstall hackfont
	ChocoInstall kdiff3
	ChocoInstall gitextensions
	ChocoInstall paint.net
	ChocoInstall sharpkeys
	ChocoInstall nodejs-lts
	ChocoInstall slack
} finally {
	popd
}

# TODO:
# * Install sharpkeys CapsLock
