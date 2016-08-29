" Vundle
set nocompatible
filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'plasticboy/vim-markdown'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/vim-js-pretty-template'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
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
set showmatch
set hlsearch
set cindent
set vb
set visualbell t_vb=
au GuiEnter * set visualbell t_vb=

" Tree (netrw)
let g:netrw_liststyle=3

" Custom Key Mappings
let mapleader = "\<Space>"
inoremap <CR> <Esc>
nnoremap , ;
nnoremap ; :

" Shortcuts
nnoremap <leader>w <C-W>w
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>i
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gu :Gpull<CR>
nnoremap <leader>n :noh<CR>
nnoremap K i<CR><Esc> 

" Use very magic regex
nnoremap / /\v
vnoremap / /\v
set gdefault " Use /g by default

" Shortcuts (language specific)
augroup Javascript
  autocmd filetype javascript nnoremap <buffer> <leader>t :wa<CR>:!jasmine<CR>
augroup END

" Disable auto comment new lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o 

" Syntax highlighting for HTML in TypeScript
autocmd FileType typescript JsPreTmpl html
autocmd FileType typescript syn clear foldBraces

" CTRLP Settings
set wildignore+=*/tmp/*,*.swp,*.zip,*.dll,*.exe,*.map
let g:ctrlp_root_markers = ['package.json']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|typings|[Bb]in|[Oo]bj)$',
  \ 'file': '\v\.(exe|dll|map)$',
  \ }
