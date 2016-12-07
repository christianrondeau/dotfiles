Instructions to get a pretty and functional VIM setup!

# Installation

Checkout this repo with submodule: `git clone https://github.com/christianrondeau/.vim ~/.vim --recursive`

## Windows-specific
1. Create environment variables:
  1. User `HOME` pointing to to `C:\Users\(username)`
  1. User `VIM` pointing to to `C:\Users\(username)\.vim`
  1. System `VIMRUNTIME` pointing to to the Vim installation path
1. Get [vimproc.vim](https://github.com/Shougo/vimproc.vim) assemblies from https://github.com/Shougo/vimproc.vim/releases (if using TypeScript)
1. Install the Hack font *with PowerLine patch* using `choco install hackfont` or download it from: Download from https://github.com/powerline/fonts/tree/master/Hack
1. Start VIM and run `:PluginInstall`

## Cygwin-specific
1. Do the setup for Windows; note that we'll use the Windows' Git, but the Cygwin's Vim
1. Create a symlink to the `vimrc` file": `ln -s ~/.vim/_vimrc ~/.vimrc`
1. Add the content of the [cygwin bashrc template](templates/.bashrc_cygwin) to `~/.bashrc` and [gitconfig template](templates/.gitconfig_cygwin) to `~/.gitconfig`
1. Start VIM and run `:PluginInstall`
1. Fix all line breaks issues it created: `cd ~/.vim/bundle; for D in */; do cd ~/.vim/bundle/$D; pwd; git rm -rf --cached .; git reset --hard HEAD; done` (note: this is horrible, but I could not yet find a way to checkout files correctly from `:PluginInstall`)

## Termux-specific
1. Build [vimproc.vim](https://github.com/Shougo/vimproc.vim) using `make -f make_android.mak` in the `~/vim/bundle/vimproc.vim` folder (if using TypeScript)
1. Create a symlink to the `vimrc` file": `ln -s ~/.vim/_vimrc ~/.vimrc`
1. Install the Hack font: Buy https://play.google.com/store/apps/details?id=com.termux.styling&hl=en

# Usage

See [vimrc](https://github.com/christianrondeau/.vim/blob/master/vimrc) for all shortcuts and overrides
