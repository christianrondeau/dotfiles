Instructions to get a pretty and functional VIM setup!

# Installation

Checkout this repo with submodule: `git clone https://github.com/christianrondeau/.vim ~/.vim --recursive`

## Common Setup
1. Start VIM and run `:PluginInstall`

## Windows-specific
1. Create environment variables:
  1. User `HOME` pointing to to `C:\Users\(username)`
  2. User `VIM` pointing to to `C:\Users\(username)\.vim`
  3. System `VIMRUNTIME` pointing to to the Vim installation path
2. Get [vimproc.vim](https://github.com/Shougo/vimproc.vim) assemblies from https://github.com/Shougo/vimproc.vim/releases (if using TypeScript)
3. Install the Hack font *with PowerLine patch* using `choco install hackfont` or download it from: Download from https://github.com/powerline/fonts/tree/master/Hack

## Termux-specific
1. Build [vimproc.vim](https://github.com/Shougo/vimproc.vim) using `make -f make_android.mak` in the `~/vim/bundle/vimproc.vim` folder (if using TypeScript)
2. Create a symlink to the `vimrc` file": `ln -s ~/.vim/_vimrc ~/.vimrc`
3. Install the Hack font: Buy https://play.google.com/store/apps/details?id=com.termux.styling&hl=en

# Usage

See [vimrc](https://github.com/christianrondeau/.vim/blob/master/vimrc) for all shortcuts and overrides
