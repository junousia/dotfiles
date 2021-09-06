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
set mouse=a
set showcmd
set noswapfile
set virtualedit=block
filetype plugin on
filetype indent on

let mapleader = ","

call plug#begin(expand('~/.vim/bundle/'))
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'kergoth/vim-bitbake'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'junousia/a.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/upAndDown'
Plug 'flazz/vim-colorschemes'
Plug 'majutsushi/tagbar'
Plug 'kien/ctrlp.vim'
Plug 'python-mode/python-mode'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/ScrollColors'
Plug 'vim-scripts/cmake'
Plug 'vim-scripts/vim-bookmarks'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sjl/gundo.vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'heavenshell/vim-pydocstring'
Plug 'airblade/vim-rooter'
Plug 'vim-scripts/YankRing.vim'
Plug 'junousia/vim-babeltrace'
Plug 'ntpeters/vim-better-whitespace'
Plug 'triglav/vim-visual-increment'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-scripts/Mark--Karkat'
Plug 'milkypostman/vim-togglelist'
Plug 'chase/vim-ansible-yaml'
Plug 'mfukar/robotframework-vim'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/iptables'
Plug 'vim-scripts/Conque-Shell'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'dhruvasagar/vim-zoom'
Plug 'vim-scripts/checksum.vim'
call plug#end()

" Colorscheme
colorscheme desert

nnoremap <silent> <leader>c :noh<return><esc>

" Paste mode toggle
set pastetoggle=<F12>

" vim-rooter
let g:rooter_silent_chdir = 1

" Resize window
if bufwinnr(1)
  nnoremap + 5<C-W>>
  nnoremap - 5<C-W><
endif

" Show signcolumn
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
autocmd FileType tagbar,nerdtree setlocal signcolumn=no

" YankRing
nnoremap <silent> <C-Y> :YRShow<CR>

" Ctrlp
let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <C-f> :CtrlPQuickfix<CR>
nnoremap <silent> <C-l> :CtrlPLine<CR>
nnoremap <silent> <C-b> :CtrlPBuffer<CR>
nnoremap <silent> <S-f> :CtrlP<CR>
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']

" Ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" map X to search selected text on visual mode
xnoremap <silent> X y/<C-R>"<CR>"

" bind K to grep word under cursor
nnoremap <silent> K :Ggrep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <silent> <leader>z :cp<CR>
nnoremap <silent> <leader>x :cn<CR>

" Pymode
let g:pymode_python = "python3"
let g:pymode_options = 0
let g:pymode_folding = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_rope_goto_definition_bind = '<C-c>g'
let g:pymode_warnings = 0
let g:pymode_lint_message = 0
let g:pymode_lint_checkers = []
let g:pymode_lint_cwindow = 0
let g:autopep8_indent_size=4

" Syntastic
let g:syntastic_shell = "bash"
let g:syntastic_python_checkers = ['flake8', 'pylint']
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
autocmd FileType python set expandtab shiftwidth=4 softtabstop=4
au BufRead,BufNewFile *.re set filetype=c
au BufRead,BufNewFile *.lttng set filetype=babeltrace
au BufRead,BufNewFile *.bb set filetype=bitbake
au BufRead,BufNewFile *.inc set filetype=cmake
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Nerdtree
nnoremap <silent> § :NERDTreeToggle<CR>
nnoremap <leader> f :NERDTreeFind<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrows=1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__']

" Tagbar
nnoremap <silent> ' :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1

" Set syntax highlighting on
syntax on

" Bookmarks
highlight BookmarkSign ctermbg=NONE ctermfg=red
highlight BookmarkLine ctermbg=NONE ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 0
let g:bookmark_auto_close = 1

" Quote a word
nnoremap sq :silent! normal mpea'<Esc>bi'<Esc>`pl`
nnoremap dq :silent! normal mpea"<Esc>bi"<Esc>`pl`

" Python-mode
let g:pymode_python = 'python3'
let g:pymode_indent = 1
let g:pymode_options_max_line_length = 100
let g:pymode_virtualenv = 1
let g:pymode_virtualenv_path = $VIRTUAL_ENV

" Airline
au VimEnter * exec 'AirlineTheme minimalist'

" GitGutter
set signcolumn=yes
nnoremap <silent> <C-S-e> :GitGutterStageHunk<CR>
nnoremap <silent> <C-S-j> :GitGutterNextHunk<CR>
nnoremap <silent> <C-S-h> :GitGutterPrevHunk<CR>
nnoremap <silent> <C-S-r> :GitGutterUndoHunk<CR>
autocmd BufWritePost * GitGutter
let g:gitgutter_grep = 'rg'
let g:gitgutter_set_sign_backgrounds = 0
highlight SignColumn guibg=NONE ctermbg=NONE

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
      set guifont=Hack 12
    endif
  endif
else
  set fillchars=vert:\┃
  hi VertSplit cterm=NONE
endif
