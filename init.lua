local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/plenary.nvim'

-- Check if plenary is already installed
if fn.empty(fn.glob(install_path)) > 0 then
  print("Installing plenary.nvim...")
  fn.system({'git', 'clone', 'https://github.com/nvim-lua/plenary.nvim', install_path})
  print("Plenary installed!")
  vim.cmd('packadd plenary.nvim')
end

-- Function to install packages asynchronously and show notifications
local Job = require('plenary.job')

-- Leader key
vim.g.mapleader = ","

local function install_packages(packages)
  for _, package in ipairs(packages) do
    local handle = io.popen('pip show ' .. package .. ' 2>&1')
    local result = handle:read("*a")
    handle:close()
    if result:match("not found") then
      vim.notify('Installing ' .. package .. '...', "info", { title = "Package Installation" })
      Job:new({
        command = 'pip',
        args = { 'install', package },
        on_exit = function(j, return_val)
          if return_val == 0 then
            vim.notify('Successfully installed ' .. package .. '.', "info", { title = "Package Installation" })
          else
            vim.notify('Failed to install ' .. package .. '.', "error", { title = "Package Installation" })
          end
        end,
      }):start()
    else
      vim.notify(package .. ' is already installed.', "info", { title = "Package Check" })
    end
  end
end

local function get_python_path()
  local venv = os.getenv('VIRTUAL_ENV')
  if venv then
    return venv .. '/bin/python'
  else
    return '/usr/bin/env python3'
  end
end

-- Ensure packer.nvim is installed
local function ensure_packer()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Packer setup
packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Add your plugins here
  use 'rcarriga/nvim-notify'
  use 'direnv/direnv.vim'
  use 'jmcantrell/vim-virtualenv'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'nvim-lua/plenary.nvim'
  use 'sainnhe/everforest'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    "mfussenegger/nvim-dap",
    requires = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "nvim-neotest/nvim-nio",
    }
  }
  use 'kyazdani42/nvim-web-devicons'
  use 'kepano/flexoki-neovim'
  use 'folke/tokyonight.nvim'
  use 'ellisonleao/gruvbox.nvim'
  use 'rebelot/kanagawa.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {'neovim/nvim-lspconfig'}
  use {'williamboman/nvim-lsp-installer'}
  use 'catppuccin/nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'tpope/vim-sensible'
  use 'kergoth/vim-bitbake'
  use 'Raimondi/delimitMate'
  use 'MarcWeber/vim-addon-mw-utils'
  use 'tpope/vim-fugitive'
  use 'flazz/vim-colorschemes'
  use 'majutsushi/tagbar'
  use 'vim-scripts/DoxygenToolkit.vim'
  use 'vim-scripts/cmake'
  use 'vim-scripts/vim-bookmarks'
  use 'airblade/vim-gitgutter'
  use 'airblade/vim-rooter'
  use 'vim-scripts/YankRing.vim'
  use 'ntpeters/vim-better-whitespace'
  use 'triglav/vim-visual-increment'
  use 'vim-scripts/Mark--Karkat'
  use 'milkypostman/vim-togglelist'
  use 'tpope/vim-markdown'
  use 'dhruvasagar/vim-zoom'
  use {
    "andythigpen/nvim-coverage",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("coverage").setup()
    end,
  }
  use 'ryanoasis/vim-devicons'
  use 'metakirby5/codi.vim'
  use 'tpope/vim-surround'
  use {'psf/black', branch = 'stable'}
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'
  use 'Hubro/tree-sitter-robot'
  use "lukas-reineke/lsp-format.nvim"
  use {
    "PedramNavid/dbtpal",
    config = function()
      local dbt = require("dbtpal")
      dbt.setup({
        path_to_dbt = "dbt",
        path_to_dbt_profiles_dir = vim.fn.expand("~/.dbt"),
        extended_path_search = true,
        protect_compiled_files = true,
      })

      vim.keymap.set("n", "<leader>drf", dbt.run)
      vim.keymap.set("n", "<leader>drp", dbt.run_all)
      vim.keymap.set("n", "<leader>dtf", dbt.test)
      vim.keymap.set("n", "<leader>dm", require("dbtpal.telescope").dbt_picker)
      require("telescope").load_extension("dbtpal")
    end,
    requires = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope.nvim" } },
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

require("coverage").setup {
  commands = true,
  highlights = {
    covered = { fg = "#C3E88D" },
    uncovered = { fg = "#F07178" },
  },
  signs = {
    covered = { hl = "CoverageCovered", text = "▎" },
    uncovered = { hl = "CoverageUncovered", text = "▎" },
  },
  summary = {
    min_coverage = 80.0,
  },
}

-- LSP setup
local nvim_lsp = require('lspconfig')
vim.notify = require("notify")

nvim_lsp.robotframework_ls.setup{}

nvim_lsp.volar.setup{
  filetypes = { 'html', 'jinja2' },
  on_attach = function(client, bufnr)
    -- Additional configuration
  end,
}

local api = require("nvim-tree.api")

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Change tree root to the selected node ("CD")
  vim.keymap.set("n", "<leader>t", api.tree.change_root_to_node, opts("Change Directory (CD)"))
  -- Change tree root to the parent directory (the opposite of CD)
  vim.keymap.set("n", "<leader>u", api.tree.change_root_to_parent, opts("Go Up Directory"))

  -- Map Enter to open a file or directory
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))

  -- Optional: you can also map 'o' and 'l' for opening,
  -- and 'h' for navigating to the parent (closing a directory).
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "h", api.node.navigate.parent, opts("Close Directory"))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  view = {
    width = 30,
  },
  sort = {
    sorter = "case_sensitive",
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})


require('lualine').setup {
  options = {
    theme = 'auto',
    section_separators = {'', ''},
    component_separators = {'', ''},
    icons_enabled = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype',
      {
        function()
          local venv = os.getenv("VIRTUAL_ENV")
          return venv and " " .. vim.fn.fnamemodify(venv, ":t") or ''
        end,
        color = { fg = '#fabd2f', gui = 'bold' },
      },
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Basic Settings
vim.opt.wrap = false
vim.opt.compatible = false
vim.opt.cindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.scrolloff = 3
vim.opt.showcmd = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ruler = true
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.backup = false
vim.opt.number = false
vim.opt.ignorecase = false
vim.opt.title = true
vim.opt.ttyfast = true
vim.opt.modeline = true
vim.opt.modelines = 3
vim.opt.shortmess:append("atI")
vim.opt.startofline = false
vim.opt.whichwrap:append("<,>,[,]h,l")
vim.opt.backspace = "indent,eol,start"
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.virtualedit = "block"
vim.opt.iskeyword:append("-")
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")
vim.opt.fillchars = { eob = ' ' }

-- Additional Configuration
vim.cmd([[
  set termguicolors
  colorscheme kanagawa-dragon
  highlight Normal guibg=NONE ctermbg=NONE
  highlight clear SignColumn
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
]])

-- Mappings
vim.api.nvim_set_keymap('n', '+', '5<C-W>>', { noremap = true })
vim.api.nvim_set_keymap('n', '-', '5<C-W><', { noremap = true })
vim.api.nvim_set_keymap('n', '\'', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '§', ':TagbarToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'z', ':cp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'x', ':cn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'X', 'y/""<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':Black<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-e>', ':GitGutterStageHunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-r>', ':GitGutterUndoHunk<CR>', { noremap = true, silent = true })

-- Other settings
vim.opt.autoread = true
vim.opt.signcolumn = "yes"
vim.cmd("au CursorHold * checktime")

-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "robot", "yaml", "make", "gitcommit" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}

-- FZF Mappings
vim.api.nvim_set_keymap('n', '<C-g>', ':GFiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-b>', ':Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':History<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rg', ':Rg<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fl', ':Lines<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', ':Commits<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fd', ':BCommits<CR>', { noremap = true, silent = true })

vim.g.fzf_layout = { window = { width = 0.9, height = 0.6, relative = true, yoffset = 1.0 } }
vim.g.fzf_history_dir = vim.fn.expand('~/.local/share/fzf-history')

-- LSP settings
local lsp_installer = require("nvim-lsp-installer")
nvim_lsp.vscode_markdown = {
  cmd = { "node", "${HOME}/.local/node_modules/vscode-langservers-extracted/bin/vscode-md-languageserver", "--stdio" },
  filetypes = { "markdown" },
}

lsp_installer.on_server_ready(function(server)
    server:setup({})
end)

nvim_lsp.pyright.setup{}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

vim.fn.sign_define("DiagnosticSignError", { text = "○", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "○", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "∘", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "∘", texthl = "DiagnosticSignHint" })

vim.cmd [[
  highlight DiagnosticSignError guibg=NONE
  highlight DiagnosticSignWarn guibg=NONE
  highlight DiagnosticSignInfo guibg=NONE
  highlight DiagnosticSignHint guibg=NONE
]]

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    source = "always",
  },
})

vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })

-- Import nvim-dap and configure for Python
local dap = require('dap')
local dapui = require('dapui')
local dap_virtual_text = require('nvim-dap-virtual-text')

dap.adapters.python = {
  type = 'executable',
  command = get_python_path(),
  args = { '-m', 'debugpy.adapter' }
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = function()
      return vim.fn.input('Path to file: ', vim.fn.getcwd() .. '/', 'file')
    end,
    pythonPath = get_python_path,
    args = function()
      local input = vim.fn.input('Command-line arguments (space-separated): ')
      return vim.split(input, ' ')
    end
  }
}

dapui.setup()
dap_virtual_text.setup()

-- Key mappings for dap
vim.api.nvim_set_keymap('n', '<F5>', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>B', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>du', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })

-- Configure null-ls
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})
local direnv_allow_cmd = "direnv allow"

vim.api.nvim_create_autocmd("User", {
  pattern = "DirenvLoaded",
  callback = function()
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.pylint.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.code = diagnostic.message_id
          end
        }),
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black.with({
          extra_args = { "--line-length", "88" }
        }),
        null_ls.builtins.formatting.ruff,
        null_ls.builtins.diagnostics.flake8.with({
          extra_args = { "--max-line-length=120" }
        }),
        null_ls.builtins.diagnostics.ruff,
      }
    })
  end
})

-- Key mappings for LSP
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

-- Enable virtual text for diagnostics
vim.diagnostic.config({
  virtual_text = {
    source = "always",
    prefix = "∘"
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always"
  }
})

-- Create a command to install the packages
vim.api.nvim_create_user_command('InstallPythonPackages', function()
  install_packages({'black', 'flake8', 'ruff', 'pylint'})
end, {})

-- Optional key mapping to install the packages
vim.api.nvim_set_keymap('n', '<leader>ip', ':InstallPythonPackages<CR>', { noremap = true, silent = true })
