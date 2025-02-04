-- Visualizes open buffers as tabs
return {
    'akinsho/bufferline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    opts = {
        options = {
            themable = true,
            show_close_icon = false,
            numbers = function(opts)
                return opts.ordinal
            end,
        },
    },
}
