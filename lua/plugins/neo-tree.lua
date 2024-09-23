return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = "v3.x",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    hide_hidden = false,
    filesystem = {
      window = {
        mappings = {
          ["F"] = "fuzzy_finder",
          ["/"] = "noop",
        }
      }
    }
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.cmd('Neotree')
  end,
}
