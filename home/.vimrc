set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My Plugins here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'sjl/badwolf'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'sbl/scvim'
Plugin 'godlygeek/tabular'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'munshkr/vim-tidal'
Plugin 'jpalardy/vim-slime'

" ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'

" haskell
"Plugin 'lukerandall/haskellmode-vim'

" example: vim-scripts repos
"Plugin 'L9'
"Plugin 'FuzzyFinder'

" example: non github repos
"Plugin 'git://git.wincent.com/command-t.git'

" example: git repos on your local machine (ie. when working on your own plugin)
"Plugin 'file:///Users/gmarik/path/to/plugin'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on

set t_Co=256

"colorscheme 256-jungle
"colorscheme desert256
colorscheme badwolf

set background=dark
hi Normal ctermbg=none

set backspace=2
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

augroup arduino
  autocmd!
  autocmd BufRead,BufNewFile *.ino set filetype=arduino
  " old extension .pde
  autocmd BufRead,BufNewFile *.pde set filetype=arduino
augroup END

" C-specific indent rules
augroup c-group
  autocmd!

  autocmd FileType c setlocal expandtab
  autocmd FileType c setlocal shiftwidth=2
  autocmd FileType c setlocal softtabstop=2
  autocmd FileType c setlocal tabstop=2

  autocmd FileType arduino setlocal expandtab
  autocmd FileType arduino setlocal shiftwidth=4
  autocmd FileType arduino setlocal softtabstop=4
  autocmd FileType arduino setlocal tabstop=4
augroup END

set number

" Ultisnips trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

"let g:sclangTerm="urxvt -e"
let g:sclangTerm="gnome-terminal -x $SHELL -ic"

" Set status bar from vim-airline all the time
set laststatus=2

let mapleader="\\"
let maplocalleader=","

set hlsearch
set mouse=a
set columns=80
set relativenumber

" Highlight long lines (I like this better than using colorcolumn)
highlight OverLength ctermbg=darkred ctermfg=gray guibg=#592929
match OverLength /\%81v.\+/

highlight ExtraWhitespace ctermbg=darkred guibg=#592929
match ExtraWhitespace /\s\+$/

" X11 clipboard support using xsel
" Source: http://vim.wikia.com/wiki/Accessing_the_system_clipboard#Simple_workaround_for_X_clipboards
"
" Usage: select with visual block, :<,>cz
" Buffers:
" - z: Clipboard
" - x: Primary Selection
" - v: Secondary Selection
"
command! -range Cz :silent :<line1>,<line2>w !xsel -i -b
command! -range Cx :silent :<line1>,<line2>w !xsel -i -p
command! -range Cv :silent :<line1>,<line2>w !xsel -i -s
cabbrev cv Cv
cabbrev cz Cz
cabbrev cx Cx

command! -range Pz :silent :r !xsel -o -b
command! -range Px :silent :r !xsel -o -p
command! -range Pv :silent :r !xsel -o -s

cabbrev pz Pz
cabbrev px Px
cabbrev pv Pv

" Tabularize mappings
" Source: http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
"
if exists(":Tabularize")
  nnoremap <leader>a= :Tabularize /=<CR>
  vnoremap <leader>a= :Tabularize /=<CR>
  nnoremap <leader>a: :Tabularize /:\zs<CR>
  vnoremap <leader>a: :Tabularize /:\zs<CR>
endif

" Edit this .vimrc in a split
nnoremap <leader>ev :tabe $MYVIMRC<cr>
" Source this .vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap H 0
nnoremap L $

let g:slime_preserve_curpos=1
