#Requires -RunAsAdministrator
[CmdletBinding()]
Param(
    [Parameter()]
    [ValidateSet("Minimal","Basic","Full")]
    $Profile
)

Set-StrictMode -version Latest
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

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

function Install([String]$package) {
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

# Arguments

$LevelMinimal = 1
$LevelBasic = 10
$LevelFull = 100
$Level = 0

switch($Profile) {
	"Minimal" { $Level = $LevelMinimal }
	"Basic" { $Level = $LevelBasic }
	"Full" { $Level = $LevelFull }
}

Write-Verbose "Profile: $Profile ($Level)"

# Sanity Check

if(-not [environment]::Is64BitOperatingSystem) {
	Write-Error "Only 64 bit Windows is supported"
	exit
}

if(-not $env:HOME) {
	$env:HOME = "$($env:HOMEDRIVE)$($env:HOMEPATH)"
}

# Prepare

# TODO:
# * Chocolatey
# * Setup environment variables
# * Install Powershell Core, Winget https://dev.to/smashse/wsl-chocolatey-powershell-winget-1d6p

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

	# Windows Updates with PowerShell
	if($Level -ge $LevelFull -and -not (Get-Command -Module PSWindowsUpdate) ) {
		Install-Module PSWindowsUpdate -Confirm:$false
		Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d
	}

	# Windows Terminal
	if($Level -ge $LevelFull) {
		StowFile "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" (Get-Item ".\windowsterminal\settings.json").FullName
		Install conemu
	}

	# ConEmu
	if($Level -ge $LevelFull) {
		Stow conemu $env:APPDATA
		Install conemu
	}

	# Git
	if($Level -ge $LevelMinimal) {
		if(!(Test-Path $env:HOME/.gitconfig)) {
			Copy-Item ./git/.gitconfig $env:HOME/.gitconfig
		} else {
			Write-Warn ".gitconfig already exists (cannot symlink since it's not supported in GitExtensions)"
		}
		Install git
	}

	# SilverSearcher (ag)
	if($Level -ge $LevelBasic) {
		Install ag
	}

	# Fzf
	if($Level -ge $LevelBasic) {
		Install fzf
	}

	# Vim
	if($Level -ge $LevelFull) {
		StowFile "$env:HOME\.vim" (Get-Item "vim\.vim").FullName
		StowFile "$env:HOME\_vimrc" (Get-Item "vim\.vimrc").FullName
		StowFile "$env:HOME\_vsvimrc" (Get-Item "vim\.vsvimrc").FullName

		SetEnvVariable "User" "VIM" (Get-Item "$env:HOME\.vim").FullName

		Install python3
		Install vim-tux

		if((Get-Command vim -ErrorAction SilentlyContinue)) {
			SetEnvVariable "Machine" "VIMRUNTIME" (Split-Path (Get-Command vim).Path)
		}

		# Vim Plugins
		DownloadFile "https://github.com/Shougo/vimproc.vim/releases/download/ver.9.3/vimproc_win64.dll" "$env:HOME\.vim\vimfiles\autoload\vimproc_win64.dll" "B6E71408676B095D91BE5376B25C8106DEDD9A4AF76A73B2729B4D2E1368874F"
		DownloadFile "https://github.com/derekmcloughlin/gvimfullscreen_win32/raw/master/gvimfullscreen_64.dll" "$env:VIMRUNTIME\gvimfullscreen_64.dll" "1C83747B67ED73C05D44C1AF8222A860BC5A48B56BF54CD6E21465A2DEB78456"

		if(-not (Get-Command vim -ErrorAction SilentlyContinue)) {
			Write-Verbose "Vim is not in the PATH. Cannot install plugins."
		} elseif(Test-Path "$env:HOME\.vim\bundle\vimproc.vim") {
			Write-Verbose "Vim plugins already installed. Update with 'vim -c `"PlugUpdate`" -c `"qa!`"'"
		} else {
			Write-Verbose "Installing Vim plugins"
			vim -c "PlugInstall vimproc.vim" -c "qa!"
			vim -c "silent VimProcInstall" -c "qa!"
			vim -c "PlugInstall" -c "qa!"
		}
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

		if(!(Get-Module PSFzf)) {
			Install-Module -Name PSFzf -Force
		}
	}

	# VS Code
	if($Level -ge $LevelBasic) {
		Install vscode
		StowFile $env:APPDATA\Code\User\settings.json (Get-Item "vscode\settings.json").FullName
		StowFile $env:APPDATA\Code\User\keybindings.json (Get-Item "vscode\keybindings.json").FullName
	}
	
	# Common Tools
	if($Level -ge $LevelBasic) {
		Install GoogleChrome
		Install 7zip
		Install curl
		Install gnuwin32-coreutils.install
		Install procexp
	}
	
	# Full Setup
	if($Level -ge $LevelFull) {
		Install Firefox
		Install hackfont
		Install fiddler
		Install kdiff3
		Install gitextensions
		Install greenshot
		Install paint.net
		Install sharpkeys
		Install nodejs-lts
		Install slack
		Install everything
	}

	# SSH Keys 
	if($Level -ge $LevelBasic) {
		# TODO: Generate a id_rsa if none exist
	}
	
} finally {
	popd
}

# TODO:
# * Install sharpkeys CapsLock
# * Setup putty at startup
