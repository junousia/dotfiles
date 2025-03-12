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
        opts = {
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
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "vim",
                "yaml",
                "robot",
                "make",
                "gitcommit",
            },
        },
    },
}
