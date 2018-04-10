if exists('g:gui_oni') " Oni specific config
    set nocompatible              " be iMproved, required
    filetype off                  " required

    set number
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
