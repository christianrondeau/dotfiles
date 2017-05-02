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
		log "$pkgname already installed"
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
