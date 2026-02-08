return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = false },
      toggle = { map = LazyVim.safe_keymap_set },
      words = { enabled = true },
      picker = {
        sources = {
          explorer = {
            auto_close = true,
          },
        },
      },
    },
  },
}
