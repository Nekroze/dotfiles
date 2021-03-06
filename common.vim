set nocompatible " Be iMproved, required for oni

call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'

if has('nvim')
	Plug 'icymind/neosolarized'
else
	Plug 'altercation/vim-colors-solarized'
endif

Plug 'chrisbra/Colorizer'
Plug 'RRethy/vim-illuminate'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sensible'
Plug 'myusuf3/numbers.vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
set hidden

Plug 'vim-syntastic/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

if executable('go')
	Plug 'fatih/vim-go'
	let g:go_fmt_command = "goimports"

	if executable('gotests')
		Plug 'buoto/gotests-vim'
	endif
endif

Plug 'b4b4r07/vim-hcl'
Plug 'kristijanhusak/vim-carbon-now-sh'

Plug 'sjl/gundo.vim'
Plug 'townk/vim-autoclose'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'w0rp/ale'
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1

if has('python') && executable('haxe')
	Plug 'jdonaldson/vaxe'
	set autowrite
endif

if !exists('g:gui_oni') " neovim/vim without oni can also use LSP
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'

    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
	let g:asyncomplete_remove_duplicates = 1
endif

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nnoremap <c-p> :FZF<cr>

call plug#end()

if has('gui_running')
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
	set guioptions-=L  "remove left-hand scroll bar
	set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
endif
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
	try
		if has('nvim')
			colorscheme NeoSolarized
		else
			colorscheme solarized
		endif
	catch /^Vim\%((\a\+)\)\=:E185/
	endtry

	"try
	"	call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
	"	\ 'name': 'omni',
	"	\ 'whitelist': ['*'],
	"	\ 'blacklist': [],
	"	\ 'completor': function('asyncomplete#sources#omni#completor')
	"	\  }))
	"catch /^Vim\%((\a\+)\)\=:E185/
	"endtry
endif
" Always use system clipboard
set clipboard+=unnamedplus

highlight TermCursor ctermfg=red guifg=red

" Window split settings
set splitbelow
set splitright

" Terminal settings
tnoremap <Leader><ESC> <C-\><C-n>

set tabstop=4 shiftwidth=4

" highlight trailing spaces
autocmd BufNewFile,BufRead * let b:mtrailingws=matchadd('ErrorMsg', '\s\+$', -1)
" highlight tabs between spaces
autocmd BufNewFile,BufRead * let b:mtabbeforesp=matchadd('ErrorMsg', '\v(\t+)\ze( +)', -1)
autocmd BufNewFile,BufRead * let b:mtabaftersp=matchadd('ErrorMsg', '\v( +)\zs(\t+)', -1)
" disable matches in help buffers
autocmd BufEnter,FileType help call clearmatches()

" Vim folding
set foldmethod=indent
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
set nofoldenable

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

augroup filetypedetect
    au! BufRead,BufNewFile Dockerfile.*       setfiletype dockerfile
augroup END

" When not using Oni and dapper is available use the LSP servers dapper
" provides
if !exists('g:gui_oni') && executable('dapper')
	au user lsp_setup call lsp#register_server({
				\ 'name': 'bash',
				\ 'cmd': {server_info->[&shell, &shellcmdflag, 'dapper lsp-bash']},
				\ 'whitelist': ['sh'],
				\ })
	au user lsp_setup call lsp#register_server({
				\ 'name': 'php',
				\ 'cmd': {server_info->[&shell, &shellcmdflag, 'dapper lsp-php']},
				\ 'whitelist': ['php'],
				\ })
	au user lsp_setup call lsp#register_server({
				\ 'name': 'dockerfile',
				\ 'cmd': {server_info->[&shell, &shellcmdflag, 'dapper lsp-dockerfile']},
				\ 'whitelist': ['dockerfile'],
				\ })
	au user lsp_setup call lsp#register_server({
				\ 'name': 'dart',
				\ 'cmd': {server_info->[&shell, &shellcmdflag, 'dapper lsp-dart']},
				\ 'whitelist': ['dart'],
				\ })
endif

autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell
set complete+=kspell
