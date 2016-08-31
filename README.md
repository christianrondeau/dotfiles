Instructions

1. Checkout with submodule https://github.com/christianrondeau/.vim
2. Create a HOME environment variable to C:\Users\(username)
3. Start VIM and Run :PluginInstall
4. Build vimproc.vim (https://github.com/Shougo/vimproc.vim)
  - For Termux: `make -f make_android.mak`
  - For Windows: download the dll from https://github.com/Shougo/vimproc.vim/releases
5. Create a link to the vimrc file
  - For Termux: `ln -s ~/git/dotfiles/.vim ~/.vim`
  - For Windows: `mklink %HOME%\.vimrc %HOME%\.vim\vimrc`
  - For Visual Studio: `mklink %HOME%\.vsvimrc %HOME%\.vim\vsvimrc` (if using VsVim)
