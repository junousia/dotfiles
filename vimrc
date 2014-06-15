set nowrap
set nocompatible    " use vim defaults
set ls=2            " allways show status line
set autoindent
set cindent
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set expandtab
set smarttab
set copyindent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set number          " show line numbers
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

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" NeoBundle
if has('vim_starting')
   set nocompatible
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

filetype plugin indent on

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'honza/vim-snippets'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/upAndDown'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'vim-scripts/DoxygenToolkit.vim'
NeoBundle 'vim-scripts/ScrollColors'
NeoBundle 'vim-scripts/cmake'
NeoBundle 'vim-scripts/vim-bookmarks'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'bling/vim-airline'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'edkolev/tmuxline.vim'
call neobundle#end()

" GitGutter
let g:gitgutter_sign_column_always = 1

" Syntastic
let g:syntastic_python_checkers = ['pylint']

"Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

" If you want UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
NeoBundleCheck " prompt to install new packages

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/

" Highlight tabs
highlight Tabs ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight Tabs ctermbg=darkgreen guibg=darkgreen
2match Tabs /\t/

" Remove trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Cycle buffers
:nnoremap <silent> <C-x> :bnext<CR>
:nnoremap <silent> <C-z> :bprevious<CR>

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    set guifont=Andale\ Mono:h14
    " Fix for libclang path on OSX
    let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
    if isdirectory(s:clang_library_path)
      let g:clang_library_path=s:clang_library_path
    endif
  endif
  else
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
endif

" Filetypes
filetype plugin on
autocmd FileType c,cpp,java set formatoptions+=ro
autocmd FileType c,cpp set omnifunc=ccomplete#Complete
autocmd FileType vim,lua,nginx set shiftwidth=2 softtabstop=2
autocmd FileType xhtml,html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrows=1
let g:NERDTreeMinimalUI = 1

" CtrlP
nnoremap <C-b> :CtrlPBuffer<cr>

"Tagbar
nnoremap <silent> § :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1

" Tags
set tags=tags;
map <C-o> <C-T>
map <C-i> g<C-]>

" Set syntax highlighting on
syntax on

" Bookmarks
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
let g:bookmark_auto_close = 1

" Colorscheme
colorscheme Tomorrow-Night
