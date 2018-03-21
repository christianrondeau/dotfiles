" Christian Rondeau's .vimrc
" Get it from https://github.com/christianrondeau/.vim

" Setup {{{

set nocompatible
scriptencoding utf-8
set encoding=utf-8
set rtp+=~/.vim/vimfiles

" }}}

" Terminal {{{

" Terminal: GVim {{{

if(has("gui_running"))

	augroup gvim_noscreenflash
		autocmd!
		au GuiEnter * set visualbell t_vb=
	augroup END

	" Prevent resetting gvim when sourcing vimrc
	if(!exists('g:vimrc_gvim_config_initialized'))
		set lines=40 columns=140
		if(has("unix"))
			set guifont=Hack\ 12
		elseif(has("win32"))
			set guifont=Hack:h12
		endif
		set guioptions-=T " Hide toolbar
		set guioptions-=m  "remove menu bar
		let g:vimrc_gvim_config_initialized = 1
	endif

endif

" }}}

" Terminal: Bash {{{

if(stridx(&shell, 'cmd.exe') == -1 && !has('gui_running'))
	" Allows mouse when using SSH from Termux
	set mouse=a

	" Termux
	if(stridx(expand('~/'), 'termux') != -1)
  	set title
  	set titleold=""
  	set titlestring=VIM:\ %F
	endif

endif

" }}}

" }}}

" Plugins {{{

" Plugins: vim-plug setup {{{

" vim-plug allows installing, updating plugins.
" Usage: :PlugInstall, :PlugUpdate and :PlugUpgrade
call plug#begin("~/.vim/bundle")

" }}}

" Plugins: Themes {{{

Plug 'tomasiser/vim-code-dark'

" }}}

" Plugins: Dependencies {{{

if(has("unix"))
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

" Git browse
" Use `<leader>gb` to open, `<leader>gh` for revisions only
Plug 'junegunn/gv.vim'

" Git branches
" Use `<leader>go` to open
Plug 'idanarye/vim-merginal'

" }}}

" Plugins: User Interface Addons {{{

" Tree explorer
" Use `<leader>ll` to open/close tree
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

" CTRL+P shortcut to fuzzy find files
" Use `<c-p>` for fuzzy search, `<c-b>` for buffers search
Plug 'ctrlpvim/ctrlp.vim'

" Improved status line
Plug 'vim-airline/vim-airline'

" Switch from/to absolute line numbers
" Absolute when unfocused, relative when focused
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Show the undo tree
" Use `<leader>u` to open tree
Plug 'sjl/gundo.vim'

" Launch with a useful startup screen
Plug 'mhinz/vim-startify'

" Distraction-free writing
" Use `:Goyo` to start
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
if(has('win32') && has("gui_running"))
	Plug 'derekmcloughlin/gvimfullscreen_win32'
	let s:vimrc_gvimfullscreen_installed = 1
endif

" }}}

" Plugins: Searching and navigation {{{

" Multiple cursors
" Use <C-n> to move to next occurence of word
Plug 'terryma/vim-multiple-cursors'

" Search using The Silver Searcher (Ag)
" Use <C-f> to search
Plug 'dyng/ctrlsf.vim'

" Automatically remove the search highlight when moving cursor
Plug 'junegunn/vim-slash'

" Find the project root folder (e.g. containing .git)
" Use `<leader>cd`
Plug 'dbakker/vim-projectroot'

" Closes all buffers but the current one
" Use `:BufOnly`
Plug 'vim-scripts/BufOnly.vim'

" Follow links (paths & urls)
" Run with `<leader>o`, back with `<c-o>`
Plug 'vim-scripts/utl.vim'

" Fuzzy finding
" `:FZF`, `:(G)Files`, `:Buffers`, `:Ag`, `:(B)Lines`, `:History`, `:Commands`
" More information: https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf.vim'

" }}}

" Plugins: Text Processing {{{

" Comment shortcuts
" Use `<leader>cc` to comment, `<leader>cu` to uncomment
Plug 'scrooloose/nerdcommenter'

" Snippets
" see ~/.vim/snippets, use `<Tab>` to autocomplete
if has('python')
	Plug 'SirVer/ultisnips'
endif

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
" Note: This additional mapping allows doing "undo" between linebreaks
inoremap <CR> <C-G>u<CR>
Plug 'tpope/vim-endwise'

" Allow re-playing commands with `.`
Plug 'tpope/vim-repeat'
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

" Sums a list of numbers
" Run with `<leader>su`
Plug 'vim-scripts/visSum.vim'

" }}}

" Plugins: Languages / Syntax {{{

" Base plugin for syntax check
Plug 'scrooloose/syntastic'

" Markdown
Plug 'plasticboy/vim-markdown'

" JavaScript/TypeScript
Plug 'Quramy/tsuquyomi'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'jason0x43/vim-js-indent'

" JSON
Plug 'elzr/vim-json'

" PowerShell
Plug 'PProvost/vim-ps1'

" C#/Razor
Plug 'OrangeT/vim-csharp'

" Go Lang
" Install with :GoInstallBinaries
" Doc: https://github.com/fatih/vim-go/blob/master/README.md
Plug 'fatih/vim-go'

" }}}

" Plugins: Fun & Games {{{

" A text-based roguelike
" Launch with `:Vimcastle`
Plug 'christianrondeau/vimcastle'

" }}}

" Plugins: Machine-specific {{{

" Plugins I don't want in GitHub for a reason or another.
if(filereadable(expand("~/.vimrc_plugins")))
	source ~/.vimrc_plugins
endif

" }}}

" Plugins: vim-plug end {{{

try
	call plug#end()
catch /E484:/
	" Ignore. This may happen when vim syntax cannot be found
endtry

" }}}

" }}}

" VIM Settings {{{

" VIM: Colors {{{

if(!has('gui_running') && !has('nvim') && stridx(&shell, 'cmd.exe') != -1)
	colorscheme industry
else
	try
		colorscheme codedark
		let g:airline_theme = 'codedark'
	catch /^Vim\%((\a\+)\)\=:E185/
		" Well, too bad...
		colorscheme industry
	endtry
endif

" }}}

" VIM: Macros {{{

" Allows using `%` to jump to a matching <xml> tag
if(!has('nvim') && !exists('g:loaded_matchit'))
	try
		packadd matchit
	catch /E919:/
		" Too bad...
	catch /E492:/
		" TODO: Find out why this happens (E492: Not an editor command: ^I^Ipackadd matchit)
	endtry
endif

" }}}

" VIM: General {{{

set visualbell t_vb=               " No screen flash
set noerrorbells                   " No error sounds
if(stridx(expand('~/'), 'termux') == -1) " On termux system register is slow
	set clipboard=unnamed,unnamedplus  " Use system register
end

" }}}

" VIM: UI Settings {{{

" Do not show vim intro message
set shortmess+=I
set hidden                         " Allows hidden buffers
set laststatus=2                   " Always show status line
set relativenumber                 " By default, show line numbers relative to the cursor
set number                         " Show the current line number at the cursor
set display=lastline               " Show wrapped last line, not just "@".
set textwidth=0                    " Disables auto line breaks
set showcmd                        " Show typed commands
set scrolloff=2                    " Shows the next 2 lines after cursor when scrolling
if(stridx(&shell, 'cmd.exe') != -1)
	set cursorline                   " Highlight the current line
endif
set showmode                       " Shows when in paste mode
set showmatch                      " Highlight matching braces
set completeopt=longest,menuone
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
	if(fs > v:foldend)
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

" VIM: Text Settings {{{

set backspace=indent,eol,start     " Allow backspace on autoindent
set tabstop=2                      " Tab Width
set shiftwidth=2                   " Controls ReIndent (`<<` and `>>`)
set cindent                        " Strict C-line indenting
set iskeyword-=-

" }}}

" VIM: Search Settings {{{

let @/=""                          " Empty search on launch
set incsearch                      " Show search result as you type
set hlsearch                       " highlight all / search results
set gdefault                       " Use /g by default
set noignorecase                   " Make regex case sensitive (\C)
" Use very magic regex everywhere
nnoremap / /\v
vnoremap / /\v
" Search for tags recursively
set tags=./tags;/

" }}}

" VIM: Swap files, backup & undo {{{

set nobackup                       " Prevents creating <filename>~ files
set nowritebackup                  " Prevents creating <filename>~ files
set nolazyredraw                   " Avoids redrawing when running macros

set undodir=$HOME/.vim/undo
set backupdir=$TEMP,$TMP,/tmp,.
set directory=$TEMP,$TMP,/tmp,.
set undofile                       " Create a persistent undo file

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
" Do not line break with enter in visual mode
vnoremap <cr> <NOP>
" Prevent ex mode, I never use it and it conflicts with 'q:'
nnoremap Q q:
vnoremap Q q:
" When pressing <cr>, register an 'undo' step (conflicts with vim-endwise)
" imap <expr> <silent> <CR> pumvisible() ? "<C-y>" : "<C-g>u<CR>"
" }}}

" Mappings: Custom Shortcuts {{{

inoremap jk <Esc>
set pastetoggle=<F2>
inoremap <C-v> <Esc>:set paste<CR>"+p:set nopaste<CR>a
nnoremap <leader>cd :ProjectRootCD<CR>
nnoremap <silent> <leader>n :noh<CR>
nnoremap <silent> <leader>path :let @+ = expand("%:p")<CR>:echo "Copied: " . @+<CR>
nnoremap <leader>ev :e $HOME/dotfiles/vim/.vimrc<CR>
nnoremap <C-F4> :bd<cr>
if(stridx(expand('~/'), 'termux') != -1)
	nnoremap <leader>y ggyG:call system('termux-clipboard-set', @")<CR><CR>
	vnoremap <leader>y y:call system('termux-clipboard-set', @")<CR><CR>
	nnoremap <silent><leader>p :set paste \| exe "read! termux-clipboard-get" \| set nopaste<CR>
else
	nnoremap <silent> <leader>y <ESC>gg"+yG
	vnoremap <silent> <leader>y "+y
	nnoremap <silent> <leader>p :set paste<CR>"+p:set nopaste<CR>
endif

" }}}

" Mappings: NERDTree Shortcuts {{{

nnoremap <silent> <leader>lo :NERDTreeToggle<CR>
nnoremap <silent> <leader>ll :NERDTreeFind<CR>
nnoremap <silent> <leader>lq :NERDTreeClose<CR>

" }}}

" Mappings: Git Shortcuts {{{

command! GdiffTab tabedit %|Gvdiff
command! -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!

nnoremap <leader>g <NOP>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>i
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gu :Gpull --ff-only<CR>
nnoremap <leader>gd :GdiffTab<CR>
" Git Grep
nnoremap <leader>gf :Ggr<Space>
" Git Browse
nnoremap <leader>gb :GV<CR>
" Git Revisions (current file)
nnoremap <leader>gr :GV!<CR>
" Git Branches
nnoremap <leader>go :Merginal<CR>
" Git Extensions
if(has('win32'))
	nnoremap <leader>gx :silent !gitex<CR>
	nnoremap <leader>ge :silent !explorer .<CR>
endif

" }}}

" Mappings: Gundo Shortcuts {{{

nnoremap <leader>u :GundoToggle<CR>

" }}}

" Mappings: Utl Shortcuts {{{

nnoremap <silent> <leader>o :Utl<CR>
vnoremap <silent> <leader>o "*y:Utl openLink visual edit<CR>

" }}}

" Mappings: CtrlP Shortcuts {{{

noremap <C-b> :CtrlPBuffer<CR>
nnoremap <silent> <leader>mru :CtrlPMRUFiles<CR>

" }}}

" Mappings: CtrlSF (Ag) Shortcuts {{{

nmap <C-f> <Plug>CtrlSFPrompt
vmap <C-f> <Plug>CtrlSFVwordExec
nmap <F3> :CtrlSFToggle<CR>

" }}}

" Mappings: *.vim and *.vader Shortcuts {{{

nnoremap <leader>s <NOP>
nnoremap <leader>sv :update<CR>

augroup filetype_vim_shortcuts
	autocmd!
	autocmd FileType vim nnoremap <buffer> <leader>sv :update<CR>:source %<CR>
	autocmd FileType vim nnoremap <buffer> <leader>ul :update<CR>:Vader tests/**<CR>
augroup END

augroup filetype_vader_shortcuts
	autocmd!
	autocmd FileType vader nnoremap <buffer> <leader>ur :update<CR>:Test<CR>
	autocmd FileType vader nnoremap <buffer> <leader>ul :update<CR>:Vader tests/**<CR>
augroup END

" }}}

" Mappings: *.ts Shortcuts {{{

augroup filetype_typescript_shortcuts
	autocmd!
	" <leader>r to rename
	autocmd FileType typescript nnoremap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
	" <leader>t to run tests
	autocmd filetype typescript nnoremap <buffer> <leader>t :wa<CR>:!npm test<CR>
	" }}}

" Mappings: *.json Shortcuts {{{

augroup filetype_json
	autocmd!
	" <localleader>f to format json
	let b:vimpipe_command="python -m json.tool"
	autocmd FileType json nnoremap <buffer> <localleader>f :%!python -m json.tool<cr>
augroup END

" }}}

" Mappings: *.go Shortcuts {{{

augroup filetype_go
	autocmd!
	" Commands to eventually map:
	" GoCoverage (, GoCoverageToggle, GoCoverageBrowser)
	" GoInfo, GoImplements, GoCallees, GoReferrers
	" GoLint, GoVet
	" GoAlternate (switc to/from _test.go)
	" GoImport (GoImportAs, GoDrop)

	" VS-like
	autocmd filetype go nnoremap <buffer> <localleader>ur :update \| GoTestFunc<cr>
	autocmd filetype go nnoremap <buffer> <localleader>ul :update \| GoTest ./...<cr>
	autocmd filetype go nnoremap <buffer> <localleader>rr :update \| GoRename<cr>
	autocmd filetype go nnoremap <buffer> <F12> :GoDef<cr>
	autocmd filetype go nmap <buffer> <F5> <Plug>(go-run)

	" This gets re-written by vim-go otherwise
	autocmd filetype go nnoremap <buffer> K i<cr><esc>
augroup END

" }}}

" Mappings: Help Files Shortcuts {{{

augroup filetype_help
	autocmd!
	autocmd FileType help noremap <buffer> q :q<cr>
augroup END

" }}}

" Mappings: Functions {{{

" To avoid typical typos after typing `:`
command! -bang Wq execute "wq" . ((<bang>0) ? "!" : "")
command! -bang Q execute "q" . ((<bang>0) ? "!" : "")
command! -bang Qa execute "qa" . ((<bang>0) ? "!" : "")

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

" Languages: TypeScript {{{

augroup filetype_typescript
	autocmd!
	" Highlight html templates
	autocmd FileType typescript JsPreTmpl html
	autocmd FileType typescript syn clear foldBraces
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

" Plugin Settings {{{

" Settings: ctrlp.vim {{{

set wildignore+=*/tmp/*,*.swp,*.zip,*.dll,*.exe,*.map,tags
let g:ctrlp_root_markers = ['package.json']
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/](\.git|node_modules|typings|vim80|bundle|[Bb]in|[Oo]bj|dist|out|undo)$',
			\ 'file': '\v\.(exe|dll|map)$',
			\ }

" }}}

" Settings: ctrlsf.vim (ag) {{{

let g:ctrlsf_default_root = 'project'
let g:ctrlsf_indent = 2

let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ "quit": "<F3>",
    \ }

let g:ctrlsf_ignore_dir = [
	\ "lib_bower",
	\ "node_modules",
	\ "dist",
	\ "bin"
	\]

" }}}

" Settings: syntastic {{{

if(exists('g:syntastic_version'))
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
endif

" }}}

" Settings: tsuquyomi {{{

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:tsuquyomi_use_vimproc = 1

" }}}

" Settings: vim-airline {{{

let g:airline_powerline_fonts = has('gui_running') || stridx(&shell, 'cmd.exe') == -1

let g:airline#extensions#default#layout = [
			\ [ 'a', 'c' ],
			\ [ 'b', 'error', 'warning' ]
			\ ]
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#obsession#enabled = 0
let g:airline#extensions#branch#format = 1

if(!exists('s:vimrc_airline_loaded'))
	let s:vimrc_airline_loaded = 1
else
	AirlineRefresh
endif

" }}}

" Settings: startify {{{

let g:startify_session_dir = '~/.vim/session'
let g:startify_custom_header = 'winwidth(0) > 64 ? map(startify#fortune#boxed(), "\"   \".v:val") : startify#fortune#quote()'
let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
			\ 'bundle[/\\].*[/\\]doc',
      \ '[/\\].vim[/\\]vim80',
      \ 'TextEditorAnywhere_',
      \ '.vimrc',
      \ '[/\\].git[/\\]',
      \ ]

" }}}

" Settings: vader.vim {{{

command! -bang -nargs=* -range -complete=file Test exec '<line1>,<line2>Vader<bang>' <q-args> | cclose

" }}}

" Settings: utl.vim {{{

if(stridx(expand('~/'), 'termux') != -1)
	let g:utl_cfg_hdl_scm_http = "silent !termux-open-url %u"
endif

" }}}

" Settings: goyo.vim / limelight.vim {{{

function! s:togglefullscreen()
	if(s:vimrc_gvimfullscreen_installed)
		call libcallnr(expand("$VIM") . "/bundle/gvimfullscreen_win32/gvimfullscreen_64.dll", "ToggleFullScreen", 0)
	endif
endfunction

autocmd! User GoyoEnter Limelight | set guioptions-=m | call s:togglefullscreen()
autocmd! User GoyoLeave Limelight! | set guioptions+=m | call s:togglefullscreen()

" }}}

" Settings: vim-json {{{

let g:vim_json_syntax_conceal = 0

" }}}

" Settings: vim-markdown {{{

let g:vim_markdown_new_list_item_indent = 0

" }}}

" Settings: netrw {{{

" Note: I use NERDtree, but when opening a folder it opens netrw by default
let g:netrw_liststyle = 3 " Tree View
let g:netrw_banner = 0 " Remove useless banner
let g:netrw_winsize = 25 " % width
let g:netrw_browse_split = 4 " Open files in previous window
let g:netrw_altv = 1 " Open in vertical split

" }}}

" Settings: ultisnips {{{


let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"

" }}}

" }}}

" Utilities {{{

function! s:make_buffer_temporary()
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
	nnoremap <buffer> q :qa<CR>
endfunction

" Split at cursor {{{
function! Utils_splitatcursor()
	normal! dGgg
	vsplit
	enew
	call s:make_buffer_temporary()
	normal! Vpgg<c-w>h
endfunction
" }}}

" Compare JSON in tests {{{
function! Utils_comparejsonintest()
	" Expected buffer
	e nunit_expected
	call s:make_buffer_temporary()
	" Paste
	normal! "+pgg0
	" Keep only 1st object, put 2nd in register
	exec "normal! d/{\<cr>%"
	s/>//e
	normal! jdG
  " Return to top of buffer
	normal! gg
	" Format as JSON if it is a JSON
	if(search('\"[a-zA-Z0-9_]\"\:', 'n') > 0)
		set filetype=json
	else
		set filetype=cs
	endif

	" Actual buffer
	vsplit nunit_actual
	call s:make_buffer_temporary()
	" Paste
	normal! Vp0
	" Remove everything else
	normal! dt{%
	s/>//e
	normal! jdG
  " Return to top of buffer
	normal! gg
	" Format as JSON if it is a JSON
	if(search('\"[a-zA-Z0-9_]\"\:', 'n') > 0)
		set filetype=json
	else
		set filetype=cs
	endif
	" Run diff on both buffers
	windo diffthis
	" Alloq quick quit with `q`
	nnoremap q :qa!<CR>
endfunction
" }}}

" Compare XML in tests {{{
function! Utils_comparexmlintest()
	" Expected buffer
	e nunit_expected.xml
	call s:make_buffer_temporary()
	" Paste
	normal! "+pgg0
	set filetype=xml
	" Remove <?xml ... ?>
	g/\v\<\?xml/d
	" Find beginning of XML
	execute "normal! gg0d/Expected\<cr>dt<"
	s/\v\<\</\</e
	" Go to the end of the XML block
	normal 0l%
	s/\v\>\>/\>/e
	s/\v\>"/\>/e
	execute "normal! \<cr>0"
	" Remove everything in between
	exec "normal! dt<"
	" Move everything else to new buffer
	exec "normal! dG"
	" Actual buffer
	vsplit nunit_actual.xml
	call s:make_buffer_temporary()
	" Paste
	normal! Vp0
	set filetype=xml
	" Fix object-type display (<<xml .../>>)
	s/\v\<\</\</e
	" Go to the end of the XML block
	normal 0l%
	s/\v\>\>/\>/e
	s/\v\>"/\>/e
	" Remove everything after the XML block
	normal! jdG
	" Run diff on both buffers
	windo diffthis
	" Allow quick quit with `q`
endfunction
" }}}

" }}}

" Machine Config {{{

if(filereadable(expand("~/.vimrc_private")))
	source ~/.vimrc_private
endif

" }}}
