" Vundle
set nocompatible
filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'pangloss/vim-javascript'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'ctrlpvim/ctrlp.vim'

" Vundle
call vundle#end()
filetype plugin indent on

" Custom Settings
syntax on
colorscheme slate
set relativenumber
set encoding=utf-8
set tabstop=2
set showcmd
set scrolloff=2

" Custom Key Mappings
inoremap <CR> <Esc>
let mapleader = "\<Space>"

" Shortcuts
nnoremap <leader>j :!jasmine<CR>
nnoremap <leader>w <C-W>w

" CTRLP Settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
