return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        routes = {
            {
                filter = {
                    event = "msg_show",
                    min_height = 10,
                },
                view = "split",
            },
            {
                filter = {
                    event = "msg_show",
                    kind = {
                        "shell_out",
                        "shell_err"
                    }
                },
                view = "split",
                opts = {
                    level = "info",
                    skip = false,
                    replace = false,
                }
            }
        },
        lsp = {
            progress = {
                enabled = false, -- Breaks roslyn.. would love to re-enable
            },
        },
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    }
}
