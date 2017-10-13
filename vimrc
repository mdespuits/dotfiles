" =======================================
" Basic Setup
" =======================================
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

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
set nocompatible               " Don't be compatible with VI
set ruler

filetype plugin indent on " Filetype detection

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

call minpac#add('airblade/vim-gitgutter')

" Tim Pope!
call minpac#add('tpope/vim-abolish')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-haml', {'type': 'opt'})
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
call minpac#add('mengbo/vim-dash')
" Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" ---------------------------------------
" -- Language Support
" ---------------------------------------
call minpac#add('othree/html5.vim')
call minpac#add('mustache/vim-mustache-handlebars')
call minpac#add('pangloss/vim-javascript')
call minpac#add('slim-template/vim-slim', {'type': 'opt'})
call minpac#add('honza/vim-snippets')
call minpac#add('posva/vim-vue', {'type': 'opt'})

" Ruby-specific stuff
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rake')
call minpac#add('sunaku/vim-ruby-minitest')
call minpac#add('ngmy/vim-rubocop', {'type': 'opt'})
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
call minpac#add('mxw/vim-jsx', { 'type': 'opt' })
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
" -- Syntastic
call minpac#add('scrooloose/syntastic')
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_java_checkers = []
let g:syntastic_eruby_checkers = ['ruby']
" let g:syntastic_scss_checkers = ['mixedindentlint', 'scssc', 'scss_lint']
let g:syntastic_scss_checkers = ['mixedindentlint', 'scssc']
let g:syntastic_scss_scss_lint_args = "-x StringQuotes"
let g:syntastic_mode_map = { "mode": "active" }

highlight SyntasticError guibg=#2f0000

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
" -- Tagbar
" nnoremap <leader>b :Tagbar<CR>
" nnoremap <space>tt :TagbarToggle f<cr>
" let g:tagbar_autofocus = 1

" ---------------------------------------
" -- vim-fugitive
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb') " For using :Gbrowse
map <leader>gd  :Gvdiff<CR>
map <leader>gs  :Gstatus<CR>

" Remove fugitive buffers completely when done
autocmd BufReadPost fugitive://* set bufhidden=delete

" ---------------------------------------
" -- Airline Config
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')

set laststatus=2
" set fillchars+=stl:\ ,stlnc:\
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme = "simple"
let g:airline_section_b = '%{fugitive#head()}'

" ---------------------------------------
" -- vim-rspec
" call minpac#add('thoughtbot/vim-rspec')

" map <leader>c :call RunCurrentSpecFile()<CR>
" map <leader>n :call RunNearestSpec()<CR>
" map <leader>l :call RunLastSpec()<CR>
" map <leader>a :call RunAllSpecs()<CR>
" let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec} --format progress\n")'

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

function! SetGoOPtions()
  " :call tagbar#autoopen(0)
endfunction

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

if has("nvim")
  " -- ctrlp.vim
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')

  " let g:fzf_action = {
  " \ 'ctrl-t': 'split',
  " \ 'ctrl-x': 'split',
  " \ 'ctrl-v': 'vsplit' }

  " nmap <Leader>t :Files<CR>


  " let g:fzf_layout = { 'up': '~40%' }
  let g:fzf_layout = { 'window': 'enew' }

  " command! -bang -nargs=? -complete=dir Files
  " \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  nmap <leader>t :Files<CR>
  nmap <leader>b :Buffers<CR>
  " call minpac#add('ctrlpvim/ctrlp.vim')
  " " let g:ctrlp_regexp = 1
  " let g:ctrlp_map = '<leader>t'
  " let g:ctrlp_working_path_mode = 'rw'
  " let g:ctrop_switch_buffer = 'e'
  " let g:ctrlp_max_files = 5000
  " let g:ctrlp_root_markets = ['Gemfile']
  " let g:ctrlp_match_window = 'top,order:btt,max:25'
  " let g:ctrlp_match_current_file = 1
  " let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
  " let g:ctrlp_show_hidden = 1

  " nmap <Leader>b :CtrlPBuffer<CR>

  " if executable('ag')
  "   let g:ctrlp_user_command = 'fzf -f="" --no-sort'
  " endif
else
  " ---------------------------------------
  " -- pick.vim
  call minpac#add('thoughtbot/pick.vim')
  nmap <Leader>t  :call PickFile()<CR>
  nmap <Leader>fs :call PickFileSplit()<CR>
  nmap <Leader>fv :call PickFileVerticalSplit()<CR>
  nmap <Leader>b  :call PickBuffer()<CR>
  nmap <Leader>]  :call PickTag()<CR>
endif

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
" nnoremap S "_diwP
" vnoremap S "_dP

" ***************************************
" Buffer navigation
" ***************************************
nmap :bs :buffers
nmap <leader>w :Bclose<CR>
nmap <leader>q :bwipeout!<CR>
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
nmap :clear :bufdo! bwipeout!<CR>
" --- Replace all 'hard' tabs with 'soft' tabs
nmap <leader>rt :retab!<Return>

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
" Managing Sessions
" ***************************************
nmap <F2> :wa<Bar>exe "mksession! ~/vim-sessions/current.vim"<CR>
nmap <F3> :! rm -rf ~/vim-sessions/current.vim<CR>
nmap <F4> :source ~/vim-sessions/current.vim<CR>

" ***************************************
" Local machine overrides
" ***************************************
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
