return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "lua_ls",
        "robotframework_ls",
        "ruff",
        "bashls",
        "dockerls",
        "jsonls",
        "marksman",
        "grammarly",
        "yamlls",
      },
      automatic_installation = false,
    },
  },
}
