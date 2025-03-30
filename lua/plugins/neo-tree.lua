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
    filesystem = {
      bind_to_cwd = true,
      cwd_target = {
        current = "window",
      },
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
      window = {
        mappings = {
          ["F"] = "fuzzy_finder",
          ["/"] = "noop",
          ["z"] = "noop",
          ["Z"] = "close_all_nodes",
        }
      }
    }
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.cmd('Neotree')
  end,
}
