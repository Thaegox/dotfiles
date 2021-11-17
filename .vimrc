"""""""""""""""""""""""""""""""""""""
"                                   "
"               VIMRC               "
"       author: eliott.beguet       "
"                                   "
"   Thx Chewie for your vimrc :D    "
"   And random SO post.             "
"                                   "
"""""""""""""""""""""""""""""""""""""


"""""""""""""""""
"   PLUGINS     "
"""""""""""""""""

" Install vim plug if not already installed"
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/plugged'
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" auto comments
Plug 'preservim/nerdcommenter'

" quickfix buffer
Plug 'romainl/vim-qf'

" Tab number and only shows basename
Plug 'mkitt/tabline.vim'

" tree on current buffer
Plug 'tpope/vim-vinegar'

" Them
Plug 'nanotech/jellybeans.vim'
Plug 'wadackel/vim-dogrun'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 'IDE' features
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'janko/vim-test'

call plug#end()

"""""""""""""
" CMD stuff "
"""""""""""""

" Silently execute any command and redraw buffers
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

" Reload a file when it is changed from the outside
set autoread

" Write the file when we leave the buffer
set autowrite

" Disable backups, hello git
set nobackup

" Force to utf-8 encoding (Windows)
set encoding=utf-8

" Disable swapfiles
set noswapfile

" Hide buffers instead of closing them
set hidden

" For some stupid reason, vim requires the term to begin with "xterm", so the
" automatically detected "rxvt-unicode-256color" doesn't work.
set term=xterm-256color

" zsh term
autocmd vimenter * let &shell='/bin/zsh -i'


""""""""""""
" UI Stuff "
""""""""""""

" Set the minimal amount of lignes under and above the cursor
set scrolloff=6

" Show current mode
set showmode

" Show command being executed
set showcmd

" Show line number (relative)
set number
set relativenumber

" Always show status line
set laststatus=2

" Enhance command line completion
set wildmenu

" Set completion behavior, see :help wildmode for details
set wildmode=longest:full,list:full

" Color the column after textwidth (80th here)
if version >= 703
  set colorcolumn=+1
endif

" Display whitespace characters
set list
set listchars=tab:>─,eol:¬,trail:\ ,nbsp:¤

set fillchars=vert:│

" Basic syntax highlighting
syntax on

" Enable Doxygen highlighting
let g:load_doxygen_syntax=1

" Allow mouse use in vim
set mouse=a

" Show matching parenthesis etc
set showmatch

" Enable line wrapping
set wrap

" Wrap on column 80
set textwidth=79

" Disable preview window on completion
set completeopt=longest,menuone

" Highlight current line
set cursorline


""""""""""""""""
" Search Stuff "
""""""""""""""""

" Ignore case on search
set ignorecase

" Ignore case unless there is an uppercase letter in the pattern
set smartcase

" Move cursor to the matched string
set incsearch

" Don't highlight matched strings
set nohlsearch


"""""""""""""""""""""
" Indentation Stuff "
"""""""""""""""""""""

" The length of a tab (don't change it)
set tabstop=8

" Number of spaces inserted/removed when using < or >
set shiftwidth=4

" Number umber of spaces inserted when tabbing
" -1 means same value as shiftwidth
set softtabstop=-1

" Insert spaces instead of tabs
set expandtab

" When tabbing manually, use shiftwidth instead of tabstop and softtabstop
set smarttab

" Basic indenting (ie indent from previous line)
set autoindent

" :help cinoptions-values for details
set cinoptions=(0,u0,U0,t0,g0,N-s


"""""""""""""""""
" Mapping stuff "
"""""""""""""""""

" Set ù as map leader with an azerty keyboard
" Change it to , on qwerty
let mapleader = 'ù'

" Move between rows in wrapped lines
noremap j gj
noremap k gk

" Remap Q to A (I often missclick and don't really use Q anyway)
nmap Q A

" Map F1 to source current buffer
map <F1> :w<CR>:so %<CR>

" Mapping tabs and listing
" t[h/g] moveto[next/previous] tabs
" ty show all tabs
" tt close current tab
" Ctrl t to create a new tab
nnoremap ty :tabs<CR>
nnoremap th :tabnext<CR>
nnoremap tg :tabprev<CR>
nnoremap tt :tabclose<CR>
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>

" Ctrl S to save all tabs and go back to the first one
let curr_tab=tabpagenr()
nnoremap <C-S> :tabdo w <bar><Esc> :execute curr_tab .. "gt"<CR>

" <space>cl to apply .clang-format
nnoremap <space>cl :Silent clfe<CR>

" Map easy move to new tab on azerty
" Change t<symbol> to t<number> on qwerty
nnoremap t& 1gt
nnoremap té 2gt
nnoremap t" 3gt
nnoremap t' 4gt
nnoremap t( 5gt
nnoremap t- 6gt

" Yank from cursor to end of line, to be consistent with C and D
nnoremap Y y$

" Write as root, when you forgot to sudoedit
cnoreabbrev w!! w !sudo tee % >/dev/null

" Open the quickfix window if there are errors, or close it if there are no
" errors left
noremap <leader>cw :botright :cw<cr>

" Run make silently, then skip the 'Press ENTER to continue'
noremap <leader>m :silent! :make! \| :redraw!<cr>

" Run clanf-format-epita silently
noremap <space>c :Silent !clfe<cr>

" Map auto closing char (comas, braces, etc)
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


""""""""""""""""""""""""
"  plugins etc options "
""""""""""""""""""""""""

" Launch fugitive's gstatus
noremap <space>gs :Git<CR>

" Add curent buffer to repo
noremap <space>ga :w<CR>:Git add %<bar>echom "Added" expand("%")<CR>

" Commit with buffer prompt for msg
noremap <space>gc :Git commit -v<CR>

" Remap space gp to basic push
noremap <space>gp :Git push<CR>

" Simple Git log
noremap <space>gl :Git log --pretty=format:'%h %ad %s (%an)' --date=short<CR>

" Function to tag the last commit from user input
function GitTag()
    call inputsave()
    let tagName=input('Tag name: ')
    call inputrestore()
    :redraw
    echom 'git tag -a ' . tagName . '-m "Tag"'
endfunction

" Mappings for vim-test
nmap <silent> <space>ts :TestSuite<CR>

" Display a short path
let g:airline_stl_path_style = 'short'

" Create the vim airline symbols directory (if it doesn't exist yet)
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"
" use ascii symnols for status bar
let g:airline_symbols_ascii = 1

" airline theme
let g:airline_theme = 'jellybeans'

" tabline.vim plugin add close button on tab
" it's ugly af nvm
"let g:tablineclosebutton=1

let g:jellybeans_background_color_256='232'
colorscheme dogrun

" map vimairline symbols
" unicode symbols
let g:airline_left_sep = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.colnr = ' | c'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' | '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
