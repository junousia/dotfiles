return {
  { "olimorris/onedarkpro.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "AlexvZyl/nordic.nvim" },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "shisiw0rd/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- Enables transparent background
      terminal_colors = true,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-paper",
    },
  },
}
