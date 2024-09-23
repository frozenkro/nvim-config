local scheme = require('utils.colorschemes')
return {
  scheme.repo,
  name = scheme.name,
  lazy = false,
  priority = 1000,
  dependencies = {
    'rktjmp/lush.nvim', -- required for ares.nvim
  },
  opts = {
    transparent = scheme.transparent,
    styles = scheme.styles,
    style = scheme.style,
  },
}
