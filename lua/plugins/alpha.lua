return {
  "goolord/alpha-nvim",
  -- dependencies = { 'echasnovski/mini.icons' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local dashboard = require('alpha.themes.theta')
    dashboard.file_icons.provider = "devicons"
    require 'alpha'.setup(require 'alpha.themes.theta'.config)
  end,
}
