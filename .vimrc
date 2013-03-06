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
" -- CommandT
let g:CommandTAlwaysShowDotFiles = 1
" -- ZenCoding
let g:user_zen_expandabbr_key = '<c-e>'

" quickfixopenall.vim
"Author:
"   Tim Dahlin
"
"Description:
"   Opens all the files in the quickfix list for editing.
"
"Usage:
"   1. Perform a vimgrep search
"       :vimgrep /def/ *.rb
"   2. Issue QuickFixOpenAll command
"       :QuickFixOpenAll

function!   QuickFixOpenAll()
    if empty(getqflist())
        return
    endif
    let s:prev_val = ""
    for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
            exec "edit " . s:curr_val
        endif
        let s:prev_val = s:curr_val
    endfor
endfunction

command! QuickFixOpenAll         call QuickFixOpenAll()

" ------------------------
" Filetype highlighting
" ------------------------
au BufNewFile,BufRead *.thor      set filetype=ruby
au BufNewFile,BufRead *.jbuilder  set filetype=ruby
au BufNewFile,BufRead *.dump      set filetype=sql
au BufNewFile,BufRead *.ctp       set filetype=php
au BufNewFile,BufRead *.erb       set filetype=eruby
au BufNewFile,BufRead *.rhtml     set filetype=eruby
au BufNewFile,BufRead Gemfile     set filetype=ruby
au BufNewFile,BufRead Guardfile   set filetype=ruby

" ------------------------
" System Clipboard
" ------------------------
set pastetoggle=<F2>
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
imap <C-v> :call setreg("\"",system("pbpaste"))<CR>p

" ------------------------
" Mappings
" ------------------------

" Truncating extra whitespace
:highlight ExtraWhitespace ctermbg=red guibg=red
nmap <leader>rew :match ExtraWhitespace /\s\+$/<cr>
nmap <leader>req :match<cr>

" Global Shortcts
nmap <space> :
nmap <space>w :w!<cr>
imap jk <Esc>

" Buffer navigation
nmap :B :b
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
nmap :one :on
nmap :rhs :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<cr>
nmap :clear :bufdo bdelete<cr>
nmap <c-s-t> :%s/\s\+$//<cr>
nmap <leader>rt :retab<cr>

" Perforce commands
nmap <leader>pe :!p4 edit "%";<cr>
nmap <leader>pa :!p4 add "%";<cr>
nmap <leader>pr :!p4 revert "%";<cr>
nmap <leader>pd :!p4 delete "%";<cr>

" CommantT mappings and options
set wildignore+=*tmp/**
nmap <leader><s-t> :CommandTBuffer<cr>
nmap <leader>f :CommandTFlush<cr>

" Edit the vimrc file

" source $MYVIMRC reloads the saved $MYVIMRC
:nmap <leader>se :source $MYVIMRC<cr>
:nmap <leader>ev :e $MYVIMRC<cr>
