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

" general
Plugin 'flazz/vim-colorschemes'
Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-classpath'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
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
colorscheme 256-jungle
"colorscheme desert256
"set background=dark
hi Normal ctermbg=none

set backspace=2
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" C-specific indent rules
autocmd FileType c setlocal expandtab
autocmd FileType c setlocal shiftwidth=4
autocmd FileType c setlocal softtabstop=4
autocmd FileType c setlocal tabstop=4

" C-specific indent rules
autocmd FileType ino setlocal expandtab
autocmd FileType ino setlocal shiftwidth=4
autocmd FileType ino setlocal softtabstop=4
autocmd FileType ino setlocal tabstop=4

set number

" Ultisnips trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:sclangTerm="urxvt -hold -e"
