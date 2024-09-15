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
  }
}

local scheme = schemes['kanagawa'];

return {
  scheme.repo,
  name = scheme.name,
  lazy = false,
  priority = 1000,
  dependencies = {
    'rktjmp/lush.nvim', -- required for ares.nvim
  },
  config = function()
    vim.cmd(string.format("colorscheme %s", scheme.name))
  end,
}
