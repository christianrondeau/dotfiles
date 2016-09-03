" Vundle
set nocompatible
filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/vimfiles
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

" Vundle
call vundle#end()
filetype plugin indent on

" Custom Settings
syntax on
if has("gui_running") 
	" gVim
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
set foldlevelstart=20              " Open folds by default
set backspace=indent,eol,start     " Allow backspace on autoindent
set laststatus=2                   " Always show status line
set visualbell t_vb=               " No screen flash (Android)
au GuiEnter * set visualbell t_vb= " No screen flash (GVim)

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
nnoremap <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>n :noh<CR>
set pastetoggle=<leader>p

" Use very magic regex
nnoremap / /\v
vnoremap / /\v
set gdefault " Use /g by default

" Shortcuts (language specific)

augroup Javascript
	autocmd!
	autocmd filetype javascript nnoremap <buffer> <leader>t :wa<CR>:!jasmine<CR>
augroup END

augroup TypeScript
	autocmd!
	autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
	autocmd FileType typescript JsPreTmpl html
	autocmd FileType typescript syn clear foldBraces
augroup END

" Disable auto comment new lines
augroup DisableAutoCommentNewLines
	autocmd!
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o 
augroup END

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

" Vim Airline Settings
let g:airline#extensions#default#layout = [
			\ [ 'a', 'c' ],
			\ [ 'b', 'error', 'warning' ]
			\ ]
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#obsession#enabled = 0
let g:airline#extensions#branch#format = 1
