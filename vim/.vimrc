"""
""" PLUGINS
"""
set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'

Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

Plug 'tweekmonster/braceless.vim'
Plug 'wting/rust.vim'

Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'kien/rainbow_parentheses.vim', { 'on': 'RainbowParenthesesActivate' }

Plug 'chriskempson/base16-vim'

call plug#end()

filetype plugin indent on


"""
""" EDITING OPTIONS
"""
set encoding=utf-8

" Use standard expanded tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Use some automatic tabbing
set smarttab


"""
""" AUTOCMDS
"""

" Use braceless.vim for indented languages
autocmd FileType python BracelessEnable +indent +fold

" Stop netrw buffers from hanging around
autocmd FileType netrw setl bufhidden=delete

"""
""" BEHAVIOUR
"""

" Sensible search:
" Start searching as soon as you type
set incsearch
" Highlight search matches
set hlsearch
" Search is case insensitive unless you use uppercase letters
set smartcase

" Ignore octal for inc/decrement with C-a and C-x
set nrformats-=octal

" Allow buffers with unsaved changes to be kept in the background
set hidden
" Allow backspace to work over newlines
set backspace=indent,eol,start
" Fold at markers if they are present
set foldmethod=marker
" Show a menu on the command buffer when there are multiple options
set wildmenu
" Keep at least three lines above/below the cursor whenever possible
set scrolloff=3
" Automatically read changes made to files outside of vim without asking
set autoread
" Wrap lines at word boundaries
set linebreak


"""
""" APPEARANCE
"""

set laststatus=2
set noshowmode
set showtabline=2
set showcmd
set number

set ruler

"Syntax highlighting
syntax enable
set background=dark
" Use base16colorspace=256 when base16-shell is in use to modify the 256
" colorspace
"let base16colorspace=256
" Use set termguicolors when the terminal supports true color
set termguicolors
colorscheme base16-atelier-forest

"Status bar
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

set listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:+


"""
""" KEYBINDINGS
"""
" Space master race
let mapleader=' '

" General purpose toolbox
" Toggle paste mode; causes vim to enter text as typed (or pasted) rather than
" autoindenting, etc
nmap <leader>p :setlocal paste!<CR>
" Clear search hilighting
nmap <leader>h :nohlsearch<CR>
" Toggle line numbers
nmap <leader>n :set number!<CR>

" Summon/dismiss the tagbar window
nmap <leader>b :TagbarToggle<CR>

" Make j/k behave on screen lines rather than true lines
nnoremap j gj
nnoremap k gk

" Make Y act consistenly with C, D etc
nmap Y y$

" Shorter window switching
nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-h> <C-w><C-h>
nmap <C-l> <C-w><C-l>

" Fast buffer switching
nmap <C-n> :bn<CR>
nmap <C-p> :bp<CR>


"""
""" GUI SPECIFIC OPTIONS
"""

if has("gui_running")
    " No toolbar, please
    set guioptions-=T
endif

