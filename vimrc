" Vundle begin
set nocompatible              " be iMproved, required
filetype on                  " required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'pangloss/vim-javascript'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required
" set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME
" set number
syntax on
colorscheme slate
set relativenumber
let mapleader = "\<Space>"
set encoding=utf-8
set tabstop=2
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
