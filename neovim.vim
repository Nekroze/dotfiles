call plug#begin('~/.local/share/nvim/plugged')

Plug 'iCyMind/NeoSolarized'
Plug 'LnL7/vim-nix'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'

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
