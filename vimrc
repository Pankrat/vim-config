runtime! debian.vim

syntax on
set nocp
filetype plugin on
filetype indent on

set t_Co=256
colorscheme zenburn

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

iab pdb import ipdb; ipdb.set_trace()

map <C-f8> :NERDTreeToggle<return>
map <C-f3> :!ctags -R --python-kinds=-i --exclude=build .<return>
map <M-]> <C-]>:tjump<return>

" Pylint
set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
set errorformat=%f:%l:\ %m
map <f5> :make<return><return>:copen<return>
map ,n :cn<return>

vmap ,o : ! ~/.vim/ReorderImports<return>

let g:solarized_termcolors=256
set background=dark
colorscheme solarized

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

if version >= 600
	set foldenable
	set foldmethod=marker
endif

set wildignore=*.pyc,build/**

set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions+=c

set cul
