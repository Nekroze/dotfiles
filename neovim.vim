set nocompatible " Be iMproved, required for oni

call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'iCyMind/NeoSolarized'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sensible'
Plug 'kopischke/vim-fetch'
Plug 'myusuf3/numbers.vim'
Plug 'vim-syntastic/syntastic'
Plug 'Yggdroot/indentLine'
Plug 'fatih/vim-go'
Plug 'buoto/gotests-vim'
if !exists('g:gui_oni') " neovim without oni can also use LSP
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
endif
if executable('fzf')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
else
Plug 'ctrlpvim/ctrlp.vim'
endif

call plug#end()

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
else
    set termguicolors
    set background=dark
    colorscheme NeoSolarized

    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

    if executable('go-langserver')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'go-langserver',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, expand('~/go/bin/go-langserver -gocodecompletion')]},
            \ 'whitelist': ['go'],
            \ })
    endif
endif

" Automatically change dir to active file
set autochdir
" Always use system clipboard
set clipboard+=unnamedplus

" Window split settings
highlight TermCursor ctermfg=red guifg=red
set splitbelow
set splitright

" Terminal settings
tnoremap <Leader><ESC> <C-\><C-n>

" Window navigation function
" Make ctrl-h/j/k/l move between windows and auto-insert in terminals
func! s:mapMoveToWindowInDirection(direction)
    func! s:maybeInsertMode(direction)
        stopinsert
        execute "wincmd" a:direction

        if &buftype == 'terminal'
            startinsert!
        endif
    endfunc

    execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
                \ "<C-\\><C-n>"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
    execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
endfunc
for dir in ["h", "j", "l", "k"]
    call s:mapMoveToWindowInDirection(dir)
endfor

let g:go_fmt_command = "goimports"

if filereadable(expand("$HOME/.nvimrc.local"))
    source ~/.nvimrc.local
endif

set tabstop=4 shiftwidth=4

let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

if executable('fzf')
	nmap <leader><tab> <plug>(fzf-maps-n)
	xmap <leader><tab> <plug>(fzf-maps-x)
	omap <leader><tab> <plug>(fzf-maps-o)

	" Insert mode completion
	imap <c-x><c-k> <plug>(fzf-complete-word)
	imap <c-x><c-f> <plug>(fzf-complete-path)
	imap <c-x><c-j> <plug>(fzf-complete-file-ag)
	imap <c-x><c-l> <plug>(fzf-complete-line)
endif
