syntax on
set noerrorbells				"disable beep on errors
set autoindent					"new lines inherit the indentation of previous lines
set smartindent
set shiftwidth=2
set nowrap
set number						"show line number
set relativenumber				"show line number on the current line and relative numbers on all other lines
set numberwidth=1
set background=dark
set smartcase					"automatically switch search to case-sensitive when search query contains an uppercase letter
set noswapfile
set showmatch               	"show matching brackets.
set laststatus=2				"always display the status bar
set statusline=%F%m%r%h%w\ %=%y\ %l\/%L\ \ %p%%
filetype on
filetype plugin on

" more natural vim splitting
set splitbelow
set splitright

" indendation settings
set tabstop=4                   "number of visual spaces per TAB
set softtabstop=4               "number of spaces in tab when editing
set expandtab                   "tabs are spaces

" search settings
set incsearch                   "search as characters are entered
set hlsearch                    "highlight matches
set ignorecase
set title
set history=1000
set shell:sh

nnoremap <F1> <nop>
nnoremap <BS> X
map <S-k> <Nop>
