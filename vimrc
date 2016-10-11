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
set ruler

set cursorline

set shortmess=a
set cmdheight=2

" set list listchars=tab:»·,trail:·

set wildignore+=*tmp/**
set wildignore+=*coverage

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Ignore images and log files
set wildignore+=*.gif,*.jpg,*.png,*.log

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore custom folders
set wildignore+=*/resources/*

" Ignore custom folders
set wildignore+=*/tmp/*

" Ignore node modules
set wildignore+=node_modules/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Disable osx index files
set wildignore+=.DS_Store

" =======================================
" Theme
" =======================================
set background=dark
set guifont=Courier
syntax on
colorscheme gotham256

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
set autoread        " Automatically read files from disk when detected

" =======================================
" Arrow Keys => For Newbies
" =======================================
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>

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
set shortmess=aWtI

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
" Neovim-specific configuration
" =======================================
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

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

" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
  call Preserve('normal gg=G')
endfunction

" =======================================
" Plugin Configuration
" =======================================

" ---------------------------------------
" -- vim-jsx
let g:jsx_ext_required = 0

" ---------------------------------------
" -- ZenCoding
let g:user_emmet_expandabbr_key = '<c-e>'

" ---------------------------------------
" -- Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 2

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black ctermbg=232
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=233

" ---------------------------------------
" -- Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_java_checkers = []
let g:syntastic_eruby_checkers = []
let g:syntastic_scss_checkers = []

" highlight SyntasticError guibg=#2f0000

" ---------------------------------------
" -- vim-ruby
let g:ruby_indent_access_modifier_style = 'indent'

" Regex used for words, that, at the start of a line, remove a level of indent
setlocal indentkeys+==module_function
let g:indent_access_modifier_regex = '\C^\s*\%(module_function\|protected\|private\)\s*\%(#.*\)\=$''))'
let s:ruby_indent_keywords =
      \ '^\s*\zs\<\%(module\||module_function\|class\|if\|for' .
      \   '\|while\|until\|else\|elsif\|case\|when\|unless\|begin\|ensure\|rescue' .
      \   '\|\%(module_function\|public\|protected\|private\)\=\s*def\):\@!\>' .
      \ '\|\%([=,*/%+-]\|<<\|>>\|:\s\)\s*\zs' .
      \    '\<\%(if\|for\|while\|until\|case\|unless\|begin\):\@!\>'

" ***************************************
" vim-github-dashboard
" ***************************************
let g:github_dashboard = { 'username': $GITHUB_USERNAME, 'password': $GITHUB_TOKEN  }

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
let g:airline_theme = "gotham256"
let g:airline_section_b = '%{fugitive#head()}'

" ---------------------------------------
" -- Tagbar
" nnoremap <leader>b :Tagbar<CR>
" nnoremap <space>tt :TagbarToggle f<cr>
let g:tagbar_autofocus = 1

" ---------------------------------------
" -- syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

" ---------------------------------------
" -- vim-fugitive
map <leader>gd  :Gvdiff<CR>
map <leader>gs  :Gstatus<CR>

" Remove fugitive buffers completely when done
autocmd BufReadPost fugitive://* set bufhidden=delete

" ---------------------------------------
" -- vim-rspec
" map <leader>c :call RunCurrentSpecFile()<CR>
" map <leader>n :call RunNearestSpec()<CR>
" map <leader>l :call RunLastSpec()<CR>
" map <leader>a :call RunAllSpecs()<CR>
" let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec} --format progress\n")'

" ---------------------------------------
" -- vim-textobj-rubyblock
runtime macros/matchit.vim

" ---------------------------------------
" -- NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>

" ---------------------------------------
" -- vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

function! SetGoOPtions()
  :call tagbar#autoopen(0)
endfunction

augroup GoFile
  autocmd!
  autocmd filetype go call SetGoOPtions()
  autocmd filetype go nnoremap <leader>rg :! go run %<cr>
augroup END

" ---------------------------------------
" -- pick.vim
nmap <Leader>t  :call PickFile()<CR>
nmap <Leader>fs :call PickFileSplit()<CR>
nmap <Leader>fv :call PickFileVerticalSplit()<CR>
nmap <Leader>b  :call PickBuffer()<CR>
nmap <Leader>]  :call PickTag()<CR>

" ---------------------------------------
" -- ctrlp.vim
" let g:ctrlp_regexp = 1
" let g:ctrlp_map = '<leader>t'
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_root_markers = ['Gemfile']
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" if executable('ag')
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" endif

" " ---------------------------------------
" " -- ctrlp-funky
" nnoremap <Leader>fu :CtrlPFunky<Cr>
" " narrow the list down with a word under cursor
" nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" =======================================
" Filetype highlighting
" =======================================
au BufNewFile,BufRead *.svg       set filetype=html
au BufNewFile,BufRead *.thor      set filetype=ruby
au BufNewFile,BufRead *.cap       set filetype=ruby
au BufNewFile,BufRead *.jbuilder  set filetype=ruby
au BufNewFile,BufRead *.tasks     set filetype=ruby
au BufNewFile,BufRead *.dump      set filetype=sql
au BufNewFile,BufRead *.ctp       set filetype=php
au BufNewFile,BufRead *.erb       set filetype=eruby
au BufNewFile,BufRead *.rhtml     set filetype=eruby
au BufNewFile,BufRead Guardfile   set filetype=ruby
au BufNewFile,BufRead Capfile     set filetype=ruby
au BufNewFile,BufRead .pryrc      set filetype=ruby
au BufNewFile,BufRead pryrc       set filetype=ruby
au BufNewFile,BufRead *.{md,markdown,mdown,mkd,mkdn,txt} set filetype=markdown
au BufNewFile,BufRead Gemfile     set filetype=ruby
au BufNewFile,BufRead *.es6       set filetype=javascript.jsx

au FileType GO setlocal shiftwidth=2 tabstop=2 noexpandtab
au FileType java setlocal shiftwidth=4

augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

let &colorcolumn="100"
highlight ColorColumn ctermbg=234 guibg=#2c2d27

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

" Resize windows within terminal and tmux
autocmd VimResized * :wincmd =

" ***************************************
" Global Shortcts
" ***************************************
nmap <space> :
nmap <space>w :w!<CR>
nmap ; :
nmap :noh :noh<CR>
nmap :Noh :noh<CR>

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
nmap <leader>w :Bclose<CR>
nmap <leader>q :bd!<CR>
nmap <leader>cb :ene<CR>:bw #<CR>
nmap <leader>lc :lclose<CR>
nmap <leader>lo :lopen<CR>

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
