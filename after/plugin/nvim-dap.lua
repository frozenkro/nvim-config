
local dap = require('dap')

vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>do', dap.step_over)
vim.keymap.set('n', '<leader>di', dap.step_into)
vim.keymap.set('n', '<leader>D', dap.repl.open)
vim.keymap.set('n','<leader>dq', dap.terminate)
