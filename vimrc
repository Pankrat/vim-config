runtime! debian.vim

syntax on
set nocp
filetype plugin on
filetype indent on

set t_Co=256
colorscheme autumnleaf

set rtp+=~/.vim/

" Add extensions
call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'
Plug 'jimenezrick/vimerl'
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'AD7six/vim-independence'
Plug 'pydave/AsyncCommand'
Plug 'godlygeek/csapprox'
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'vim-scripts/po.vim--gray'
Plug 'ekalinin/Dockerfile.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
call plug#end()

iab pdb import ipdb; ipdb.set_trace()

noremap <C-f8> :NERDTreeToggle<return>
map <C-f3> :!$(ctags -R --python-kinds=-i --exclude=build . > /dev/null &)<return><return>
map <C-]> <C-]>:tjump<return>

" FZF mappings
noremap ,g :GFiles<return>
noremap ,f :Files<return>
noremap ,b :Buffers<return>

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
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_always_populate_loc_list = 1

let NERDTreeIgnore=['\.pyc$']

" Faster than ack-grep
if executable('ag')
  let g:ackprg = 'ag'
endif

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap jk <esc>

map ,t :let a=winsaveview()<cr>[mw"fyw[[w"cyw:call winrestview(a)<cr>:!nosetests -s --logging-level=ERROR %:<C-r>c".<C-r>f"<cr>

" Activate powerline
set laststatus=2
