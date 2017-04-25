Instructions to get a pretty and functional VIM setup!

# Installation

Clone this repo: `git clone https://github.com/christianrondeau/.vim ~/dotfiles`

Run `~/bootstrap.sh -t basic`

## Profiles

* `minimal`: Just vim, core tools and some bash settings. Useful for docker machines. The default.
* `basic`: The common denominator of all development computers. Fish, tmux, vim plugins.
* `full: All tools for day-to-day use.

## Windows

* Create environment variables:
  * User `VIM` pointing to to `C:\Users\(username)\.vim`
  * System `VIMRUNTIME` pointing to to the Vim installation path
* Get [Python 2.7 x86](https://www.python.org/) using `choco install choco install python2-x86_32 -y`, or download it from https://www.python.org/downloads/
  * Set the `PYTHONHOME` environment variable to `C:\tools\python2-x86_32` if using Python 2.7.11 ([fixed in 2.7.12](https://github.com/vim/vim/issues/526))
* Get [vimproc.vim](https://github.com/Shougo/vimproc.vim) assemblies from https://github.com/Shougo/vimproc.vim/releases and put them in `$VIM/vimfiles/autoload/`
* Start VIM and run `:PlugInstall`

    Set-ExecutionPolicy RemoteSigned
    ~/bootstrap.ps1

## Linux

    sudo ~/bootstrap.sh -p basic

## Cygwin

    ~/bootstrap.sh -p basic

## Termux

Install the Hack font: https://play.google.com/store/apps/details?id=com.termux.styling&hl=en

    ~/termux-bootstrap.sh -p basic
