local builtin = require('telescope.builtin')
local notify = require('notify')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fr', builtin.registers)
vim.keymap.set('n', '<leader>fc', builtin.commands)
vim.keymap.set('n', '<leader>fh', builtin.search_history)
vim.keymap.set('n', '<leader>fch', builtin.command_history)

vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>',
	{ desc = 'Toggle Neotree file explorer' })

vim.keymap.set('n', '<C-,>', '<Cmd>vertical resize -10<CR>')
vim.keymap.set('n', '<C-.>', '<Cmd>vertical resize +10<CR>')

vim.keymap.set('n', '[b', '<Cmd>bprev<CR>')
vim.keymap.set('n', ']b', '<Cmd>bnext<CR>')

vim.keymap.set('n', '<leader>d', function () notify.dismiss({ pending = true, silent = true }) end)

local close_buffer_keep_window_open = function()
  local bufnum = vim.fn.bufnr()
  vim.cmd('bprev')
  vim.cmd(string.format('bd%s', bufnum))
end
vim.keymap.set('n', '<leader>q', close_buffer_keep_window_open)

