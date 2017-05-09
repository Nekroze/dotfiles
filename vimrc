set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'

Plug 'vim-scripts/sudo.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-syntastic/syntastic'
Plug 'skammer/vim-css-color', { 'for': 'css' }
"Plug 'pangloss/vim-javascript'
"Plug 'othree/html5.vim'
Plug 'lumiliet/vim-twig'
Plug 'LnL7/vim-nix'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'shawncplus/phpcomplete.vim'
"Plug 'joonty/vim-phpqa.git'
"Plug 'ervandrew/supertab'
"Plug 'Valloric/YouCompleteMe'
Plug 'mustache/vim-mustache-handlebars'
"Plug 'shougo/neocomplete.vim'
Plug 'raimondi/delimitmate'
"Plug 'craigemery/vim-autotag'
"Plug 'roxma/simpleautocomplpop'
"Plug 'majutsushi/tagbar'
"Plug 'vim-php/tagbar-phpctags.vim'
Plug 'vim-php/phpctags', { 'for': 'php' }
Plug 'vim-php/vim-php-refactoring', { 'for': 'php' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'vimwiki/vimwiki'
Plug 'veloce/vim-behat'
Plug 'wikitopian/hardmode'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ajh17/VimCompletesMe'

call plug#end()
filetype plugin indent on

syntax enable
let g:is_posix=1
set number
set tabstop=4 shiftwidth=4
set autoindent
set fileformat=unix
set ignorecase
"set laststatus=2
set showmode
set showcmd
set ruler
"set list
"set listchars=tab:»·,trail:·,extends:>,precedes:<
set matchpairs+=<:>


set t_Co=256
set background=dark
colorscheme solarized
hi Normal ctermbg=none

if has('gui_running')
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
endif

filetype plugin on

" autocmd BufRead *.html set syntax=pt " for Benon::Template
autocmd BufRead /etc/* set tabstop=8 shiftwidth=8
autocmd BufRead /var/named/* set tabstop=8 shiftwidth=8
autocmd BufRead /www/conf/* set tabstop=8 shiftwidth=8
autocmd BufRead *.pl,*.pm,*.cgi set tabstop=4 shiftwidth=4
autocmd BufRead *.pl,*.pm,*.cgi compiler perl

" highlight trailing spaces
autocmd BufNewFile,BufRead * let b:mtrailingws=matchadd('ErrorMsg', '\s\+$', -1)
" highlight tabs between spaces
autocmd BufNewFile,BufRead * let b:mtabbeforesp=matchadd('ErrorMsg', '\v(\t+)\ze( +)', -1)
autocmd BufNewFile,BufRead * let b:mtabaftersp=matchadd('ErrorMsg', '\v( +)\zs(\t+)', -1)
" disable matches in help buffers
autocmd BufEnter,FileType help call clearmatches()

let perl_fold = 1
map ^[l :set nolist!<CR>:set nolist?<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:syntastic_php_checkers=['php', 'phpcs']
"let g:syntastic_php_checkers=['php']
let g:syntastic_php_phpcs_args='--standard=/home/taylorl/dev/www/bin/phpcs/Jumbo/ruleset.xml -n'
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:ctrlp_max_files = 0
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

set tags=./ctags;/
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }
set hlsearch
"set completeopt+=menu,menuone
"set shortmess+=c
nnoremap <silent> <Leader>b :TagbarToggle<CR>
nnoremap <leader>. :CtrlPTag<cr>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
""let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"let g:neocomplete#keyword_patterns['default'] = '[^. \t]->\h\w*\|\h\w*::|\$\h\w*'
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"  " For no inserting <CR> key.
"  "return pumvisible() ? "\<C-y>" : "\<CR>"
"endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
let php_sql_query=1
let php_htmlInStrings=1
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
let g:feature_filetype='behat'

" Disable : and replace with ; allowing ; via double tapping ; like ;;
map ; :
noremap ;; ;

" TRAINING MODE
let g:HardMode_level='wannabe'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

set relativenumber

let g:php_refactor_command='php ~/.local/bin/refactor.phar'
" map CTRL \ to open definition in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" map ALT ] to open definition in vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Vim folding
set foldmethod=indent
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
