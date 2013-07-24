" =======================================
" Basic Setup
" =======================================
set nocompatible        " Don't be compatible with VI

" =======================================
" Load Vundle File
" =======================================
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" =======================================
" Leaders
" =======================================
let mapleader = ","
let g:mapleader = ","

" =======================================
" Display
" =======================================
set linespace=3
set ruler
set title
set cmdheight=1
set showtabline=2
set winwidth=100
set colorcolumn=80
set nowrap

set list listchars=tab:»·,trail:·

set wildignore+=*tmp/**

" =======================================
" Theme
" =======================================
set background=dark
set guifont=Courier
syntax on
colorscheme desert

" =======================================
"  Vim's :! system bash
" =======================================
set shellcmdflag=-c

" =======================================
" Scrolling
" =======================================
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
set backspace=indent,eol,start " Allow backspecing over everything in insert mode

" =======================================
" Per Project .vimrc
" =======================================
set exrc
set secure " Disable unsafe commands in local .vimrc files

" =======================================
" Tabbing
" =======================================
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab " Smart tabbing
set autoindent

" =======================================
" Arrow Keys => For Newbies
" =======================================
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" =======================================
" History Length
" =======================================
set history=30

" =======================================
" Files
" =======================================
"
" Don't backup. Already using other forms of verion control.
set nobackup
set nowb
set noswapfile

" =======================================
" Moving
" * Move around splits with <c-hjkl>
" * Move between tabs with <c-s-hl>
" =======================================
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-n> :bn<cr>
nnoremap <c-p> :bp<cr>
" nnoremap <c-s-h> :tabnext<cr>
" nnoremap <c-s-l> :tabprev<cr>

" =======================================
" Filetype detection
" =======================================
filetype on
filetype plugin indent on

" =======================================
" Searching
" =======================================
set showcmd
set incsearch
set nohlsearch " Don't highlight results
set ignorecase " Don't search by case

" =======================================
" Various
" =======================================
set go=-T         " Hide GUI toolbar
set noerrorbells  " Don't annoy me with error bells
set mousehide     " Hide the mouse
set splitbelow    " When splitting, set new file on the bottom
set hidden        " Hide hidden files
set number        " Show line numbers
set numberwidth=1 " Line number width

function! RelativeLineNumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>rl :call RelativeLineNumberToggle()<cr>

" =======================================
" Plugin Configuration
" =======================================

" ---------------------------------------
" -- ZenCoding
let g:user_zen_expandabbr_key = '<c-e>'

" ---------------------------------------
" -- ctrlp.vim
let g:ctrlp_regexp = 1
let g:ctrlp_map = '<leader>t'
let g:ctrlp_show_hidden = 1
let g:ctrlp_root_markers = ['Gemfile']

" =======================================
" Filetype highlighting
" =======================================
au BufNewFile,BufRead *.thor      set filetype=ruby
au BufNewFile,BufRead *.jbuilder  set filetype=ruby
au BufNewFile,BufRead *.tasks     set filetype=ruby
au BufNewFile,BufRead *.dump      set filetype=sql
au BufNewFile,BufRead *.ctp       set filetype=php
au BufNewFile,BufRead *.erb       set filetype=eruby
au BufNewFile,BufRead *.rhtml     set filetype=eruby
au BufNewFile,BufRead Gemfile     set filetype=ruby
au BufNewFile,BufRead Guardfile   set filetype=ruby

" =======================================
" System Clipboard
" =======================================
set pastetoggle=<F2>
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
imap <C-v> :call setreg("\"",system("pbpaste"))<CR>p

" =======================================
" =======================================
" =======================================
" Mappings
" =======================================
" =======================================
" =======================================

" Truncating extra whitespace
autocmd BufWritePre * :%s/\s\+$//e

" =======================================
" Global Shortcts
" =======================================
nmap <space> :
nmap <space>w :w!<cr>
imap jk <Esc>

" =======================================
" Buffer navigation
" =======================================
nmap :bs :buffers
nmap <leader>bs :bs<cr>
nmap <leader>w :bd<cr>
nmap <c-w> :BD<cr>

" =======================================
" File shortcuts
" =======================================
nmap <leader>r :edit<cr>
nmap <leader>s :sp<cr>
nmap <leader>v :vsplit<cr>

" =======================================
" Still use commonly mistyped commands
" =======================================
nmap :W :w
nmap :W! :w!
nmap :Q :q
nmap :Q! :q!
nmap :Wq! :wq!
nmap :WQ! :wq!

" =======================================
" A few convenient shortcuts
" =======================================
nmap :one :on
nmap :rhs :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<cr>
nmap :clear :bufdo bdelete<cr>
nmap <c-s-t> :%s/\s\+$//<cr>
nmap <leader>rt :retab<cr>

" =======================================
" Perforce commands
" =======================================
" nmap <leader>pe :!p4 edit "%";<cr>
" nmap <leader>pa :!p4 add "%";<cr>
" nmap <leader>pr :!p4 revert "%";<cr>
" nmap <leader>pd :!p4 delete "%";<cr>

" =======================================
" Managing .vimrc
" =======================================
:nmap <leader>m :source $MYVIMRC<cr>
:nmap <leader>ev :e $MYVIMRC<cr>


" =======================================
" =======================================
" =======================================
" RSpec Mappings
"
map <leader>c :call RunCurrentSpecFile()<cr>
map <leader>s :call RunNearestSpec()<cr>
map <leader>l :call RunLastSpec()<cr>

function! RunCurrentSpecFile()
  if InSpecFile()
    let l:command = "rspec " . @%
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunNearestSpec()
  if InSpecFile()
    let l:command = "rspec " . @% . " -l " . line(".")
    call SetLastSpecCommand(l:command)
    call RunSpecs(l:command)
  endif
endfunction

function! RunLastSpec()
  if exists("t:last_spec_command")
    call RunSpecs(t:last_spec_command)
  endif
endfunction

function! InSpecFile()
  return match(expand("%"), "_spec.rb$") != -1
endfunction

function! SetLastSpecCommand(command)
  let t:last_spec_command = a:command
endfunction

function! RunSpecs(command)
  execute ":w\|!clear && echo " . a:command . " && echo && " . a:command
endfunction

" =======================================
" =======================================
" =======================================
