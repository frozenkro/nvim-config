
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fd', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.git_files)
