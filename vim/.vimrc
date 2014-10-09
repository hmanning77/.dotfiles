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

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set encoding=utf-8
set rtp+=/home/hugh/Software/Source/powerline/powerline/bindings/vim
set laststatus=2

let mapleader=' '

nmap <leader>p :set paste!<CR>
nmap <leader>h :nohlsearch<CR>
nmap <leader>n :set number!<CR>
nmap <leader>w :set wrap!<CR>
nmap <leader>b :TagbarToggle<CR>

set foldmethod=marker

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set ruler

set incsearch
set hlsearch
set smartcase

nnoremap j gj
nnoremap k gk

nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-h> <C-w><C-h>
nmap <C-l> <C-w><C-l>
