# VIMRC Plugins

## Deactivated plugins

```viml
" Show the undo tree
" Use `<leader>u` to open tree
Plug 'sjl/gundo.vim'
```

```viml
" Fuzzy finding
" `:FZF`, `:(G)Files`, `:Buffers`, `:Ag`, `:(B)Lines`, `:History`, `:Commands`
" More information: https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf.vim'
```

```viml
" Operates on search patterns
" Search, and use `:Grey` to yank matching lines
Plug 'kana/vim-grex'
```

```viml
" Snippets
" see ~/.vim/snippets, use `<Tab>` to autocomplete
if has('python')
	Plug 'SirVer/ultisnips'
endif
```

```viml
" Align columns
" Run `:Tabularize /<char>` to align text blocks
Plug 'godlygeek/tabular'
```

```viml
" Sums a list of numbers
" Run with `<leader>su`
Plug 'vim-scripts/visSum.vim'
```

```viml
Plug 'Quramy/tsuquyomi'
```

```viml
" Plugins: Fun & Games {{{

" A text-based roguelike
" Launch with `:Vimcastle`
Plug 'christianrondeau/vimcastle'

" }}}
```
