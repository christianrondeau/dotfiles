FROM alpine:latest

MAINTAINER Christian Rondeau <christian.rondeau@gmail.com>

# Basic packages to get started
RUN apk update && apk add --update alpine-sdk git neovim fish

# Map our current dotfiles folder
ADD . /home/dotfiles

