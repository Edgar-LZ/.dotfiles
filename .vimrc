syntax on

set belloff=all
set tabstop=4 softtabstop=4
set number
set background=dark
colorscheme neverland
set wrap linebreak
set incsearch
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set foldmethod=syntax
filetype plugin on
"search down into subfolders
"Provides tab-completion for all file-related tasks
set path+=**
"Display all matching files when we tab complete
set wildmenu

" File browsing
let g:netrw_liststyle=3
let mapleader=" "

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
nnoremap <silent>la :VimtexCompile<CR>

call plug#begin('~/.vim/plugged')
Plug 'git@github.com:Valloric/YouCompleteMe.git'
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
call plug#end()
nnoremap <silent> <leader>gg :YcmCompleter GoTo<CR>
