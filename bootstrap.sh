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
			echo "  dev      Experimental things"
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
LEVEL_DEV=1000
LEVEL=$LEVEL_MINIMAL

case "${profile}" in
	minimal) LEVEL=$LEVEL_MINIMAL ;;
	basic) LEVEL=$LEVEL_BASIC ;;
	full) LEVEL=$LEVEL_FULL ;;
	dev) LEVEL=$LEVEL_DEV ;;
	*) error "Unexpected profile ${profile}" ;;
esac

log "Profile: $profile ($LEVEL)"

############ OS configuration

if is_os "linux-android"; then
	PKGCMD="apt install"
	PKGARGS="-y"
elif is_os "linux-gnu"; then
	PKGCMD="sudo apt-get install"
	PKGARGS="-y"
elif is_os "linux-alpine"; then
	PKGCMD="sudo apk add"
	PKGARGS=""
elif is_os "cygwin"; then
	PKGCMD="apt-cyg install"
	PKGARGS=""
elif is_os "msys"; then
	PKGCMD=""
	PKGARGS=""
else
  echo "Unknown OS: '$OSTYPE'" 2>&1
	exit 1
fi

log "os: $OSTYPE"
log "install command: $PKGCMD {package} $PKGARGS"

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
	install clang
	install make
fi

install stow
install curl

############ bash

if has_level $LEVEL_MINIMAL; then
	stow bash
	if is_os "cygwin"; then
		stow bash-cygwin --no-folding
	elif is_os "linux-android"; then
		stow bash-termux --no-folding
		stow termux --no-folding
	fi
fi

############ mintty

if has_level $LEVEL_BASIC && is_os "msys"; then
	stow mintty
fi

############ git

if has_level $LEVEL_MINIMAL; then
	stow git --no-folding
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

if has_level $LEVEL_BASIC; then
	if ! is_installed ag && is_os "linux-alpine"; then
		sudo apk --update add automake autoconf make g++ pcre-dev xz-dev
		if [ $(git clone https://github.com/ggreer/the_silver_searcher.git ~/the_silver_searcher) ]; then
			pushd ~/the_silver_searcher && 
			./build.sh && ln -s ~/the_silver_searcher/ag ~/bin/ag
			popd
		fi
	else
		install silversearcher-ag ag
	fi
fi

############ fzf

if has_level $LEVEL_BASIC; then
	if ! is_installed fzf; then
		if is_os "linux-android"; then
			install fzf
		elif is_os "linux-gnu"; then
			log "Installing fzf"
			git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
			~/.fzf/install
		fi
	else
		log "fzf already installed"
	fi
fi

############ neovim

if has_level $LEVEL_FULL; then
	stow neovim --no-folding
	if ! is_installed nvim; then
		if is_os "linux-gnu"; then
			sudo add-apt-repository ppa:neovim-ppa/stable
			sudo apt-get update
			sudo apt-get install neovim -y
		else
			install neovim nvim
		fi
	fi
fi

############ tmux

if has_level $LEVEL_BASIC && ! is_os "msys"; then
	stow tmux --no-folding
	install tmux
fi

############ mosh

if has_level $LEVEL_FULL && ! is_os "msys"; then
	install mosh
fi

############ ranger

if has_level $LEVEL_DEV && ! is_os "msys"; then
	stow ranger --no-folding
	install ranger
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
			if is_os "linux-alpine"; then
				install ncurses tput
			fi
			install fish
		fi
	fi

	if is_os "linux-gnu"; then
		current_shell=$(getent passwd $LOGNAME | cut -d: -f7)
		if [ ! $current_shell = "/usr/bin/fish" ]; then
			echo "Your current shell is $current_shell. To use fish, run chsh -s /usr/bin/fish"
		fi
	fi

	if has_level $LEVEL_FULL && [ ! -e ~/.config/fish/functions/fisher.fish ]; then
		log "Installing fisher"
		curl git.io/fisher -L > ~/.config/fish/functions/fisher.fish
		source ~/.config/fish/functions/fisher.fish
		fisher
	else
		log "fisher already installed"
	fi
fi

############ lastpass-cli

if has_level $LEVEL_FULL && ! is_installed lpass; then
	git clone git@github.com:lastpass/lastpass-cli.git ~/.lastpass-cli
	pushd ~/.lastpass-cli
	cmake . && make && sudo make install
	popd
fi

############ hack font

if has_level $LEVEL_FULL && is_os "linux-gnu"; then
	$PKGCMD fonts-hack-ttf $PKGARGS
fi

############ go

if has_level $LEVEL_DEV && ! is_os "msys"; then
	install golang go
fi

############ i3

# /usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
# apt install ./keyring.deb
# echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list
# apt update
# apt install i3

############ other

if [[ "$install" != "" ]]; then
	log "Installing extra packages $install"
	install $install
fi

