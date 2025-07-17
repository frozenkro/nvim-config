return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "OXY2DEV/markview.nvim" },
  lazy = false,
  build = ":TSUpdate",
  branch = 'master',
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "markdown",
        "markdown_inline",
        "typst",
        "yaml",
        "typescript",
        "go",
        "javascript",
        "html",
        "css",
        "bash",
        "vimdoc",
        "luadoc",
        "vim",
      },
      auto_install = false,
      highlight = {
        enable = true,
      },
    })
  end,
}
