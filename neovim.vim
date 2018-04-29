call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'iCyMind/NeoSolarized'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sensible'
Plug 'kopischke/vim-fetch'
Plug 'myusuf3/numbers.vim'
Plug 'ctrlpvim/ctrlp.vim'
if executable("composer")
	Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
endif

call plug#end()

set nocompatible " Be iMproved, required for oni
set number

if exists('g:gui_oni') " Oni specific config
    filetype off " Required for oni
    set noswapfile
    set smartcase

    " Turn off statusbar, because it is externalized
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd

    " Enable GUI mouse behavior
    set mouse=a

    set list
    set listchars=trail:·
else
    set termguicolors
    set background=dark
    colorscheme NeoSolarized
endif

let g:Guifont="Fira Code:h10"
