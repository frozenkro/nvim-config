local scheme = require('utils.colorschemes')

local has_opts = scheme.transparent ~= nil or scheme.styles ~= nil or scheme.style ~= nil

return {
  scheme.repo,
  name = scheme.name,
  lazy = false,
  priority = 1000,
  dependencies = {
    'rktjmp/lush.nvim', -- required for ares.nvim
  },
  opts = has_opts and {
    transparent = scheme.transparent,
    styles = scheme.styles,
    style = scheme.style,
  } or nil,
}
