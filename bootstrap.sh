#!/bin/bash

shopt -s nullglob
shopt -s dotglob

if [[ "$0" != "/proc"* ]]; then
	cd $(dirname "$0")
fi

############ functions

log() {
	if [[ "$verbose" == "true" ]]; then
		echo $1
	fi
}

is_installed() {
	hash $1 2> /dev/null;
}

has_level() {
	if [ "$1" -le "$LEVEL" ]; then
		return 0
	else
		return 1
	fi
}

install() {
	if [[ "$PKG" == "" ]]; then
		return 1
	fi

	pkgname=$1
	execname=$2
	if [[ "$execname" == "" ]]; then
		execname="$pkgname"
	fi

	if ! is_installed $execname; then
		log "Could not find $execname, installing $pkgname"
		$PKG install $pkgname $PKGARGS
		return 0
	else
		log "$pkgname already installed or no package manager"
		return 1
	fi
}

is_os() {
	if [[ " $1 " =~ " $OSTYPE " ]]; then
		return 0
	else
		return 1
	fi
}

if is_os "msys"; then
	# stub stow
	function stow() {
		cd $1
		for f in *; do
			if ! [ -d "$f" ]; then
				ln -s -f `realpath $f` `realpath ~/$f`
			fi
		done
		cd ..
	}
fi

############ arguments

verbose='false'
install=''
profile='minimal'

while getopts 'hi:vp:' flag; do
  case "${flag}" in
    i) install="${OPTARG}" ;;
		v) verbose='true' ;;
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
			echo " [-hv] [-i:\"packages\"]"
			echo
			echo "Arguments:"
			echo
			echo "  -h             Help"
			echo "  -v             Verbose"
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
		*) error "Unexpected option ${flag}" ;;
  esac
done

LEVEL_MINIMAL=1
LEVEL_BASIC=10
LEVEL_FULL=100
LEVEL=$LEVEL_MINIMAL

case "${profile}" in
	minimal) LEVEL=$LEVEL_MINIMAL ;;
	basic) LEVEL=$LEVEL_BASIC ;;
	full) LEVEL=LEVEL_FULL ;;
	*) error "Unexpected profile ${profile}" ;;
esac

log "Profile: $profile ($LEVEL)"

############ OS configuration

if is_os "linux-android"; then
	PKG=apt
	PKGARGS="-y"
elif is_os "linux-gnu"; then
	PKG=apt-get
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

log "os: $OSTYPE, package script: $PKG (NAME) $PKGARGS"

############ sanity check

if is_os "linux-gnu"; then
	# Require root
	if [ "$EUID" -ne 0 ]; then
		echo "Please run as root" 2>&1
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
	stow vim
	install vim
fi

if has_level $LEVEL_BASIC && [ ! -d ~/.vim/bundle/vimproc.vim ]; then
	log "Installing vim plugins"
	vim -c "PlugInstall vimproc.vim" -c "qa!"
	vim -c "silent VimProcInstall" -c "qa!"
	vim -c "PlugInstall" -c "qa!"
fi

############ silversearcher-ag

if has_level $LEVEL_BASIC; then
	install silversearcher-ag ag
fi

############ neovim

if has_level $LEVEL_FULL; then
	stow neovim
	# install neovim
fi

############ tmux

if has_level $LEVEL_BASIC && ! is_os "msys"; then
	stow tmux
	install tmux
fi

############ fish

if has_level $LEVEL_BASIC && ! is_os "msys"; then
	stow fish
	install fish
fi

############ other

if [[ "$install" != "" ]]; then
	log "Installing extra packages $install"
	install $install
fi

############ done

echo "Environment setup complete!"
