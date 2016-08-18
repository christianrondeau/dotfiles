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
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Vundle
call vundle#end()
filetype plugin indent on

" Custom Settings
set rtp+=~/.vim/vimfiles
syntax on
if has("gui_running") 
	colors wombat
	set lines=40 columns=140
elseif stridx(&shell, 'cmd.exe') != -1
	colors industry
else
	colors wombat
endif

set relativenumber
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set showcmd
set scrolloff=2
set cursorline
set incsearch
set cindent
set vb
set visualbell t_vb=

" Tree (netrw)
let g:netrw_liststyle=3

" Custom Key Mappings
inoremap <CR> <Esc>
let mapleader = "\<Space>"
map ; :

" Shortcuts
nnoremap <leader>w <C-W>w
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>i
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gu :Gpull<CR>
nnoremap <leader>n :noh<CR>

" Shortcuts (language specific)
augroup Javascript
  autocmd filetype javascript nnoremap <buffer> <leader>t :!jasmine<CR>
augroup END

" CTRLP Settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)\|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
