runtime! debian.vim

syntax on
set nocp
filetype plugin on
filetype indent on

set t_Co=256
set rtp+=~/.vim/

" Add extensions
call plug#begin('~/.vim/plugged')
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ervandew/supertab'
Plug 'jimenezrick/vimerl'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'AD7six/vim-independence'
Plug 'godlygeek/csapprox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/po.vim--gray'
Plug 'ekalinin/Dockerfile.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'skywind3000/asyncrun.vim'
Plug 'xavierd/clang_complete'
Plug 'tpope/vim-sleuth'
call plug#end()

noremap <C-f8> :NERDTreeToggle<return>
noremap <C-f3> :AsyncRun ctags -R --python-kinds=-i --exclude=build .<return>
map <C-]> <C-]>:tjump<return>

map ,n :cn<return>

" FZF mappings
noremap <C-P> :GFiles<return>
noremap ,g :GFiles<return>
noremap ,f :Files<return>
noremap ,b :Buffers<return>

" Recursive search & replace
map ,* :Ack <cword><return>
map ,r :!git grep -lz '<cword>' \| xargs -0 sed -i 's/<cword>/

vnoremap ,o : ! ~/.vim/ReorderImports<return>

" Switch to dark theme at night
function SetBackground(timer)
    if strftime("%H") >= 10 && strftime("%H") < 15
        set background=light
    else
        set background=dark
    endif
endfunction

call SetBackground('')
colorscheme PaperColor

call timer_start(30*60*1000, 'SetBackground', {'repeat': -1})

" Solarized only really looks good in gvim
if has("gui_running")
    set gfn=Ubuntu\ Mono\ derivative\ Powerline\ 12
    set background=light
    colorscheme solarized
endif

" Copy & paste from clipboard
map ,y "+y
map ,p "+p

" Highlight non-ascii characters
map ,h /[^\x00-\x7F]<return>

autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.haml :%s/\s\+$//e
autocmd BufWritePre *.css :%s/\s\+$//e
autocmd BufWritePre *.sass :%s/\s\+$//e
autocmd BufWritePre *.js :%s/\s\+$//e

au BufRead,BufNewFile *.scala set filetype=scala
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

set showcmd
set showmatch
set ignorecase
set smartcase
set incsearch
set autowrite
set hidden
set backspace=indent,eol,start
set ruler
set hlsearch

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set mouse=a

set wildignore=*.pyc,build/**

set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions+=c

set cul

" Highlighting current lines is slow for larger files
autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > 50000 | set nocul | endif

" Use pyflakes
let g:syntastic_python_checkers=['flake8']
let g:syntastic_always_populate_loc_list = 1

let NERDTreeIgnore=['\.pyc$', '__pycache__']

" Faster than ack-grep
if executable('ag')
  let g:ackprg = 'ag'
endif

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap ,q :q<cr>

" Allow window navigation in terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Fix arrow keys in terminal mode (https://github.com/vim/vim/issues/2716)
tnoremap <Esc> <C-W>N
tnoremap <Esc><Esc> <C-W>N
set timeout timeoutlen=1000  " Default
set ttimeout ttimeoutlen=100  " Set by defaults.vim

" inoremap jk <esc>

map ,t :let a=winsaveview()<cr>[mw"fyw[[w"cyw:call winrestview(a)<cr>:terminal django-admin test -s --logging-level=ERROR %:"<C-r>c.<C-r>f"<cr>

let g:airline_powerline_fonts = 1
let g:asyncrun_status = "stopped"
" let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

let g:clang_library_path = '/usr/lib/x86_64-linux-gnu/libclang-8.so.1'

" Run server
noremap <f6> :AsyncRun -raw django-admin runserver_plus<cr>
noremap <C-f6> :terminal django-admin runserver_plus<cr>

noremap <f4> :AsyncStop<cr>
noremap <C-f4> :AsyncStop!<cr>
