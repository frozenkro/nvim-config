-- Find the ls names and example configs here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local tb = require 'telescope.builtin'

local function lsp_keymap(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gK', vim.diagnostic.open_float)
  vim.keymap.set('n', 'gi', tb.lsp_implementations, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gK', vim.diagnostic.open_float)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

local lsps = {
  { "ts_ls" },
  { "gopls" },
  { "zls" },
  { "pyright" },
  {
    "clangd",
    {
      name = 'clangd',
      cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
      initialization_options = {
        fallback_flags = { '-std=c++17' },
      },
    },
  },
  -- {
  --     "csharp_ls",
  --     {
  --         settings = {
  --             csharp = {
  --                 solution = function()
  --                     local sln = os.getenv('CLS_SLN')
  --                     print('csharp_ls using: ', sln, ' as solution')
  --                 end,
  --             }
  --         },
  --     },
  -- },
  {
    "lua_ls",
    {
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
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
      settings = {
        Lua = {}
      }
    },
  },
  {
    "roslyn",
    {
      settings = {
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|code_lens"] = {
          dotnet_enable_references_code_lens = true,
        },
      },
    },
  },
}

for _, lsp in pairs(lsps) do
  local name, config = lsp[1], lsp[2]
  vim.lsp.enable(name)

  if not config then
    config = {}
  end

  if config.on_attach then
    prev_on_attach = config.on_attach
    config.on_attach = function(x, bufnr)
      prev_on_attach(x, bufnr)
      lsp_keymap(bufnr)
    end
  else
    config.on_attach = function(_, bufnr)
      lsp_keymap(bufnr)
    end
  end

  vim.lsp.config(name, config)
end
