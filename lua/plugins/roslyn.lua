return {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
        choose_target = function(target)
            return vim.iter(target):find(function(item)
                if string.match(item, "MyCompas.sln") then
                    return true
                end
            end)
        end,
    },
}
