" =======================================
" Basic Setup
" =======================================
set nocompatible " Don't be compatible with VI

" =======================================
" Load Vundle File
" =======================================
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" =======================================
" Leader
" =======================================
let mapleader = ","
let g:mapleader = ","

" =======================================
" Display
" =======================================
set linespace=3
set title
set cmdheight=1
set showtabline=2
set winwidth=100
set winheight=10
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
set scrolloff=8                " Lines to keep above and below the cursor
set sidescrolloff=15           " Columns to keep on either side of cursor
set backspace=indent,eol,start " Allow backspecing over everything in insert mode

" =======================================
" Per Project .vimrc
" =======================================
set exrc   " Load .vimrc in project directory
set secure " Disable unsafe commands in local .vimrc files

" =======================================
" Tabbing
" =======================================
set tabstop=2       " Number of spaces in 'soft' tabs
set softtabstop=2   " Number of spaces in 'soft' tabs
set shiftwidth=2    " For use with indent plugins and `tabstop` setting
set expandtab       " Use 'soft' tabs when using <Tab> character
set smarttab        " Smart tabbing
set autoindent      " Use indent level from current line for next line

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
set nobackup   " Do not make backup before over-writing file
set nowb       " Do not backup file before writing
set noswapfile " Do not save swapfiles for unsaved buffers

" =======================================
" Moving
" * Move around splits with <c-hjkl>
" * Move between tabs with <c-s-hl>
" =======================================
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-n> :bp<CR>
nnoremap <c-p> :bn<CR>
" nnoremap <c-s-h> :tabnext<CR>
" nnoremap <c-s-l> :tabprev<CR>

" =======================================
" Filetype detection
" =======================================
filetype plugin indent on

" =======================================
" Searching
" =======================================
highlight Search guibg=yellow guifg=black gui=underline
highlight Search ctermbg=yellow ctermfg=black cterm=underline

set showcmd
set incsearch
set hlsearch " Don't highlight results
" set ignorecase " Don't search by case

" =======================================
" Various
" =======================================
set go=-T         " Hide GUI toolbar
set noerrorbells  " Don't annoy me with error bells
set mousehide     " Hide the mouse
set mouse=n       " Allow 'mouse' navigation in Normal (n) mode
set splitbelow    " When splitting, set new file on the bottom
set hidden        " Hide hidden files
set number        " Show line numbers
set numberwidth=1 " Line number width

" =======================================
" Relative Line Numbers
" ---------------------------------------
"
" Always display current line number, but
" toggle the rest of the line numbers
" between relative and absolute.
" =======================================
function! RelativeLineNumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>rl :call RelativeLineNumberToggle()<CR>

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
nnoremap <leader>b :Tagbar<CR>
let g:tagbar_autofocus = 1

" ---------------------------------------
" -- syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" ---------------------------------------
" -- vim-fugitive
map <leader>gd  :Gvdiff<CR>
map <leader>gs  :Gstatus<CR>

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
" Mappings
" =======================================

" Truncating extra whitespace
autocmd BufWritePre * :%s/\s\+$//e

" ***************************************
" Global Shortcts
" ***************************************
nmap <space> :
nmap <space>w :w!<CR>
nmap :noh :noh<CR>

" ***************************************
" Text Replacement
" =======================================
" See http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text
" for more information
" ***************************************
nnoremap S "_diwP
vnoremap S "_dP

" ***************************************
" Buffer navigation
" ***************************************
nmap :bs :buffers
nmap <leader>bs :bs<CR>
nmap <leader>w :Bclose!<CR>
nmap <leader>q :bd!<CR>
nmap <leader>cb :ene<CR>:bw #<CR>

" ***************************************
" File shortcuts
" ***************************************

" -- Reload the current buffer from file on disk
nmap <leader>r :edit!<CR>
" -- Create a horizontal split
nmap <leader>s :sp<CR>
" -- Create a vertical split
nmap <leader>v :vsplit<CR>

" ***************************************
" Commonly mistyped commands
" ***************************************
nmap :W :w
nmap :W! :w!
nmap :Q :q
nmap :Q! :q!
nmap :Wq! :wq!
nmap :WQ! :wq!

" ***************************************
" A few convenient shortcuts
" ***************************************

" --- Make the current window the only one on the screen
nmap :one :on
" --- Convert Ruby 1.8 Hashes to Ruby 1.9
nmap :rhs :%s/:\([^ ]*\)\(\s*\)=>\s*/\1: /g<CR>
" --- Convert Ruby 1.9 Hashes to Ruby 1.8
nmap :hrs :%s/\([a-zA-Z][a-zA-Z0-9_]*\):\s\([^\,\}]*\)/:\1 => \2/g<CR>
" --- Clear all buffers and splits
nmap :clear :bufdo! bdelete!<CR>
" --- Replace all 'hard' tabs with 'soft' tabs
nmap <leader>rt :retab<CR>
" nmap <c-s-t> :%s/\s\+$//<CR>

" ***************************************
" Perforce commands
" ***************************************
" nmap <leader>pe :!p4 edit "%";<CR>
" nmap <leader>pa :!p4 add "%";<CR>
" nmap <leader>pr :!p4 revert "%";<CR>
" nmap <leader>pd :!p4 delete "%";<CR>

" ***************************************
" Managing .vimrc
" ***************************************
nmap <leader>m :source $MYVIMRC<CR>
nmap <leader>ev :e $MYVIMRC<CR>

" ***************************************
" Local machine overrides
" ***************************************
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
