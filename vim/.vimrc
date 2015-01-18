"""
""" PLUGINS
"""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'altercation/vim-colors-solarized'
Plugin 'wting/rust.vim'
Plugin 'tpope/vim-vinegar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"""
""" EDITING OPTIONS
"""
set encoding=utf-8

" Use standard tabbing
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab


"""
""" BEHAVIOUR
"""

" Sensible search
set incsearch
set hlsearch
set smartcase

" Ignore octal for inc/decrement with C-a and C-x
set nrformats-=octal

set hidden
set backspace=indent,eol,start
set foldmethod=marker
set wildmenu
set scrolloff=3
set autoread


"""
""" APPEARANCE
"""

" Set up status bar
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

set laststatus=2
set noshowmode
set showtabline=2
set showcmd
set number

set ruler

"Syntax highlighting
syntax enable
set background=dark
colorscheme solarized

set listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:+


"""
""" KEYBINDINGS
"""
" Space master race
let mapleader=' '

" General purpose toolbox
nmap <leader>p :set paste!<CR>
nmap <leader>h :nohlsearch<CR>
nmap <leader>n :set number!<CR>
nmap <leader>w :set wrap!<CR>
nmap <leader>b :TagbarToggle<CR>

" Make j/k behave on screen lines rather than true lines
nnoremap j gj
nnoremap k gk

" Shorter window switching
nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-h> <C-w><C-h>
nmap <C-l> <C-w><C-l>


