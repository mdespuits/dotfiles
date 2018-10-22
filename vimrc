" =======================================
" Basic Setup
" =======================================
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

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

set cursorline

set shortmess=a
set cmdheight=2

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
set wildignore+=*/tmp/*

" Ignore node modules
set wildignore+=node_modules/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Disable osx index files
set wildignore+=.DS_Store

" =======================================
" Theme/Styling
" =======================================
syntax on
set background=dark

call minpac#add('morhetz/gruvbox')
colorscheme gruvbox

" Allow direnv environment handling
call minpac#add('direnv/direnv.vim')

" =======================================
"  Vim's :! system bash
" =======================================
set shellcmdflag=-c

" =======================================
" Scrolling
" =======================================
set scrolloff=8                " Lines to keep above and below the cursor
set sidescrolloff=15           " Columns to keep on either side of cursor

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

" =======================================
" Arrow Keys Are Not Allowed
" =======================================
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>

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
" Movement
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
  " Make escape work in the Neovim terminal.
  tnoremap <Esc> <C-\><C-n>

  " Make navigation into and out of Neovim terminal splits nicer.
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l

  " I like relative numbering when in normal mode.
  autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 relativenumber

  " Prefer Neovim terminal insert mode to normal mode.
  autocmd BufEnter term://* startinsert

  set inccommand=nosplit
  set notagbsearch
else
  " When classic Vim is in use
endif

set belloff=all
set history=3000               " History Length
set backspace=indent,eol,start " Allow backspecing over everything in insert mode
set autoread                   " Automatically read files from disk when detected
set smarttab                   " Smart tabbing
set autoindent                 " Use indent level from current line for next line
set ruler

filetype plugin indent on " Filetype detection

" =======================================
" Statusline Setup
" =======================================
call minpac#add('itchyny/lightline.vim')
set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ }
      \ }

if !has('gui_running')
  set t_Co=256
endif

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
set mousehide     " Hide the mouse
set mouse=n       " Allow 'mouse' navigation in Normal (n) mode
set splitbelow    " When splitting, set new file on the bottom
set hidden        " Hide hidden files
set number        " Show line numbers
set numberwidth=1 " Line number width

" =======================================
" Relative Line Numbers
" ---------------------------------------
" Stolen directly from https://github.com/jeffkreeftmeijer/vim-numbertoggle
" =======================================
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter   * if &nu | set nornu | endif
augroup END

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

function! DeleteInactiveBufs()
  "From tabpagebuflist() help, get a list of all buffers in all tabs
  let tablist = []
  for i in range(tabpagenr('$'))
    call extend(tablist, tabpagebuflist(i + 1))
  endfor

  "Below originally inspired by Hara Krishna Dara and Keith Roberts
  "http://tech.groups.yahoo.com/group/vim/message/56425
  let nWipeouts = 0
  for i in range(1, bufnr('$'))
    if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
      "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
      silent exec 'bwipeout' i
      let nWipeouts = nWipeouts + 1
    endif
  endfor
  echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()

function! DeleteAllBufs()
  "From tabpagebuflist() help, get a list of all buffers in all tabs
  let tablist = []
  for i in range(tabpagenr('$'))
    call extend(tablist, tabpagebuflist(i + 1))
  endfor

  "Below originally inspired by Hara Krishna Dara and Keith Roberts
  "http://tech.groups.yahoo.com/group/vim/message/56425
  let nWipeouts = 0
  for i in range(1, bufnr('$'))
    if bufexists(i) && !getbufvar(i,"&mod")
      "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
      silent exec 'bwipeout' i
      let nWipeouts = nWipeouts + 1
    endif
  endfor
  echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bda :call DeleteAllBufs()

" =======================================
" Plugin Configuration
" =======================================

call minpac#add('airblade/vim-gitgutter')

" Tim Pope!
call minpac#add('tpope/vim-abolish')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-eunuch')
" call minpac#add('tpope/vim-dispatch')
" call minpac#add('jgdavey/tslime.vim')

call minpac#add('editorconfig/editorconfig-vim')

" ---------------------------------------
" -- Navigation/Editing
" ---------------------------------------
call minpac#add('chrismccord/bclose.vim')
" call minpac#add('rking/ag.vim')
call minpac#add('jiangmiao/auto-pairs')

" ---------------------------------------
" -- Language Support
" ---------------------------------------
call minpac#add('othree/html5.vim')
call minpac#add('pangloss/vim-javascript')
call minpac#add('honza/vim-snippets')
call minpac#add('posva/vim-vue')

" Ruby-specific stuff
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rake')
call minpac#add('sunaku/vim-ruby-minitest')
call minpac#add('kana/vim-textobj-user') " vim-textobj-rubyblock dependeny
call minpac#add('nelstrom/vim-textobj-rubyblock')
call minpac#add('janko-m/vim-test')

call minpac#add('elixir-lang/vim-elixir', {'type': 'opt'})
call minpac#add('rust-lang/rust.vim', {'type': 'opt'})
call minpac#add('ap/vim-css-color', {'type': 'opt'})
call minpac#add('hail2u/vim-css3-syntax', {'type': 'opt'})

" ---------------------------------------
" -- vim-coffee-script
call minpac#add('kchmck/vim-coffee-script')

" ---------------------------------------
" -- vim-snipmate
call minpac#add('tomtom/tlib_vim')
call minpac#add('MarcWeber/vim-addon-mw-utils')
call minpac#add('garbas/vim-snipmate')

" -- vim-jsx
call minpac#add('mxw/vim-jsx')
let g:jsx_ext_required = 0

" ---------------------------------------
" -- Emmet
call minpac#add('mattn/emmet-vim')
let g:user_emmet_expandabbr_key = '<c-e>'

" ---------------------------------------
" -- Indent Guides
call minpac#add('nathanaelkane/vim-indent-guides')
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 2

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black ctermbg=232
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=233

" ---------------------------------------
" -- Ale
call minpac#add('w0rp/ale')
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

let g:ale_linters = {
\  'ruby': ['rubocop', 'ruby'],
\  'javascript': ['eslint'],
\  'scss': []
\}

" \  'javascript': ['eslint', 'remove_trailing_lines', 'trim_whitespace'],
let g:ale_fixers = {
\  'javascript': ['remove_trailing_lines', 'trim_whitespace'],
\  'json': ['prettier'],
\  'ruby': ['rubocop'],
\  'html': ['remove_trailing_lines', 'trim_whitespace'],
\  'vue': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
\  'scss': ['remove_trailing_lines', 'trim_whitespace']
\}

" let g:ale_fixer_aliases = { 'erb': 'html' }

let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_signs = 1
let g:ale_sign_column_always = 0
let g:ale_sign_offset = 50000

" ---------------------------------------
" -- vim-ruby
call minpac#add('vim-ruby/vim-ruby')
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

" ---------------------------------------
" -- vim-fugitive
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb') " For using :Gbrowse
map <leader>gd  :Gvdiff<CR>
map <leader>gs  :Gstatus<CR>

" Remove fugitive buffers completely when done
autocmd BufReadPost fugitive://* set bufhidden=delete


" ---------------------------------------
" -- vim-rspec
" call minpac#add('thoughtbot/vim-rspec')

" map <leader>c :call RunCurrentSpecFile()<CR>
" map <leader>n :call RunNearestSpec()<CR>
" map <leader>l :call RunLastSpec()<CR>
" map <leader>a :call RunAllSpecs()<CR>
" let g:rspec_command = '!rspec {spec} --color'

" ---------------------------------------
" -- vim-textobj-rubyblock
runtime macros/matchit.vim

" ---------------------------------------
" -- vim-go
call minpac#add('fatih/vim-go', {'type': 'opt'})
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

augroup GoFile
  autocmd!
  autocmd filetype go call SetGoOPtions()
  autocmd filetype go nnoremap <leader>rg :! go run %<cr>
augroup END

" ---------------------------------------
" -- Tabularize
call minpac#add('godlygeek/tabular')
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" ---------------------------------------
" -- fzf
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')

nmap <leader>t :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader><S-T> :BTags<CR>

let g:fzf_layout = { 'window': 'enew' }

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
au BufNewFile,BufRead .stylelintrc set filetype=json

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
" nnoremap S "_diwP
" vnoremap S "_dP

" ***************************************
" Buffer navigation
" ***************************************
nmap :bs :buffers<CR>
nmap <leader>w :Bclose<CR>
nmap <leader>W :close<CR>
nmap <leader>q :bwipeout!<CR>
nmap <leader>cb :ene<CR>:bw #<CR>
nmap <leader>lc :lclose<CR>
nmap <leader>lo :lopen<CR>
nmap :clear :Bda<CR>

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

" --- Convert Ruby 1.8 Hashes to Ruby 1.9
nmap :rhs :%s/:\([^ ]*\)\(\s*\)=>\s*/\1: /g<CR>
" --- Convert Ruby 1.9 Hashes to Ruby 1.8
nmap :hrs :%s/\([a-zA-Z][a-zA-Z0-9_]*\):\s\([^\,\}]*\)/:\1 => \2/g<CR>
" --- Replace all 'hard' tabs with 'soft' tabs
nmap <leader>rt :retab!<Return>

" ***************************************
" Managing .vimrc
" ***************************************
nmap <leader>m :source $MYVIMRC<CR>
nmap <leader>ev :e $MYVIMRC<CR>

" ***************************************
" Managing Sessions
" ***************************************
nmap <F2> :source ~/vim-sessions/current.vim<CR>
nmap <F3> :wa<Bar>exe "mksession! ~/vim-sessions/current.vim"<CR>
nmap <F4> :silent! rm -rf ~/vim-sessions/current.vim<CR>

" ***************************************
" Local machine overrides
" ***************************************
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
