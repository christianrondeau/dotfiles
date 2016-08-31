" Vundle
set nocompatible
filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " Plugin manager

" Plugins
Plugin 'tpope/vim-fugitive'                " Git commands
Plugin 'scrooloose/nerdtree'               " Tree explorer
Plugin 'ctrlpvim/ctrlp.vim'                " CTRL+P shortcut to fuzzy find files
Plugin 'MarcWeber/vim-addon-mw-utils'      " Dependency for SnipMate
Plugin 'tomtom/tlib_vim'                   " Dependency for SnipMate
Plugin 'garbas/vim-snipmate'               " Snippets (see ~/.vim/snippets)
Plugin 'tpope/vim-surround'                " Operations for quotes, parenthesis
Plugin 'godlygeek/tabular'                 " Align columns
Plugin 'jeffkreeftmeijer/vim-numbertoggle' " Show relative numbers in command
Plugin 'ervandew/supertab'                 " Omni complete w/ tab

" Language Servers
Plugin 'Shougo/vimproc.vim' " Dependency (executes processes)
Plugin 'Quramy/tsuquyomi'   " TypeScript Language Server

" Syntax Check
Plugin 'scrooloose/syntastic' " Base plugin for syntax check

" Syntax Highlighting
Plugin 'plasticboy/vim-markdown'       " Markdown
Plugin 'pangloss/vim-javascript'       " JavaScript
Plugin 'leafgarland/typescript-vim'    " TypeScript
Plugin 'Quramy/vim-js-pretty-template' " JavaScript/TypeScript HTML templates
Plugin 'jason0x43/vim-js-indent'       " JavaScript/TypeScript Indentation

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

" Custom Key Mappings
let mapleader = "\<Space>"
nnoremap ; :
vnoremap ; :
nnoremap , ;
vnoremap , ;
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<Esc>"
nnoremap zz zO
nnoremap K i<CR><Esc> 

" Shortcuts
nnoremap <silent> <leader>w <C-W>w
nnoremap <silent> <leader>l :NERDTreeToggle<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>i
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gu :Gpull<CR>
nnoremap <silent> <leader>n :noh<CR>

" Use very magic regex
nnoremap / /\v
vnoremap / /\v
set gdefault " Use /g by default

" Shortcuts (language specific)

augroup Javascript
  autocmd filetype javascript nnoremap <buffer> <leader>t :wa<CR>:!jasmine<CR>
augroup END

augroup TypeScript
	autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
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
  \ 'dir':  '\v[\/](\.git|node_modules|typings|[Bb]in|[Oo]bj|dist|out)$',
  \ 'file': '\v\.(exe|dll|map)$',
  \ }

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

" Omni Settings
set completeopt=longest,menuone
