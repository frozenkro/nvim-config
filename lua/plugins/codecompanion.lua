local ollama_host = os.getenv("OLLAMA_HOST") -- include :11434 in route
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.pick",
  },
  opts = {
    adapters = {
      ollama_hosted = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "ollama_hosted",
          env = {
            url = ollama_host
          },
          schema = {
            model = {
              default = "qwen2.5-coder:32b",
            },
          },
        })
      end,
    },
    display = {
      action_palette = {
        height = 6,
        width = 10,
        provider = "default",
      },
      chat = {
        show_settings = "true",
        window = {
          position = "right", -- "right" interacts strangely with neo-tree
          width = 0.2,
          opts = {
            list = true,
          },
        },
      },
    },
    strategies = {
      chat = {
        adapter = "ollama_hosted",
      },
      inline = {
        adapter = "ollama_hosted",
      },
    },
    opts = {
      log_level = "DEBUG",
    },
  },
}
