local want = require('utils.want')
local local_cc, local_cc_err = want('local.codecompanion')

local ollama_host = os.getenv("OLLAMA_HOST") -- include :11434 in route
local adapters = {
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
}
local strategies = {
    chat = {
        adapter = "ollama_hosted",
    },
    inline = {
        adapter = "ollama_hosted",
    },
}

if (local_cc) then
    adapters = local_cc.adapters
    strategies = local_cc.strategies
end




return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "echasnovski/mini.pick",
    },
    opts = {
        adapters = adapters,
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
        strategies = strategies,
        opts = {
            log_level = "DEBUG",
        },
    },
}
