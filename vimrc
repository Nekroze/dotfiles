set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-syntastic/syntastic'
Plug 'skammer/vim-css-color', { 'for': 'css' }
Plug 'lumiliet/vim-twig', { 'for': 'twig' }
Plug 'LnL7/vim-nix'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'raimondi/delimitmate'
Plug 'robbles/logstash.vim'
Plug 'buoto/gotests-vim'
if executable("ctags")
    Plug 'craigemery/vim-autotag'
    Plug 'vim-php/phpctags', { 'for': 'php' }
endif
if filereadable(expand("$HOME/.local/bin/refactor.phar"))
    Plug 'vim-php/vim-php-refactoring', { 'for': 'php' }
endif
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'veloce/vim-behat'
if $TERM=~#"^tmux.*"
    Plug 'christoomey/vim-tmux-navigator'
endif
Plug 'elmcast/elm-vim'
Plug 'hashivim/vim-terraform'
Plug 'majutsushi/tagbar'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'ekalinin/Dockerfile.vim'
Plug 'NLKNguyen/vim-docker-compose-syntax'
Plug 'SirVer/ultisnips'
Plug 'myusuf3/numbers.vim'
Plug 'yuratomo/w3m.vim'
Plug 'dmix/elvish.vim', { 'on_ft': ['elvish']}
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
if executable("flake8")
    Plug 'nvie/vim-flake8'
endif
Plug 'Yggdroot/indentLine'
Plug 'fatih/vim-go'
Plug 'kopischke/vim-fetch'

call plug#end()
filetype plugin indent on

syntax enable
let g:is_posix=1
set tabstop=4 shiftwidth=4
set autoindent
set fileformat=unix
set ignorecase
set showmode
set showcmd
set ruler
set matchpairs+=<:>


set t_Co=256
set background=dark
try
  colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
endtry
hi Normal ctermbg=none

if has('gui_running')
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
endif

filetype plugin on

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
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:ctrlp_max_files = 0
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

set tags=./tags;/
let g:autotagTagsFile="tags"
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
nnoremap <silent> <Leader>b :TagbarToggle<CR>
nnoremap <leader>. :CtrlPTag<cr>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
let php_sql_query=1
let php_htmlInStrings=1
let g:feature_filetype='behat'

" Disable : and replace with ; allowing ; via double tapping ; like ;;
map ; :
noremap ;; ;

if filereadable(expand("$HOME/.local/bin/refactor.phar"))
    let g:php_refactor_command='php ~/.local/bin/refactor.phar'
endif
" map CTRL \ to open definition in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" map ALT ] to open definition in vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Vim folding
set foldmethod=indent
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
set nofoldenable

let g:elm_format_autosave = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:elm_syntastic_show_warnings = 1

let g:go_fmt_command = "goimports"
let g:UltiSnipsExpandTrigger="<C-j>"

vnoremap <silent> # :s/^/#/<cr>:noh<cr>
vnoremap <silent> -# :s/^#//<cr>:noh<cr>

if executable("gotags")
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }
endif

if executable("ocamlmerlin")
    let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
    execute "set rtp+=" . g:opamshare . "/merlin/vim"
endif

let g:w3m#homepage = "https://duckduckgo.com/"
let g:w3m#search_engine = 'https://duckduckgo.com/?q='

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
set encoding=utf-8
let g:ycm_autoclose_preview_window_after_completion=1
"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF
let python_highlight_all=1
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
set list lcs=tab:\|\ 
let g:go_play_browser_command = 'firefox --private-window %URL% &'

if filereadable(expand("$HOME/.vimrc.local"))
    source ~/.vimrc.local
endif
