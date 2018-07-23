set nowrap
set nocompatible    " use vim defaults
set ls=2            " allways show status line
set cindent
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set expandtab
set smarttab
set scrolloff=3     " keep 3 lines when scrolling
set noshowcmd       " do not display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set visualbell t_vb= " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set nonumber        " do not show line numbers
set ignorecase      " ignore case when searching
set noignorecase    " don't ignore case
set title           " show title in console title bar
set ttyfast         " smoother changes
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set showmatch
set showmode
set wildmenu
set encoding=utf-8
set mouse=a         " enable mouse
set showcmd

let mapleader = ","

" NeoBundle
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

filetype plugin indent on

call neobundle#begin(expand('~/.vim/bundle/'))

let g:neobundle#types#git#default_protocol = 'https'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'kergoth/vim-bitbake'
NeoBundle 'ervandew/supertab'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'junousia/a.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/upAndDown'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'klen/python-mode'
NeoBundle 'vim-scripts/DoxygenToolkit.vim'
NeoBundle 'vim-scripts/ScrollColors'
NeoBundle 'vim-scripts/cmake'
NeoBundle 'vim-scripts/vim-bookmarks'
NeoBundle 'bling/vim-airline'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'heavenshell/vim-pydocstring'
NeoBundle 'airblade/vim-rooter'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'junousia/vim-babeltrace'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'triglav/vim-visual-increment'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'gustafj/vim-ttcn'
NeoBundle 'vim-scripts/Mark--Karkat'
NeoBundle 'junousia/cscope-quickfix'
NeoBundle 'milkypostman/vim-togglelist'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'mfukar/robotframework-vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'vim-scripts/iptables'
NeoBundle 'vim-scripts/Conque-Shell'
NeoBundle 'vim-erlang/vim-erlang-runtime'
call neobundle#end()
NeoBundleCheck

nnoremap <silent> <leader>c :noh<return><esc>

" mkdir
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" <Cscope
map <leader> c :Cscope
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" Paste mode toggle
set pastetoggle=<F12>

" vim-rooter
let g:rooter_silent_chdir = 1

" Resize window
if bufwinnr(1)
  map + 5<C-W>>
  map - 5<C-W><
endif

" Show signcolumn
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
autocmd FileType tagbar,nerdtree setlocal signcolumn=no

" Auto-reload vimrc
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }"

" Ctrlp
let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <C-f> :CtrlPQuickfix<CR>
nnoremap <silent> <C-l> :CtrlPLine<CR>
nnoremap <silent> <C-b> :CtrlPBuffer<CR>
nnoremap <silent> <S-f> :CtrlP<CR>
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" map X to search selected text on visual mode
xnoremap <silent> X y/<C-R>"<CR>"

" bind K to grep word under cursor
nnoremap <silent> K :Ggrep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <silent> <leader>z :cp<CR>
nnoremap <silent> <leader>x :cn<CR>

" Pymode
let g:pymode_folding = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 1
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_rope_goto_definition_bind = '<C-c>g'
let g:pymode_warnings = 0
let g:pymode_lint_message = 0
let g:pymode_lint_checkers = []
let g:pymode_lint_cwindow = 0

" Tags
set tags=./tags;/
map <leader>o <C-T>
map <leader>i g<C-]>

" Splitfix
set fillchars+=vert:\|

" GitGutter
" set signcolumn=yes
nnoremap <silent> <C-S-j> :GitGutterNextHunk<CR>
nnoremap <silent> <C-S-h> :GitGutterPrevHunk<CR>
nnoremap <silent> <C-S-r> :GitGutterUndoHunk<CR>

" Syntastic
let g:syntastic_shell = "bash"
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args='--ignore=E501 --max-complexity=10'
let g:syntastic_c_checkers = ['cppcheck', 'splint', 'gcc']
let g:syntastic_cpp_checkers = ['cppcheck']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_check_on_open = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_mode_map = { "mode": "passive",
            \ "active_filetypes": ["python"],
            \ "passive_filetypes": [] }

" Remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Gundo
nnoremap <silent> <leader>u :GundoToggle<CR>

" Cycle buffers
nnoremap <silent> <C-\<> :bnext<CR>
nnoremap <silent> <C-S-\<> :bprevious<CR>

" Filetypes
filetype plugin on
autocmd FileType c,cpp set shiftwidth=4 expandtab omnifunc=ccomplete#Complete
autocmd FileType vim,lua,nginx set expandtab shiftwidth=2 softtabstop=2
autocmd FileType xhtml,html set expandtab omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set expandtab omnifunc=xmlcomplete#CompleteTags
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
au BufRead,BufNewFile *.re set filetype=c
au BufRead,BufNewFile *.lttng set filetype=babeltrace
au BufRead,BufNewFile *.bb set filetype=cmake
au BufRead,BufNewFile *.inc set filetype=cmake
au BufRead,BufNewFile *.ttcn set filetype=ttcn
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Nerdtree
nnoremap <silent> § :NERDTreeToggle<CR>
nnoremap <leader> f :NERDTreeFind<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrows=1
let g:NERDTreeMinimalUI = 1

" Tagbar
nnoremap <silent> ' :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1

" Set syntax highlighting on
syntax on

" TTCN-3 folding
let g:ttcn_fold = 0

" Bookmarks
highlight BookmarkSign ctermbg=NONE ctermfg=red
highlight BookmarkLine ctermbg=NONE ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 0
let g:bookmark_auto_close = 1

" Quote a word
nnoremap sq :silent! normal mpea'<Esc>bi'<Esc>`pl`
nnoremap dq :silent! normal mpea"<Esc>bi"<Esc>`pl`

" Airline
au VimEnter * exec 'AirlineTheme ubaryd'

" Colorscheme
colorscheme desert

if has('gui_running')
  " Remove toolbars etc.
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar

  " Font
  if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
      set guifont=Andale\ Mono:h14
    elseif s:uname == "Linux\n"
      set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
    endif
  endif
else
  " Signcolumn color fix
  highlight SignColumn guibg=NONE ctermbg=NONE
endif
