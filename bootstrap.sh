#!/bin/bash

shopt -s nullglob
shopt -s dotglob

if [[ "$0" != "/proc"* ]]; then
	cd $(dirname "$0")
fi

source bootstrap-scripts/functions.sh

############ arguments

verbose='false'
force='false'
install=''
profile='minimal'

while getopts 'hfvi:p:' flag; do
  case "${flag}" in
    i) install="${OPTARG}" ;;
		v) verbose='true' ;;
		f) force='true' ;;
		p) profile="${OPTARG}" ;;
		h)
			echo "Christian Rondeau's cross-platfrom environment bootstrap script"
			echo
			echo "Usage:"
			if is_os "linux-gnu"; then
				printf "  sudo ./bootstrap.sh"
			elif is_os "linux-android [-hv] [-i \"packages\"]"; then
				printf "  ./termux-bootstrap.sh"
			else
				printf "  ./bootstrap.sh"
			fi
			echo " [-hvf] [-i:\"packages\"]"
			echo
			echo "Arguments:"
			echo
			echo "  -h             Help"
			echo "  -v             Verbose"
			echo "  -f             Force"
			echo "  -i \"pkg1 pkg2\" Install extra packages"
			echo "  -p \"profile\"   Selects which packages to install"
			echo
			echo "Profiles:"
			echo
			echo "  minimal  Just enough to work; symlinks, vim... [default]"
			echo "  basic    Basic setup, vim plugins, clang, fish, tmux, ag..."
			echo "  full     Full environment; node, etc."
			exit 0
			;;
		*)
			echo "Unexpected option -${flag}"
			exit 3
		 	;;
  esac
done

LEVEL_MINIMAL=1
LEVEL_BASIC=10
LEVEL_FULL=100
LEVEL=$LEVEL_MINIMAL

case "${profile}" in
	minimal) LEVEL=$LEVEL_MINIMAL ;;
	basic) LEVEL=$LEVEL_BASIC ;;
	full) LEVEL=$LEVEL_FULL ;;
	*) error "Unexpected profile ${profile}" ;;
esac

log "Profile: $profile ($LEVEL)"

############ OS configuration

if is_os "linux-android"; then
	PKG=apt
	PKGARGS="-y"
elif is_os "linux-gnu"; then
	PKG="sudo apt-get"
	PKGARGS="-y"
elif is_os "cygwin"; then
	PKG=apt-cyg
	PKGARGS=""
elif is_os "msys"; then
	PKG=""
	PKGARGS=""
else
  echo "Unknown OS: '$OSTYPE'" 2>&1
	exit 1
fi

log "os: $OSTYPE"
log "install command: $PKG install ... $PKGARGS"

############ sanity check

if is_os "linux-gnu"; then
	# Require root
	if [ "$EUID" -eq 0 ] && ! is_force; then
		echo "Do not run as root, to avoid folders being owned by root. Use -f to force." 2>&1
		exit 2
	fi

	# Wait for dpkg to complete pending tasks
	if pgrep -x dpkg > /dev/null; then
		echo "Please wait for dpkg to finish" 2>&1
		exit 2
	fi
fi

if is_os "cygwin" && ! is_installed "curl"; then
	echo "Please install curl using setup.exe" 2>&1
	exit 3
fi

log "checks: ok"

############ prepare

if is_os "cygwin" && ! is_installed "apt-cyg"; then
	echo "Installing apt-cyg"
	curl https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg > ~/apt-cyg
	install ~/apt-cyg /bin
	rm ~/apt-cyg
fi

if is_os "linux-android linux-gnu" && has_level $LEVEL_BASIC; then
	install clang gcc
	install make
fi

install stow
install curl

############ bash

if has_level $LEVEL_MINIMAL; then
	stow bash
	if is_os "cygwin"; then
		stow bash-cygwin
	elif is_os "linux-android"; then
		stow bash-termux
		stow termux
	fi
fi

############ mintty

if has_level $LEVEL_MINIMAL && is_os "msys"; then
	stow mintty
fi

############ git

if has_level $LEVEL_MINIMAL; then
	stow git
	install git
fi

############ vim

if has_level $LEVEL_MINIMAL; then
	stow vim --no-folding
	install vim
fi

if has_level $LEVEL_BASIC && [ ! -d ~/.vim/bundle/vimproc.vim ]; then
	log "Installing vim plugins"
	vim -c "PlugInstall vimproc.vim" -c "qa!"
	vim -c "silent VimProcInstall" -c "qa!"
	vim -c "PlugInstall" -c "qa!"
fi

############ silversearcher-ag

if has_level $LEVEL_MINIMAL; then
	install silversearcher-ag ag
fi

############ neovim

if has_level $LEVEL_FULL; then
	stow neovim --no-folding
	install neovim nvim
fi

############ tmux

if has_level $LEVEL_BASIC && ! is_os "msys"; then
	stow tmux
	install tmux
fi

############ fish

if has_level $LEVEL_BASIC && ! is_os "msys"; then
	stow fish --no-folding
	if ! is_installed fish; then
		if is_os "linux-gnu"; then
			sudo apt-add-repository ppa:fish-shell/release-2 -y
			sudo apt-get update
			sudo apt-get install fish -y
		else
			install fish
		fi
	fi

	current_shell=$(getent passwd $LOGNAME | cut -d: -f7)
	if [ ! $current_shell = "/usr/bin/fish" ]; then
		echo "Your current shell is $current_shell. To use fish, run chsh -s /usr/bin/fish"
	fi

	if has_level $LEVEL_FULL && [ ! -e ~/.config/fish/functions/fisher.fish ]; then
		log "Installing fisher"
		curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
		fisher
	else
		log "fisher already installed"
	fi
fi

############ hack font

if has_level $LEVEL_FULL && is_os "linux-gnu"; then
	$PKG install fonts-hack-ttf $PKGARGS
fi

############ other

if [[ "$install" != "" ]]; then
	log "Installing extra packages $install"
	install $install
fi

