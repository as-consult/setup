"general
set tabstop=2
set shiftwidth=2
set expandtab
set number
set showcmd
set mouse=a
set showmatch
set hlsearch
set encoding=utf-8
set colorcolumn=80
syntax on

"security options
set nomodeline

"useful for HTML file
filetype on
autocmd Filetype html set cursorcolumn
autocmd Filetype eruby set cursorcolumn
autocmd Filetype ruby set cursorcolumn

"smart search
set ignorecase
set incsearch "instant search when typing

"autocompletion
set omnifunc=syntaxcomplete#Complete "Use Ctr-x Ctr-o

"spelling
"setlocal spell spelllang=en_us
set nospell

"leader key"
let mapleader = " "

"personal commands
"nnoremap = normal mode
"inoremap = insert mode
"vnoremap = visual mode
"cnoremap = command (colon) mode
nnoremap <leader>t :NERDTree<CR>
nnoremap <leader>y "+yy
nnoremap <leader>p "+p
nnoremap <leader>s :setlocal spell spelllang=en_us<CR>
nnoremap <leader>dt :put=strftime('%Y-%m-%d %H:%M')<CR>
nnoremap <leader>ic i<% %><Esc>hh
nnoremap <leader>m vat

"plugins manager vim-plug
call plug#begin('~/.vim/plugged')

"list of plugins
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/airblade/vim-gitgutter'

"initialize plugin system
call plug#end()

"color themes
"colorscheme slate
