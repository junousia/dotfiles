vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

local opt = vim.opt

opt.termguicolors = true
opt.number = false
opt.relativenumber = false
opt.wrap = false
opt.compatible = false
opt.cindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.showcmd = false
opt.hlsearch = true
opt.incsearch = true
opt.ruler = true
opt.visualbell = true
opt.errorbells = false
opt.backup = false
opt.number = false
opt.ignorecase = false
opt.title = true
opt.ttyfast = true
opt.modeline = true
opt.modelines = 3
opt.shortmess:append("atI")
opt.startofline = false
opt.whichwrap:append("<,>,[,]h,l")
opt.backspace = "indent,eol,start"
opt.showmatch = true
opt.showmode = true
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.encoding = "utf-8"
opt.mouse = "a"
opt.swapfile = false
opt.virtualedit = "block"
opt.iskeyword:append("-")
opt.fillchars = { eob = " " }
