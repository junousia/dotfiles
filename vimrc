colorscheme twilight

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
set backspace=indent,eol,start

set tags=./tags,tags;/

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

highlight Tabs ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight Tabs ctermbg=darkgreen guibg=darkgreen
2match Tabs /\t/

" Remove extra whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
:nnoremap <silent ><C-x> :bnext<CR>
:nnoremap <silent> <C-z> :bprevious<CR>

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    set guifont=Andale\ Mono:h18

    let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
    if isdirectory(s:clang_library_path)
      let g:clang_library_path=s:clang_library_path
    endif
  else
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
  endif
endif

syntax on

filetype plugin on
filetype indent on
autocmd FileType c,cpp,java set formatoptions+=ro
autocmd FileType c,cpp set omnifunc=ccomplete#Complete
autocmd FileType vim,lua,nginx set shiftwidth=2 softtabstop=2
autocmd FileType xhtml,html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrows=0

" Map keys for TAGS
map <C-o> <C-T>
map <C-p> <C-]>
