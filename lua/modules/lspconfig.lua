-- Find the ls names and example configs here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local os = require'os'
local lspconfig = require'lspconfig'

lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

local function lsp_keymap(bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

lspconfig.tsserver.setup{
    on_attach = function(_, bufnr)
        lsp_keymap(bufnr)
    end,
}
lspconfig.gopls.setup{
    on_attach = function(_, bufnr)
        lsp_keymap(bufnr)
    end,
}
lspconfig.csharp_ls.setup{
    settings = {
        csharp = {
            solution = os.getenv('CLS_SLN'),
        }
    },
    on_attach = function(_, bufnr)
        lsp_keymap(bufnr)
    end,
}
-- lspconfig.omnisharp.setup({
--     cmd = { "dotnet", os.getenv("OMNISHARP_DLL") },
--     vim.cmd([[
--         let g:OmniSharp_autoselect_existing_sln = 1 
--     ]]),
--     root_dir = lspconfig.util.root_pattern('*.sln', '*.csproj'),
--     on_attach = function(client, bufnr)
--         print('omnisharp attached')
--         -- replaces vim.lsp.buf.definition()
--         vim.keymap.set('n', '<leader>gd', require'omnisharp_extended'.lsp_definition,
--             { desc = "go to definition" })

--         -- replaces vim.lsp.buf.type_definition()
--         vim.keymap.set('n', '<leader>D', require'omnisharp_extended'.lsp_type_definition,
--             { desc = "go to type definition" })

--         -- replaces vim.lsp.buf.references()
--         vim.keymap.set('n', '<leader>gr', require'omnisharp_extended'.lsp_references,
--             { desc = "find refs" })

--         -- replaces vim.lsp.buf.implementation()
--         vim.keymap.set('n', '<leader>gi', require'omnisharp_extended'.lsp_implementation,
--             { desc = "go to implementation" })
--     end,

--     settings = {
--       FormattingOptions = {
--         -- Enables support for reading code style, naming convention and analyzer
--         -- settings from .editorconfig.
--         EnableEditorConfigSupport = true,
--         -- Specifies whether 'using' directives should be grouped and sorted during
--         -- document formatting.
--         OrganizeImports = nil,
--       },
--       MsBuild = {
--         -- If true, MSBuild project system will only load projects for files that
--         -- were opened in the editor. This setting is useful for big C# codebases
--         -- and allows for faster initialization of code navigation features only
--         -- for projects that are relevant to code that is being edited. With this
--         -- setting enabled OmniSharp may load fewer projects and may thus display
--         -- incomplete reference lists for symbols.
--         LoadProjectsOnDemand = nil,
--       },
--       RoslynExtensionsOptions = {
--         -- Enables support for roslyn analyzers, code fixes and rulesets.
--         EnableAnalyzersSupport = nil,
--         -- Enables support for showing unimported types and unimported extension
--         -- methods in completion lists. When committed, the appropriate using
--         -- directive will be added at the top of the current file. This option can
--         -- have a negative impact on initial completion responsiveness,
--         -- particularly for the first few completion sessions after opening a
--         -- solution.
--         EnableImportCompletion = nil,
--         -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
--         -- true
--         AnalyzeOpenDocumentsOnly = nil,
--       },
--       Sdk = {
--         -- Specifies whether to include preview versions of the .NET SDK when
--         -- determining which version to use for project loading.
--         IncludePrereleases = true,
--       },
--     },
-- })
