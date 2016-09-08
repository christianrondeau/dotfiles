Instructions to get a pretty and functional VIM setup!

# Installation

Checkout this repo with submodule: `git clone https://github.com/christianrondeau/.vim ~/.vim --recursive`

## Common Setup
1. Start VIM and run `:PluginInstall`

## Windows-specific
1. For Windows: Create a `HOME` environment variable pointing to to `C:\Users\(username)`
2. Get [vimproc.vim](https://github.com/Shougo/vimproc.vim) assemblies from https://github.com/Shougo/vimproc.vim/releases
3. Create a symlink to the `vimrc` file": `mklink %HOME%\.vimrc %HOME%\.vim\vimrc`
  - For Visual Studio: `mklink %HOME%\.vsvimrc %HOME%\.vim\vsvimrc` (if using VsVim)
5. Install the Hack font *with PowerLine patch* using `choco install hackfont` or download it from: Download from https://github.com/powerline/fonts/tree/master/Hack
7. Install [grepwin](http://www.vim.org/scripts/script.php?script_id=311): `choco install gnuwin32-grep.install`

## Termux-specific
1. Build [vimproc.vim](https://github.com/Shougo/vimproc.vim) using `make -f make_android.mak` in the `~/vim/bundle/vimproc.vim` folder
2. Create a symlink to the `vimrc` file": `ln -s ~/git/dotfiles/.vim ~/.vim`
3. Install the Hack font: Buy https://play.google.com/store/apps/details?id=com.termux.styling&hl=en

# Usage

See [vimrc](https://github.com/christianrondeau/.vim/blob/master/vimrc) for all shortcuts and overrides
