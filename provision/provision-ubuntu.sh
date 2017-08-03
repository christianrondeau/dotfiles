#!/bin/sh

# Install git
if ! type "git" > /dev/null 2>&1; then
  sudo apt-get update; sudo apt-get install git -y;
fi

# Go to the home folder
if [ -z "$HOME" ]; then
  echo "No home directory";
  exit 1;
fi
cd $HOME

# Acquire dotfiles
DOTFILES="$HOME/dotfiles"
if [ -d "$DOTFILES" ]; then
  cd $DOTFILES && git pull --ff-only;
else
  git clone https://github.com/christianrondeau/dotfiles.git;
fi

# Setup dotfiles
cd $DOTFILES
./bootstrap.sh -p minimal
