" Vundle Setup {{{
set nocompatible
filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/vimfiles
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " Plugin manager
" }}}

" Plugins {{{
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
Plugin 'vim-airline/vim-airline'           " Improved status line

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
" }}}

" Vundle End {{{
call vundle#end()
filetype plugin indent on
" }}}

" Terminal Settings {{{
syntax on
if has("gui_running") 
	" gVim
	au GuiEnter * set visualbell t_vb= " No screen flash (GVim)
	colors wombat
	set lines=40 columns=140
	set guifont=Hack:h11
	set guioptions-=T " Hide toolbar
	let g:airline_powerline_fonts = 1 " Enables vim-airline pretty separators
elseif stridx(&shell, 'cmd.exe') != -1
	" Vim in Windows Terminal
	colors industry
else
	" Vim on Linux
	colors wombat
	let g:airline_powerline_fonts = 1 " Enables vim-airline pretty separators
endif
" }}}

" Settings {{{
set relativenumber                 " By default, show line numbers relative to the cursor
set encoding=utf-8                 " UTF-8
set tabstop=2                      " Tab Width
set shiftwidth=2                   " Controls ReIndent (`<<` and `>>`)
set showcmd                        " Show typed commands
set scrolloff=2                    " Shows the next 2 lines after cursor when scrolling
set cursorline                     " Highlight the current line
set incsearch                      " Show search result as you type
set showmatch                      " Highlight matching braces
set showmode                       " Shows when in paste mode
set hlsearch                       " highlight all / search results
set cindent                        " Strict C-line indenting
set foldlevelstart=99              " Open folds by default
set backspace=indent,eol,start     " Allow backspace on autoindent
set laststatus=2                   " Always show status line
set visualbell t_vb=               " No screen flash (Android)
" }}}

" Custom Key Mappings {{{
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
nnoremap <silent> <leader>ll :NERDTreeFind<CR>
nnoremap <silent> <leader>n :noh<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>i
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gu :Gpull<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ev :vsplit $HOME/.vim/vimrc<CR>
nnoremap <leader>sv :source $HOME/.vim/vimrc<CR>
noremap <C-b> :CtrlPBuffer<CR>
inoremap <C-v> <Esc>:set paste<CR>"+p:set nopaste<CR>a
set pastetoggle=<F2>

" Breaking Habits...
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" }}}

" Temporary Files {{{
nnoremap <leader>e1 :e $TEMP/vim-temp-1.txt<CR>
nnoremap <leader>e2 :e $TEMP/vim-temp-2.txt<CR>
nnoremap <leader>e3 :e $TEMP/vim-temp-3.txt<CR>
nnoremap <leader>e4 :e $TEMP/vim-temp-4.txt<CR>
nnoremap <leader>e5 :e $TEMP/vim-temp-5.txt<CR>
nnoremap <leader>e6 :e $TEMP/vim-temp-6.txt<CR>
nnoremap <leader>e7 :e $TEMP/vim-temp-7.txt<CR>
nnoremap <leader>e8 :e $TEMP/vim-temp-8.txt<CR>
nnoremap <leader>e9 :e $TEMP/vim-temp-9.txt<CR>
" }}}

" Regex {{{
nnoremap / /\v
vnoremap / /\v
set gdefault " Use /g by default
" }}}

" Vimscript {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
	autocmd FileType vim setlocal foldlevel=0
augroup END
" }}}

" Text {{{
augroup filetype_txt
	autocmd!
	autocmd FileType text setlocal noautoindent nocindent nosmartindent
augroup END
" }}}

" JavaScript {{{
augroup filetype_javascript
	autocmd!
	autocmd filetype javascript nnoremap <buffer> <leader>t :wa<CR>:!jasmine<CR>
augroup END
" }}}

" TypeScript {{{
augroup filetype_typescript
	autocmd!
	autocmd FileType typescript nnoremap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
	autocmd FileType typescript JsPreTmpl html
	autocmd FileType typescript syn clear foldBraces
augroup END
" }}}

" All Languages {{{
augroup DisableAutoCommentNewLines
	autocmd!
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o 
augroup END
" }}{

" CTRLP Settings {{π
set wildignore+=*/tmp/*,*.swp,*.zip,*.dll,*.exe,*.map
let g:ctrlp_root_markers = ['package.json']
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/](\.git|node_modules|typings|[Bb]in|[Oo]bj|dist|out)$',
			\ 'file': '\v\.(exe|dll|map)$',
			\ }
" }}}

" Syntastic Settings {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']
" }}}

" Omni Settings {{{
set completeopt=longest,menuone
" }}}

" Vim Airline Settings {{{
let g:airline#extensions#default#layout = [
			\ [ 'a', 'c' ],
			\ [ 'b', 'error', 'warning' ]
			\ ]
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#obsession#enabled = 0
let g:airline#extensions#branch#format = 1
" }}}

