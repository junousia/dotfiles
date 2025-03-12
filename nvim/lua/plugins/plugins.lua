-- stylua: ignore

return {
    { "olimorris/onedarkpro.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "ellisonleao/gruvbox.nvim" },
    { "folke/tokyonight.nvim" },
    { "AlexvZyl/nordic.nvim" },
    { "sho-87/kanagawa-paper.nvim" },

    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "kanagawa-paper",
        },
    },

    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {
                pyright = {},
                ruff = {},
                robotframework_ls = {},
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
                "robot",
                "make",
                "gitcommit",
            },
        },
    },
}
