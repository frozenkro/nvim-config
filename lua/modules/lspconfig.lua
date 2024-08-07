-- Find the ls names and example configs here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local capabilities = vim.tbl_deep_extend('force',
  vim.lsp.protocol.make_client_capabilities(),
  require'cmp_nvim_lsp'.default_capabilities())

local servers = {
  lua_ls = {
    settings = { Lua = {} },
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT'
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
          }
        }
      })
      end,
    },
  tsserver = {},
  gopls = {},
  zls = {},
}

if vim.g.nix then
  for server_name,_ in pairs(servers) do
    require'lspconfig'[server_name].setup({
      capabilities = capabilities,
      settings = servers[server_name].settings,
      on_init = servers[server_name].on_init,
    })
  end
  else
    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'slyua',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require'lspconfig'[server_name].setup(server)
        end,
      }
    }
  end
