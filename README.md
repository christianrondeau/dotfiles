Get a nice and clean environment in a few seconds!

# Overview

I am using vim, git, and all sorts of tools on Windows as well as multiple Linux distributions, and I got tired of synchronizing all my configurations, so here you go: a cross-platform bootstrapping script (using `apt` on Linux and `choco` on Windows), and a set of nice symlinked prompts and configuration files (using `stow` on Linux and home-made symlinks on Windows).

Optimized for `PowerShell` on Windows and `Fish` on Linux, but it also provides settings for `bash`.

# Installation

Clone this repo: `git clone https://github.com/christianrondeau/.vim ~/dotfiles` and run `bootstrap`.

## Profiles

* `minimal`: Just vim, core tools and some bash settings. Useful for docker machines. The default.
* `basic`: The common denominator of all development computers. Fish, tmux, vim plugins.
* `full`: All tools for a day-to-day use computer.

## Windows

In a PowerShell window:

    Set-ExecutionPolicy RemoteSigned -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco install git putty -y
    git clone https://github.com/christianrondeau/.vim ~/dotfiles
    ~/bootstrap.ps1

## Linux

    sudo ~/bootstrap.sh -p basic

## Cygwin

    ~/bootstrap.sh -p basic

## Termux

Install the Hack font: https://play.google.com/store/apps/details?id=com.termux.styling&hl=en

    ~/termux-bootstrap.sh -p basic

## Gotchas

* If a config file exists, `bootstrap` will complain; you'll have to manually delete those files. This is by design.

# Tools Descriptions

## Windows

Some additional software can help make the experience more "keyboard-friendly" on Windows:

* [GoToWindow](https://github.com/christianrondeau/GoToWindow) allows searching when using <kbd>Win</kbd> + <kbd>Tab</kbd>
* [Launchy](https://www.launchy.net/) allows searching when using <kbd>Alt</kbd> + <kbd>Space</kbd> (instead of Start menu)
* [SharpKeys](https://github.com/randyrants/sharpkeys) allows remapping <kbd>CapsLock</kbd> to <kbd>Esc</kbd>
* [ConEmu](https://conemu.github.io/) allows split panes and shortcuts for all console needs!

## Linux

* [Fish](https://fishshell.com/) by default with `chsh -s /usr/bin/fish`
