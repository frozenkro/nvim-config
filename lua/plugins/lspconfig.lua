local nvset = require'modules.nv'
local lspconfig = require'modules.lspconfig'

return {
  'neovim/nvim-lspconfig',
  config = lspconfig,
  dependencies = {
    {
      'williamboman/mason.nvim',
      enabled = nvset(true, false),
      config = true,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      enabled = nvset(true, false),
    },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      enabled = nvset(true, false),
    },
  },
}
