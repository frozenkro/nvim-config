local schemes = {
  kanagawapaper = {
    repo = "sho-87/kanagawa-paper.nvim",
    name = "kanagawa-paper",
  },
  ares = {
    repo = "ab-dx/ares.nvim",
    name = "ares",
  },
  kanagawa = {
    repo = "rebelot/kanagawa.nvim",
    name = "kanagawa",
  },
  tokyonight = {
    repo = "folke/tokyonight.nvim",
    name = "tokyonight",
    transparent = true,
    styles = {
      sidebars = "transparent",
      -- floats = "transparent",
    },
    style = "night",
    -- style = "storm",
    -- style = "day",
    -- style = "moon",
  },
}

return schemes['tokyonight'];
