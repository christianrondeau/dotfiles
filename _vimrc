" Christian Rondeau's .vimrc
" Get it from https://github.com/christianrondeau/.vim

" Setup {{{

set nocompatible
scriptencoding utf-8
set encoding=utf-8

" }}}

" Plugins {{{

" Plugins: Vundle Setup {{{

filetype on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/vimfiles
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " Plugin manager

" }}}

" Plugins: Dependencies {{{

" Dependency for SnipMate
Plugin 'MarcWeber/vim-addon-mw-utils'

" Dependency for SnipMate
Plugin 'tomtom/tlib_vim'

" Dependency for tsuquyomi
Plugin 'Shougo/vimproc.vim'

Plugin 'tpope/vim-dispatch'

" }}}

" Plugins: Common {{{

" Git commands
" Use `<leader>gc` to commit, `gs` to stage, `gp` to push, `gu` to update
Plugin 'tpope/vim-fugitive'

" Tree explorer
" Use `<leader>ll` to open/close tree
Plugin 'scrooloose/nerdtree'

" Comment shortcuts
" Use `<leader>cc` to comment, `<leader>cu` to uncomment
Plugin 'scrooloose/nerdcommenter'

" CTRL+P shortcut to fuzzy find files
" Use `<c-p>` for fuzzy search, `<c-b>` for buffers search
Plugin 'ctrlpvim/ctrlp.vim'

" Snippets
" see ~/.vim/snippets, use `<Tab>` like autocomplete
Plugin 'garbas/vim-snipmate'

" Operations for quotes, parenthesis
" Use `cs"'` to replace `"`" by `'`, or `cs"<p>` for tags
" Use `ds(` to delete parenthesis, etc.
Plugin 'tpope/vim-surround'

" Align columns
" Run `:Tabularize /<char>` to align text blocks
Plugin 'godlygeek/tabular'

" Switch from/to absolute line numbers
" Absolute when unfocused, relative when focused
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

" Omni complete w/ tab
" Simply use `<Tab>` to autocomplete
Plugin 'ervandew/supertab'

" Improved status line
Plugin 'vim-airline/vim-airline'

" Pipes buffer to something's stdin
" See b:vimpipe_command for usages
Plugin 'krisajenkins/vim-pipe'

" Show the undo tree
" Use `<leader>u` to open tree
Plugin 'sjl/gundo.vim'

" Base64 conversion
" Use `<leader>btoa` or `<leader>atob` on visually selected text
Plugin 'christianrondeau/vim-base64'

" Paste and keep register
" Use `gr` to replace visually selected text
Plugin 'vim-scripts/ReplaceWithRegister'

" Search in  Loggly
" Use <leader>loggly to search
Plugin 'christianrondeau/vim-loggly-search'

" Automated vimscript tests
" Run with `:Vader %`
Plugin 'junegunn/vader.vim'

" Follow links (paths & urls)
" Run with `<leader>o`, back with `<c-o>`
Plugin 'vim-scripts/utl.vim'

" Follow links (paths & urls)
" Run with `<leader>ww`, follow link with <leader>wo, back with `<c-o>`
Plugin 'vimwiki/vimwiki'

" }}}

" Plugins: Languages / Syntax {{{

Plugin 'Quramy/tsuquyomi'              " TypeScript Language Server

Plugin 'scrooloose/syntastic'          " Base plugin for syntax check

Plugin 'plasticboy/vim-markdown'       " Markdown
Plugin 'pangloss/vim-javascript'       " JavaScript
Plugin 'leafgarland/typescript-vim'    " TypeScript
Plugin 'Quramy/vim-js-pretty-template' " JavaScript/TypeScript HTML templates
Plugin 'jason0x43/vim-js-indent'       " JavaScript/TypeScript Indentation
Plugin 'PProvost/vim-ps1'              " PowerShell
Plugin 'elzr/vim-json'                 " JSON
Plugin 'OrangeT/vim-csharp'            " C#/Razor

" }}}

" Plugins: OmniSharp {{{

let s:OmniSharp_enabled = 0
if has("python") && has("win32") && filereadable("C:/Python27/python.exe") && filereadable(expand("~/.vim/bundle/omnisharp-vim/server/OmniSharp/bin/Debug/OmniSharp") . ".exe")

	" Requires:
	" * Install Python 32 bit (match Vim): `choco install python2-x86_32`
	" * Update `OmniSharp` submodules: `cd ~/.vim/bundle/omnisharp-vim` and `git submodule update --init --recursive`
	" * Build the server with `cd server` and `msbuild`

	let s:OmniSharp_enabled = 1
	Plugin 'OmniSharp/omnisharp-vim'
endif

" }}}

" Plugins: Vundle End {{{

call vundle#end()
filetype plugin indent on

" }}}

" }}}

" Terminal {{{

if has("gui_running") 
	" Terminal: gVim {{{

	au GuiEnter * set visualbell t_vb= " No screen flash (GVim)
	colors wombat
	set lines=40 columns=140
	set guifont=Hack:h11
	set guioptions-=T " Hide toolbar
	let g:airline_powerline_fonts = 1 " Enables vim-airline pretty separators

	" }}}
elseif stridx(&shell, 'cmd.exe') != -1
	" Terminal: Windows cmd {{{

	colors noctu

	" }}}
else
	" Terminal: Linux bash {{{

	colors wombat
	let g:airline_powerline_fonts = 1 " Enables vim-airline pretty separators
	set mouse=a " Allows mouse when using SSH from Termux

	" Vim on Termux
	if stridx(expand('~/'), 'termux') != -1
  		set title 
  		set titleold="" 
  		set titlestring=VIM:\ %F
		let g:utl_cfg_hdl_scm_http = "silent !termux-open-url %u"
		vnoremap <silent> <leader>y :w !termux-clipboard-set<CR><CR>

	endif	

	" }}}
endif

set visualbell t_vb=               " No screen flash
set noerrorbells                   " No error sounds

" }}}

" UI Settings {{{

syntax on                          " Show syntax colors
set hidden                         " Allows hidden buffers
set laststatus=2                   " Always show status line
set relativenumber                 " By default, show line numbers relative to the cursor
set display=lastline               " Show wrapped last line, not just "@".
set textwidth=0                    " Disables auto line breaks
set showcmd                        " Show typed commands
set scrolloff=2                    " Shows the next 2 lines after cursor when scrolling
set cursorline                     " Highlight the current line
set showmode                       " Shows when in paste mode
if s:OmniSharp_enabled
	set noshowmatch                  " Disabled for OmniSharp
else
	set showmatch                    " Highlight matching braces
endif
set wildmode=longest,list,full     " Bash-like, then cycle
set wildmenu                       " Shows a menu when using Tab in command paths
set list                           " Show whitespace
" Set showbreak to '↪ '
let &showbreak="\u21aa "
" Set listchars to '›', '·', '↲'
let &listchars="tab:\u203a\ ,trail:\u00b7,extends:\u21b2"
set foldlevelstart=99              " Open folds by default
set splitbelow                     " Create splits below
set splitright                     " Create vsplits on the right

" }}}

" Text Settings {{{

set backspace=indent,eol,start     " Allow backspace on autoindent
set tabstop=2                      " Tab Width
set shiftwidth=2                   " Controls ReIndent (`<<` and `>>`)
set cindent                        " Strict C-line indenting
set iskeyword-=-

" }}}

" Search Settings {{{

let @/=""                          " Empty search on launch
set incsearch                      " Show search result as you type
set hlsearch                       " highlight all / search results
set gdefault                       " Use /g by default
" Use very magic regex everywhere
nnoremap / /\v
vnoremap / /\v
cnoremap s/ sm/\v
cnoremap %s/ %sm/\v
cnoremap \>s/ \>sm/\v
cnoremap g/ g/\v
cnoremap g!/ g!/\v

" }}}

" Swap files, backup & undo {{{

set nobackup                       " Prevents creating <filename>~ files
set nowritebackup                  " Prevents creating <filename>~ files
set nolazyredraw                   " Avoids redrawing when running macros

" Persistent undo

set undofile
set undodir=$HOME/.vim/undo

set undolevels=100
set undoreload=10000

" }}}

" Git Grep {{{

if !exists(":Ggr")
	command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!
endif

" }}}

" Mappings {{{

" Mappings: Leaders Setup {{{

let mapleader = "\<Space>"
let maplocalleader = "\\"

" }}}

" Mappings: Defaults overrides {{{

nnoremap ; :
vnoremap ; :
nnoremap , ;
vnoremap , ;
nnoremap q; q:
nnoremap <space> <NOP>

" }}}

" Mappings: Remap Enter to Esc {{{

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<Esc>"

" }}}

" Mappings: Custom shortcuts {{{

nnoremap K i<CR><Esc> 
set pastetoggle=<F2>

" }}}

" Mappings: Leader shortcuts {{{

nnoremap <silent> <leader>w <C-W>w
nnoremap <silent> <leader>l :NERDTreeToggle<CR>
nnoremap <silent> <leader>ll :NERDTreeFind<CR>
nnoremap <silent> <leader>lq :NERDTreeClose<CR>
nnoremap <silent> <leader>n :noh<CR>
nnoremap <silent> <leader>path :let @+ = expand("%:p")<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>i
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gu :Gpull<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gf :Ggr<Space>
nnoremap <leader>ev :vsplit $HOME/.vim/_vimrc<CR>
nnoremap <leader>sv :update<CR>:source %<CR>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <silent> <leader>o :Utl<CR>
vnoremap <silent> <leader>o "*y:Utl openLink visual edit<CR>
nnoremap <silent> <leader>mru :CtrlPMRUFiles<CR>

" }}}

" Mappings: Ctrl shortcuts {{{

noremap <C-b> :CtrlPBuffer<CR>
inoremap <C-v> <Esc>:set paste<CR>"+p:set nopaste<CR>a

" }}}

" }}}

" Languages {{{

" Languages: Vimscript {{{

augroup filetype_vim
	autocmd!
	" Fold using markers
	autocmd FileType vim setlocal foldmethod=marker
	" Close folds by default
	autocmd FileType vim setlocal foldlevel=0
augroup END

" }}}

" Languages: Text {{{

augroup filetype_txt
	autocmd!
	" No auto indent
	autocmd FileType text setlocal noautoindent nocindent nosmartindent
augroup END

" }}}

" Languages: Markdown {{{

augroup filetype_markdown
	autocmd!
	autocmd FileType markdown setlocal expandtab shiftwidth=2 softtabstop=2
augroup END

" }}}

" Languages: JavaScript {{{

augroup filetype_javascript
	autocmd!
	" <leader>t to run tests
	autocmd filetype javascript nnoremap <buffer> <leader>t :wa<CR>:!npm test<CR>

augroup END
" }}}

" Languages: TypeScript {{{

augroup filetype_typescript
	autocmd!
	" <leader>r to rename
	autocmd FileType typescript nnoremap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
	" <leader>t to run tests
	autocmd filetype typescript nnoremap <buffer> <leader>t :wa<CR>:!npm test<CR>
	" Highlight html templates
	autocmd FileType typescript JsPreTmpl html
	autocmd FileType typescript syn clear foldBraces
augroup END

" }}}

" Languages: JSON {{{

augroup filetype_json
	autocmd!
	" <localleader>f to format json
	let b:vimpipe_command="python -m json.tool"
	nnoremap <localleader>f :%!python -m json.tool<cr>
augroup END

" }}}

" Languages: All {{{

augroup DisableAutoCommentNewLines
	autocmd!
	" Never autocomment on new lines
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o 
augroup END

" }}}

" }}}

" CTRLP Settings {{{

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

" OmniSharp Settings {{{

if s:OmniSharp_enabled

	" OmniSharp
	let g:OmniSharp_server_type = 'roslyn'

	" CtrlP
	let g:OmniSharp_selector_ui = 'ctrlp'

	" SuperTab
	let g:SuperTabDefaultCompletionType = 'context'
	let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
	let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
	let g:SuperTabClosePreviewOnPopupClose = 1

	" Syntastic
	let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

	augroup omnisharp_commands
		autocmd!

		" File Settings
		autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
		autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
		autocmd BufWritePost *.cs call OmniSharp#AddToProject()
		autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

		" Shortcuts
		autocmd FileType cs nnoremap <localleader>b :wa!<cr>:OmniSharpBuildAsync<cr>
		autocmd FileType cs nnoremap <localleader>rr :OmniSharpRename<cr>
		autocmd FileType cs nnoremap <localleader>gd :OmniSharpGotoDefinition<cr>
		autocmd FileType cs nnoremap <localleader>gi :OmniSharpFindImplementations<cr>
		autocmd FileType cs nnoremap <localleader>t :OmniSharpFindType<cr>
		autocmd FileType cs nnoremap <localleader>ts :OmniSharpFindSymbol<cr>
		autocmd FileType cs nnoremap <localleader>gu :OmniSharpFindUsages<cr>
		autocmd FileType cs nnoremap <localleader><localleader> :OmniSharpGetCodeActions<cr>
		autocmd FileType cs vnoremap <localleader><localleader> :call OmniSharp#GetCodeActions('visual')<cr>

	augroup END

endif

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

" Vimwiki Settings {{{

" Prevent CR override
nnoremap łwf <Plug>VimwikiFollowLink
nnoremap łws <Plug>VimwikiSplitLink
nnoremap łwv <Plug>VimwikiVSplitLink
nnoremap łwv <Plug>VimwikiTabnewLink
vnoremap łwn <Plug>VimwikiNormalizeLinkVisualCR
inoremap łwn VimwikiReturn

augroup filetype_vimwiki
	autocmd!
	autocmd FileType vimwiki nnoremap <silent><buffer> <leader>wo <Plug>VimwikiFollowLink
augroup END

" }}}

" PowerShell {{{

if has("win32")
	let g:curshell = &shell
	let g:curshellcmdflag = &shellcmdflag

	function! TogglePowerShell()
		if &shell ==# "powershell"
			let &shell = g:curshell
			let &shellcmdflag = g:curshellcmdflag
			echom "shell reset to default shell"
		else
			set shell=powershell
			set shellcmdflag=-command
			echom "shell set to PowerShell"
		endif
	endfunction
	nnoremap <F9> :call TogglePowerShell()<cr>
	cnoremap <F9> <c-c>:call TogglePowerShell()<cr>:
endif

" }}}

" Machine Config {{{

if filereadable(expand("~/.vimrc_private"))
	source ~/.vimrc_private
endif

" }}}

