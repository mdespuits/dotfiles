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
set wildignore+=*coverage

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
nnoremap <c-n> :bp<cr>
nnoremap <c-p> :bn<cr>
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
set mouse=n
set splitbelow    " When splitting, set new file on the bottom
set hidden        " Hide hidden files
set number        " Show line numbers
set numberwidth=1 " Line number width

" =======================================
" Relative Line Numbers
" =======================================
function! RelativeLineNumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
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
let g:user_emmet_expandabbr_key = '<c-e>'

" ---------------------------------------
" -- Indent Guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1

" ---------------------------------------
" -- Airline Config
set laststatus=2
" set fillchars+=stl:\ ,stlnc:\
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
let g:airline_symbols.space = "\ua0"

" ---------------------------------------
" -- Tagbar
nnoremap <leader>b :Tagbar<cr>
let g:tagbar_autofocus = 1

" ---------------------------------------
" -- syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" ---------------------------------------
" -- vim-rspec
map <leader>c :call RunCurrentSpecFile()<CR>
map <leader>n :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec} --format progress\n")'

" ---------------------------------------
" -- vim-textobj-rubyblock
runtime macros/matchit.vim

" ---------------------------------------
" -- ctrlp.vim
" let g:ctrlp_regexp = 1
let g:ctrlp_map = '<leader>t'
let g:ctrlp_show_hidden = 1
let g:ctrlp_root_markers = ['Gemfile']

" =======================================
" Filetype highlighting
" =======================================
au BufNewFile,BufRead *.thor      set filetype=ruby
au BufNewFile,BufRead *.cap       set filetype=ruby
au BufNewFile,BufRead *.jbuilder  set filetype=ruby
au BufNewFile,BufRead *.tasks     set filetype=ruby
au BufNewFile,BufRead *.dump      set filetype=sql
au BufNewFile,BufRead *.ctp       set filetype=php
au BufNewFile,BufRead *.erb       set filetype=eruby
au BufNewFile,BufRead *.rhtml     set filetype=eruby
au BufNewFile,BufRead Gemfile     set filetype=ruby
au BufNewFile,BufRead Guardfile   set filetype=ruby
au BufNewFile,BufRead Capfile     set filetype=ruby

au FileType GO setlocal shiftwidth=2 tabstop=2 noexpandtab

" =======================================
" System Clipboard
" =======================================
if $TMUX == ''
  set clipboard+=unnamed
endif
set pastetoggle=<F2>

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
nmap <leader>w :bd!<cr>
nmap <leader>cb :ene<CR>:bw #<CR>

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
nmap :rhs :%s/:\([^ ]*\)\(\s*\)=>\s*/\1: /g<cr>
nmap :clear :bufdo! bdelete<cr>
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
nmap <leader>m :source $MYVIMRC<cr>
nmap <leader>ev :e $MYVIMRC<cr>
