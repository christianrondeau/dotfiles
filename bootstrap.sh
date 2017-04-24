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

while getopts 'hi:v' flag; do
  case "${flag}" in
    i) install="${OPTARG}" ;;
		v) verbose='true' ;;
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
			exit 0
			;;
		*) error "Unexpected option ${flag}" ;;
  esac
done

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

if is_os "linux-android linux-gnu"; then
	install clang gcc
	install make
fi

install stow
install curl

############ bash

stow bash
if is_os "cygwin"; then
	stow bash-cygwin
elif is_os "linux-android"; then
	stow bash-termux
	stow termux
fi
source ~/.bash_profile

############ mintty

if is_os "msys"; then
	stow mintty
fi

############ git

stow git
install git

############ vim

stow vim
install vim
if [ ! -d ~/.vim/bundle/vimproc.vim ]; then
	log "Installing vim plugins"
	vim -c "PlugInstall vimproc.vim" -c "qa!"
	vim -c "silent VimProcInstall" -c "qa!"
	vim -c "PlugInstall" -c "qa!"
fi

############ neovim

stow neovim
# install neovim

############ tmux

if ! is_os "msys"; then
	stow tmux
	install tmux
fi

############ fish

if ! is_os "msys"; then
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
