runtime bundle/vim-pathogen/autoload/pathogen.vim

" ------------------------
" Basic Setup
" ------------------------
set nocompatible        " Don't be compatible with VI
call pathogen#infect()  " Use pathogen plugin for better plugin management

" ------------------------
" Leaders
" ------------------------
let mapleader = ","
let g:mapleader = ","

" ------------------------
" Display
" ------------------------
set linespace=3
set guifont=Courier:h12
set ruler
set title
set cmdheight=2

" ------------------------
" Theme
" ------------------------
set background=dark
syntax on
colorscheme desert256

" ------------------------
" Scrolling
" ------------------------
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
set backspace=indent,eol,start " Allow backspecing over everything in insert mode

" ------------------------
" Per Project .vimrc
" ------------------------
set exrc
set secure " Disable unsafe commands in local .vimrc files

" ------------------------
" Tabbing
" ------------------------
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab " Smart tabbing
set autoindent

" ------------------------
" Arrow Keys => For Newbies
" ------------------------
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" History Length
set history=30

" Use bash instead of sh
" Pretty sure this is unnecessary because both are aliases in OSX
set shell=/bin/bash

" ------------------------
" Files
" ------------------------
"
" Don't backup. Already using
" other forms of verion control.
set nobackup
set nowb
set noswapfile

" ------------------------
" Moving
" * Move around splits with <c-hjkl>
" * Move between tabs with <c-s-hl>
" ------------------------
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" nnoremap <c-s-h> :tabnext<cr>
" nnoremap <c-s-l> :tabprev<cr>

" Turn on filetype detection
filetype on
filetype indent on
filetype plugin on

" ------------------------
" Searching
" ------------------------
set showcmd
set incsearch
set nohlsearch " Don't highlight results
set ignorecase " Don't search by case
set smartcase

" ------------------------
" Various
" ------------------------
set go=-T         " Hide GUI toolbar
set noerrorbells  " Don't annoy me with error bells
set mousehide     " Hide the mouse
set splitbelow    " When splitting, set new file on the bottom
set hidden        " Hide hidden files
set number        " Show line numbers

" ------------------------
" Plugin Configuration
" ------------------------
let g:CommandTAlwaysShowDotFiles = 1
let g:user_zen_expandabbr_key = '<c-e>'

" ------------------------
" Filetype highlighting
" ------------------------
au BufNewFile,BufRead *.thor      set filetype=ruby
au BufNewFile,BufRead *.jbuilder  set filetype=ruby
au BufNewFile,BufRead *.dump      set filetype=sql
au BufNewFile,BufRead *.ctp       set filetype=php
au BufNewFile,BufRead *.erb       set filetype=eruby
au BufNewFile,BufRead *.rhtml     set filetype=eruby

" ------------------------
" System Clipboard
" ------------------------
set pastetoggle=<F2>
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
imap <C-v> :call setreg("\"",system("pbpaste"))<CR>p

" ------------------------
" Mappings
" ------------------------

" Global Shortcts
nmap <space> :
nmap <space>w :w<cr>

" Buffer navigation
nmap :bs :buffers
nmap <leader>bs :bs<cr>
nmap <c-n> :bn<cr>
nmap <c-p> :bp<cr>
nmap <leader>w :bd<cr>

" File shortcuts
nmap <leader>s :sp<cr>
nmap <leader>r :edit<cr>
nmap <leader>v :vsplit<cr>

" Still use commonly mistyped commands
nmap :W :w
nmap :W! :w!
nmap :Q :q
nmap :Q! :q!
nmap :Wq! :wq!
nmap :WQ! :wq!

" A few convenient shortcuts
nmap <c-s-t> :%s/\s\+$//<cr>
nmap <leader>rt :retab<cr>
nmap :rhs :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<cr>
nmap :clear :bufdo bdelete
nmap <leader>co :!p4 edit "%";<cr>

" Flush the CommandT files
nmap <leader>f :CommandTFlush<cr>

" Edit the vimrc file
nnoremap <leader>ev :tabedit $MYVIMRC<cr>

" Source the vimrc file after saving it
if has ("autocmd")
  autocmd BufWritePost .vimrc source $MYVIMRC
endif

" ------------------------
" Truncating extra whitespace
" ------------------------
:highlight ExtraWhitespace ctermbg=red guibg=red
nmap <leader>tw :match ExtraWhitespace /\s\+$/<cr>
nmap <leader>mo :match<cr>
