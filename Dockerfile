FROM alpine:latest

MAINTAINER Christian Rondeau <christian.rondeau@gmail.com>

# Basic packages to get started
RUN apk update && apk add --update alpine-sdk git neovim fish bc bash ncurses

# Map our current dotfiles folder
ADD . /home/dotfiles

# Install the dotfiles
ENV HOME /home
WORKDIR /home/dotfiles
RUN bash ./bootstrap.sh -p basic

# Get ready for development
WORKDIR /home
