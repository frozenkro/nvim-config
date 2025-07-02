if vim.fn.has('win32') ~= 1 and vim.fn.has('wsl') ~= 1 then
    vim.g.clipboard = {
        name = 'WL-Clipboard',
        copy = {
            ['+'] = 'wl-copy',
            ['*'] = 'wl-copy',
        },
        paste = {
            ['+'] = 'wl-paste',
            ['*'] = 'wl-paste',
        },
        cache_enabled = 1,
    }
end
