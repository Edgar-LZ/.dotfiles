syntax on
set title

set belloff=all
set tabstop=4 softtabstop=4
set number
set background=dark
colorscheme monokai
set wrap linebreak
set incsearch
set smartcase
set clipboard=unnamedplus
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set foldmethod=syntax
filetype plugin on
set shiftwidth=4
"search down into subfolders
"Provides tab-completion for all file-related tasks
set path+=**
"Display all matching files when we tab complete
set wildmenu
" set hlsearch

" File browsing
let g:netrw_liststyle=3
let mapleader=";"



set colorcolumn=80
autocmd FileType tex    set textwidth=79

highlight ColorColumn ctermbg=0 guibg=lightgrey
nnoremap <leader>la :VimtexCompile<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
" :Plug install
"
call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'preservim/nerdcommenter'
call plug#end()
