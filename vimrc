colorscheme twilight

set nowrap
set nocompatible    " use vim defaults
set ls=2            " allways show status line
set smartindent
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set expandtab
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
    else
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
  endif
endif

syntax on

filetype plugin on

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1
let g:NERDTreeDirArrows=0

" Map keys for TAGS
map <C-o> <C-T>
map <C-p> <C-]>
