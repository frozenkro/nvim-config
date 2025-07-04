vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function(ev)
        local size = vim.fn.getfsize(ev.match)
        if size > 2 * 1024 * 1024 then -- 2MiB
            -- Temporarily disable Neo-tree's file handling for this buffer
            vim.b.neotree_disable = true
        end
    end,
})
