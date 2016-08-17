" Vundle begin
set nocompatible              " be iMproved, required
filetype on                  " required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required
":PluginUpdate
"auto-approve removal
" set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME
set number
set autochdir
colorscheme slate
let mapleader = "\<Space>"
syntax on
set encoding=utf-8

