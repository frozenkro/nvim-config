local lazy = require'config.lazy'

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      enabled = lazy.set(true, false),
      config = true,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      enabled = lazy.set(true, false),
    },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      enabled = lazy.set(true, false),
    },
  },
}
