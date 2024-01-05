require('kaup.remap')

vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab=true
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.autoindent=true

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.tf",
    command = "set filetype=terraform"
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
		'VonHeikemen/lsp-zero.nvim',
		branch='v2.x',
		dependencies = {
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        cmd='TSUpdate'
    },
    -- {
    --     "savq/melange-nvim",
    --     config = function()
    --         vim.opt.termguicolors = true
    --         vim.cmd.colorscheme 'melange'
    --     end
    -- },
    -- {
    --     'neanias/everforest-nvim',
    --     lazy = false,
    --     version = false,
    --     priority = 1000,
    --     config = function()
    --         require('everforest').setup()
    --         vim.opt.background = 'dark'
    --         vim.cmd('colorscheme everforest')
    --     end
    -- },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require('Comment').setup()
        end
    },
    {
        "preservim/nerdtree",
        lazy = false,
        config = function()
           vim.keymap.set('n', '<leader>nt', '<Cmd>NERDTreeToggle<CR>')
           vim.api.nvim_create_autocmd({"VimEnter"}, { command = "NERDTree" })
       end
   },
  {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {}
  },
  {
      'mfussenegger/nvim-dap',
  },
  {
      'mfussenegger/nvim-dap-python',
  },
  {
      'scottmckendry/cyberdream.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        require("cyberdream").setup({
          transparent = true,
          italic_comments = true,
          hide_fillchars = true,
          borderless_telescope = true,
        })
        vim.cmd("colorscheme cyberdream")
      end,
  }
},{})


local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "javascript", "typescript", "cmake", "go", "json", "html", "css"},
    sync_install=false,
    auto_install=true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}

require'dap-python'.setup('~/venvs/debugpy/bin/python')
require'dap'.adapters.python = {
    type = 'executable',
    command = os.getenv('VIRTUAL_ENV') and os.getenv('VIRTUAL_ENV')..'/bin/python' or '/usr/bin/python',
    args = { '-m', 'debugpy.adapter' }

}

require'dap'.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch File',
    program = "${file}",
    pythonPath = function()
      return os.getenv('VIRTUAL_ENV') and os.getenv('VIRTUAL_ENV')..'/bin/python' or '/usr/bin/python'
    end,
  },
}
