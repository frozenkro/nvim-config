
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fd', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.git_files)
vim.keymap.set('n', '<leader>ff', '<cmd>lua TelescopeFindInFiles()<CR>', {noremap = true, silent = true})
function TelescopeFindInFiles()
    local input = vim.fn.input('Enter Search String: ')
    require('telescope.builtin').grep_string({ search = input })
end
