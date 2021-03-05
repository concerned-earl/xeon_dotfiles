" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

set noerrorbells

syntax on
set backspace=2
set autoindent
set smartindent
set shiftwidth=2
set nowrap
set number
set nocompatible
set background=dark
set smartcase
set noswapfile
set numberwidth=1

set statusline=%F%m%r%h%w\ %=%y\ %l\/%L\ \ %p%%
set laststatus=2

filetype on
filetype plugin on

" more natural vim splitting

set splitbelow
set splitright

" indendation settings

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

" search settings

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase
set title

set history=1000
set shell:bash

nnoremap <F1> <nop>
map <S-k> <Nop>
