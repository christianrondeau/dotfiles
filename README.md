Get a nice and clean environment in a few seconds!

# Overview

I am using vim, git, and all sorts of tools on Windows as well as multiple Linux distributions, and I got tired of synchronizing all my configurations, so here you go: a cross-platform bootstrapping script (using `apt` on Linux and `choco` on Windows), and a set of nice symlinked prompts and configuration files (using `stow` on Linux and home-made symlinks on Windows).

Optimized for `PowerShell` on Windows and `Fish` on Linux, but it also provides settings for `bash`.

# Installation

Clone this repo: `git clone https://github.com/christianrondeau/dotfiles ~/dotfiles` and run `bootstrap`.

## Profiles

* `minimal`: Just vim, core tools and some bash settings. Useful for docker machines. The default.
* `basic`: The common denominator of all development computers. Fish, tmux, vim plugins.
* `full`: All tools for a day-to-day use computer.

## Windows

In a PowerShell window:

    cd ~/
    Set-ExecutionPolicy RemoteSigned -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco install git putty -y
    git clone https://github.com/christianrondeau/dotfiles $env:HOMEDRIVE$env:HOMEPATH/dotfiles
    cd dotfiles
    ~/bootstrap.ps1
    
* Now, create a SSH key with puttygen in `~/.ssh/id_rsa`, and add a startup link in `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup` to `C:\ProgramData\chocolatey\lib\putty.portable\tools\pageant.exe "%HOMEDRIVE%%HOMEPATH%\.ssh\id_rsa.ppk"`
* Add an environment variable `GIT_SSH` pointing to `C:\ProgramData\chocolatey\lib\putty.portable\tools\plink.exe`
* Add `C:\Program Files\Git\usr\bin\` to the `PATH`

## Linux (Ubuntu/Mint)

    cd ~/
    sudo apt-get update && sudo apt-get upgrade
    ssh-keygen -t rsa -C $(read -p "Email: " emailvar && echo $emailvar)
    sudo apt-get install git -y
    git clone git@github.com:christianrondeau/dotfiles.git
    cd dotfiles
    ./bootstrap.sh -p basic

### Termux

Same instructions as linux, but instead run `./termux-bootstrap.sh`

Install the Hack font: https://play.google.com/store/apps/details?id=com.termux.styling&hl=en

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
