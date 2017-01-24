" Christian Rondeau's .vimrc
" Get it from https://github.com/christianrondeau/.vim

" Setup {{{

set nocompatible
scriptencoding utf-8
set encoding=utf-8
set rtp+=~/.vim/vimfiles

" }}}

" Terminal {{{

let s:term = ''
if has("gui_running")
	" Terminal: gVim {{{

	let s:term = 'gvim'
	au GuiEnter * set visualbell t_vb= " No screen flash (GVim)
	colors wombat
	set lines=40 columns=140
	set selection=inclusive
	if has("unix")
		set guifont=Hack\ 11
	elseif has("win32")
		set guifont=Hack:h11
	endif
	set guioptions-=T " Hide toolbar
	let g:airline_powerline_fonts = 1 " Enables vim-airline pretty separators

	" }}}
elseif stridx(&shell, 'cmd.exe') != -1
	" Terminal: Windows cmd {{{

	let s:term = 'cmd'
	colors industry

	" }}}
else
	" Terminal: Linux bash {{{

	colors wombat
	let g:airline_powerline_fonts = 1 " Enables vim-airline pretty separators
	" Allows mouse when using SSH from Termux
	set mouse=nv

	" Vim on Termux
	if stridx(expand('~/'), 'termux') != -1

		let s:term = 'termux'
  	set title 
  	set titleold="" 
  	set titlestring=VIM:\ %F

	else

		let s:term = 'bash'
		'
	endif	

	" }}}
endif

set visualbell t_vb=               " No screen flash
set noerrorbells                   " No error sounds

" }}}

" Plugins {{{

" Plugins: vim-plug setup {{{

" vim-plug allows installing, updating plugins.
" Usage: :PlugInstall, :PlugUpdate and :PlugUpgrade
call plug#begin("~/.vim/bundle")

" }}}

" Plugins: Dependencies {{{

" Dependency for SnipMate
Plug 'MarcWeber/vim-addon-mw-utils'

" Dependency for SnipMate
Plug 'tomtom/tlib_vim'

" Dependency for tsuquyomi
if has("unix")
	Plug 'Shougo/vimproc.vim', { 'do': 'make' }
else
	" Download DLL files from: https://github.com/Shougo/vimproc.vim/releases
	Plug 'Shougo/vimproc.vim'
endif

Plug 'tpope/vim-dispatch'

" }}}

" Plugins: Git {{{

" Git commands
" Use `<leader>gc` to commit, `gs` to stage, `gp` to push, `gu` to update
Plug 'tpope/vim-fugitive'

" Git browser
" Use `<leader>gb` to open, `<leader>gh` for revisions only
Plug 'junegunn/gv.vim'

" }}}

" Plugins: User Interface Addons {{{

" Tree explorer
" Use `<leader>ll` to open/close tree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

" CTRL+P shortcut to fuzzy find files
" Use `<c-p>` for fuzzy search, `<c-b>` for buffers search
Plug 'ctrlpvim/ctrlp.vim'

" Switch from/to absolute line numbers
" Absolute when unfocused, relative when focused
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Improved status line
Plug 'vim-airline/vim-airline'

" Show the undo tree
" Use `<leader>u` to open tree
Plug 'sjl/gundo.vim'


" }}}

" Plugins: Searching and navigation {{{

" Multiple cursors
" Use <C-n> to move to next occurence of word
if has("gui_running")
	Plug 'vim-multiple-cursors'
endif

" Search using The Silver Searcher (Ag)
" Use <C-f> to search
Plug 'dyng/ctrlsf.vim'

" Automatically remove the search highlight when moving cursor
Plug 'junegunn/vim-slash'

" Find the project root folder (e.g. containing .git)
" Use `<leader>cd`
Plug 'dbakker/vim-projectroot'

" }}}

" Plugins: Text Processing {{{

" Comment shortcuts
" Use `<leader>cc` to comment, `<leader>cu` to uncomment
Plug 'scrooloose/nerdcommenter'

" Snippets
" see ~/.vim/snippets, use `<Tab>` like autocomplete
Plug 'garbas/vim-snipmate'

" Operations for quotes, parenthesis
" Use `cs"'` to replace `"`" by `'`, or `cs"<p>` for tags
" Use `ds(` to delete parenthesis, etc.
Plug 'tpope/vim-surround'

" Align columns
" Run `:Tabularize /<char>` to align text blocks
Plug 'godlygeek/tabular'

" Omni complete w/ tab
" Simply use `<Tab>` to autocomplete
Plug 'ervandew/supertab'

" Base64 conversion
" Use `<leader>btoa` or `<leader>atob` on visually selected text
Plug 'christianrondeau/vim-base64'

" Paste and keep register
" Use `gr` to replace visually selected text
Plug 'vim-scripts/ReplaceWithRegister'

" Automatically add `endif` after typing `if`
Plug 'tpope/vim-endwise', { 'for': ['vim'] }

" }}}

" Plugins: External Tools {{{

" Search in  Loggly
" Use <leader>loggly to search
Plug 'christianrondeau/vim-loggly-search'

" Follow links (paths & urls)
" Run with `<leader>ww`, follow link with <leader>wo, back with `<c-o>`
Plug 'vimwiki/vimwiki'

" }}}

" Plugins: Testing {{{

" Automated vimscript tests
" Run with `:Vader %`
Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': ['vader', 'vim'] }

"}}}

" Plugins: Other {{{

" Pipes buffer to something's stdin
" See b:vimpipe_command for usages
Plug 'krisajenkins/vim-pipe'

" Follow links (paths & urls)
" Run with `<leader>o`, back with `<c-o>`
Plug 'vim-scripts/utl.vim'

" Sums a list of numbers
" Run with `<leader>su`
Plug 'vim-scripts/visSum.vim'

" }}}

" Plugins: Languages / Syntax {{{

" Base plugin for syntax check
Plug 'scrooloose/syntastic'

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" TypeScript Language Server
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }

" TypeScript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" JavaScript/TypeScript HTML templates
Plug 'Quramy/vim-js-pretty-template', { 'for': ['javascript', 'typescript'] }

" JavaScript/TypeScript Indentation
Plug 'jason0x43/vim-js-indent', { 'for': ['javascript', 'typescript'] }

" JSON
Plug 'elzr/vim-json', { 'for': 'json' }

" PowerShell
Plug 'PProvost/vim-ps1', { 'for': 'ps1' }

" C#/Razor
Plug 'OrangeT/vim-csharp', { 'for': ['csharp', 'razor'] }

" }}}

" Plugins: OmniSharp {{{

	" Requires:
	" * Install Python 32 bit (match Vim): `choco install python2-x86_32`
	" * Update `OmniSharp` submodules: `cd ~/.vim/bundle/omnisharp-vim` and `git submodule update --init --recursive`
	" * Build the server with `cd server` and `msbuild` on Windows, or `cd roslyn` and `build.sh` on Linux

if has("python") && has("win32") && filereadable("C:/Python27/python.exe") && filereadable(expand("~/.vim/bundle/omnisharp-vim/server/OmniSharp/bin/Debug/OmniSharp") . ".exe")
	let s:OmniSharp_enabled = 1
elseif has("python") && has("unix") && filereadable(expand("~/.vim/bundle/omnisharp-vim/omnisharp-roslyn/src/OmniSharp/bin/Release/netcoreapp1.0/linux-x64/OmniSharp") . ".exe")
	let s:OmniSharp_enabled = 1
else
	let s:OmniSharp_enabled = 0
endif

let OmniSharp_plugcfg = (s:OmniSharp_enabled ? { 'for': ['csharp', 'razor'] } : { 'on': [] })
Plug 'OmniSharp/omnisharp-vim', OmniSharp_plugcfg

" }}}

" Plugins: Fun & Games {{{

" A text-based roguelike
" Launch with `:Vimcastle`
Plug 'christianrondeau/vimcastle'

" }}}

" Plugins: vim-plug end {{{

call plug#end()

" }}}

" }}}

" VIM Settings {{{

" UI Settings {{{

set shortmess+=I
set hidden                         " Allows hidden buffers
set laststatus=2                   " Always show status line
set relativenumber                 " By default, show line numbers relative to the cursor
set display=lastline               " Show wrapped last line, not just "@".
set textwidth=0                    " Disables auto line breaks
set showcmd                        " Show typed commands
set scrolloff=2                    " Shows the next 2 lines after cursor when scrolling
if s:term != 'cmd'
	set cursorline                   " Highlight the current line
endif
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
set splitbelow                     " Create splits below
set splitright                     " Create vsplits on the right

" UI Settings - Folding {{{

set foldlevelstart=99              " Open folds by default
set foldtext=CustomFoldText()

function! CustomFoldText()
	"get first non-blank line
	let fs = v:foldstart
	while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
	endwhile
	if fs > v:foldend
		let line = getline(v:foldstart)
	else
		let line = getline(fs)
		let line = substitute(line, '{{{', '', 'g')
		let line = substitute(line, '^" ', '', 'g')
		" let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	endif

	let foldLevelStr = repeat("+", v:foldlevel)
	let foldSize = 1 + v:foldend - v:foldstart
	let foldSizeStr = foldSize . " lines"
	return line . " {{{ " . foldLevelStr . " " . foldSizeStr . " }}}"
endfunction

" }}}

" }}}

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
set noignorecase                   " Make regex case sensitive (\C)
" Use very magic regex everywhere
nnoremap / /\v
vnoremap / /\v
cnoremap s/ sm/\v
cnoremap %s/ %sm/\v
cnoremap \>s/ \>sm/\v
cnoremap g/ g/\v
cnoremap g!/ g!/\v
" Search for tags recurisvely
set tags=./tags;/

" }}}

" Swap files, backup & undo {{{

set nobackup                       " Prevents creating <filename>~ files
set nowritebackup                  " Prevents creating <filename>~ files
set nolazyredraw                   " Avoids redrawing when running macros

" Persistent undo

set undofile
set undodir=$HOME/.vim/undo
set backupdir=$TEMP,$TMP,.
set directory=$TEMP,$TMP,.

set undolevels=100
set undoreload=10000

" }}}

" }}}

" Mappings {{{

" Mappings: Leaders Setup {{{

let mapleader = "\<Space>"
let maplocalleader = "\\"

" }}}

" Mappings: Defaults Overrides {{{

nnoremap ; :
vnoremap ; :
nnoremap , ;
vnoremap , ;
nnoremap K i<CR><Esc> 
nnoremap Y y$
nnoremap q; q:
" Avoid useless cursor movement with missed shortcuts
nnoremap <space> <NOP>
" When pressing <cr>, register an 'undo' step (conflicts with vim-endwise)
" imap <expr> <silent> <CR> pumvisible() ? "<C-y>" : "<C-g>u<CR>"

" }}}

" Mappings: Custom Shortcuts {{{

inoremap jk <Esc>
set pastetoggle=<F2>
inoremap <C-v> <Esc>:set paste<CR>"+p:set nopaste<CR>a
nnoremap <leader>cd :ProjectRootCD<CR>
nnoremap <silent> <leader>n :noh<CR>
nnoremap <silent> <leader>path :let @+ = expand("%:p")<CR>
nnoremap <leader>ev :e $HOME/.vim/_vimrc<CR>
if s:term == "termux"
	vnoremap <leader>y y:call system('termux-clipboard-set', @")<CR><CR>
	nnoremap <silent><leader>p :set paste \| exe "read! termux-clipboard-get" \| set nopaste<CR>
else
	vnoremap <silent> <leader>y "+y
	nnoremap <silent> <leader>p :set paste<CR>"+p:set nopaste<CR>
endif

" }}}

" Mappings: NERDTree Shortcuts {{{

nnoremap <silent> <leader>lo :NERDTreeToggle<CR>
nnoremap <silent> <leader>ll :NERDTreeFind<CR>
nnoremap <silent> <leader>lq :NERDTreeClose<CR>

" }}}

" Mappings: Fugitive Shortcuts {{{

command! GdiffTab tabedit %|Gvdiff
command! -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!

nnoremap <leader>g <NOP>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>i
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gu :Gpull<CR>
nnoremap <leader>gd :GdiffTab<CR>
" Git Grep
nnoremap <leader>gf :Ggr<Space>
" Git Browse
nnoremap <leader>gb :GV<CR>
" Git Revisions (current file)
nnoremap <leader>gr :GV!<CR>

" }}}

" Mappings: Gundo Shortcuts {{{

nnoremap <leader>u :GundoToggle<CR>

" }}}

" Mappings: Utl Shortcuts {{{

nnoremap <silent> <leader>o :Utl<CR>
vnoremap <silent> <leader>o "*y:Utl openLink visual edit<CR>

" }}}

" Mappings: CtrlP shortcuts {{{

noremap <C-b> :CtrlPBuffer<CR>
nnoremap <silent> <leader>mru :CtrlPMRUFiles<CR>

" }}}

" Mappings: CtrlSF (Ag) Shortcuts {{{

nmap <C-f> <Plug>CtrlSFPrompt
vmap <C-f> <Plug>CtrlSFVwordExec

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
	" Save and run current script
	nnoremap <leader>s <NOP>
	nnoremap <leader>sv :update<CR>:source %<CR>
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

" Plugin-Specific Settings {{{

" CTRLP Settings {{{

set wildignore+=*/tmp/*,*.swp,*.zip,*.dll,*.exe,*.map,tags
let g:ctrlp_root_markers = ['package.json']
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/](\.git|node_modules|typings|vim80|bundle|[Bb]in|[Oo]bj|dist|out|undo)$',
			\ 'file': '\v\.(exe|dll|map)$',
			\ }

" }}}

" Ctrlsf (Ag) Settings {{{

let g:ctrlsf_default_root = 'project'

let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ }

" }}}

" Syntastic Settings {{{

if exists('g:syntastic_version')
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
	
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
endif

" }}}

" Tsuquyomi {{{

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

" }}}

" Omni Settings {{{

set completeopt=longest,menuone

" }}}

" OmniSharp Settings {{{

if s:OmniSharp_enabled

	" OmniSharp
	if has("unix") && !has("win32unix")
		let g:OmniSharp_server_type = 'roslyn'
	endif

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

" Vader Settings {{{
command! -bang -nargs=* -range -complete=file Test exec '<line1>,<line2>Vader<bang>' <q-args> | cclose
" }}}

" UTL Settings {{{

let g:utl_cfg_hdl_scm_http = "silent !termux-open-url %u"

" }}}

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

" Utilities {{{

" Compare JSON in tests {{{
function! Utils_comparejsonintest()
	" Expected buffer
	e nunit_expected
	" Paste
	normal! "+pgg0
	" Keep only 1st object, put 2nd in register
	exec "normal! d/{\<cr>%lxjdG"
	" Actual buffer
	vsplit nunit_actual
	" Paste
	normal! Vp0
	" Remove everything else
	normal! dt{%lvG$x
	" Run diff on both buffers
	windo diffthis
	" Alloq quick quit with `q`
	nnoremap q :qa!<CR>
endfunction
" }}}

" }}}
