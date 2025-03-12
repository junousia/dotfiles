return {
  {
    "rebelot/kanagawa.nvim",
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,
    dimInactive = false,
    terminalColors = true,
    colors = {
      palette = {},
      theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors)
      return {}
    end,
    theme = "dragon",
    background = {
      dark = "wave",
      light = "lotus",
    },
  },
}
