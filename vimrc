runtime! debian.vim

syntax on
set nocp
filetype plugin on
filetype indent on

set t_Co=256
colorscheme zenburn

set rtp+=~/.vim/

" Set up package manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Add extensions
Bundle 'altercation/vim-colors-solarized'
Bundle 'ervandew/supertab'
Bundle 'jimenezrick/vimerl'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'AD7six/vim-independence'
Bundle 'pydave/AsyncCommand'
Bundle 'godlygeek/csapprox'
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

iab pdb import ipdb; ipdb.set_trace()

noremap <C-f8> :NERDTreeToggle<return>
map <C-f3> :!ctags -R --python-kinds=-i --exclude=build .<return>
map <C-]> <C-]>:tjump<return>

" Pylint
set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
set errorformat=%f:%l:\ %m
map <f5> :make<return><return>:copen<return>
map ,n :cn<return>

" Recursive search & replace
map ,* :Ack <cword><return>
map ,r :!find . -type f -print0 \| xargs -0 sed -i 's/<cword>/

vnoremap ,o : ! ~/.vim/ReorderImports<return>

" Solarized only really looks good in gvim
if has("gui_running")
    set gfn=Ubuntu\ Mono\ derivative\ Powerline\ 12
    set background=dark
    colorscheme solarized
endif

" Copy & paste from clipboard
map ,y "+y
map ,p "+p

autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.haml :%s/\s\+$//e
autocmd BufWritePre *.css :%s/\s\+$//e
autocmd BufWritePre *.sass :%s/\s\+$//e
autocmd BufWritePre *.js :%s/\s\+$//e

au BufRead,BufNewFile *.scala set filetype=scala

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
let g:syntastic_python_checkers=['pyflakes']

let NERDTreeIgnore=['\.pyc$']

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap jk <esc>

map ,t :let a=winsaveview()<cr>[mw"fyw[[w"cyw:call winrestview(a)<cr>:!nosetests -s --logging-level=ERROR %:<C-r>c".<C-r>f"<cr>

" Activate powerline
set laststatus=2
