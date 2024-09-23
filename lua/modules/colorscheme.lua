local cfg = require('plugins.colorscheme')

vim.cmd(string.format("colorscheme %s", cfg.name))
