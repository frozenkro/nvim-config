return {
  "nvim-treesitter/nvim-treesitter",
  ensure_installed = { "c", "lua", "vim", "markdown", "typescript", "go", "javascript", "html", "css", "bash" },
  auto_install = false,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then 
        return true
      end 
    end,
  },
}
