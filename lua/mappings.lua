local builtin = require('telescope.builtin')
local notify = require('notify')
local oil = require('oil')

local ff_no_ignore = function() builtin.find_files({ no_ignore = true }) end

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>FF', ff_no_ignore, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.resume, {})

vim.keymap.set('n', '<leader>e', oil.toggle_float,
  { desc = 'Toggle oil browser' })

vim.keymap.set('n', '<C-,>', '<Cmd>vertical resize -10<CR>')
vim.keymap.set('n', '<C-.>', '<Cmd>vertical resize +10<CR>')
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "+", [[<cmd>horizontal resize +10<cr>]])
vim.keymap.set("n", "_", [[<cmd>horizontal resize -10<cr>]])

vim.keymap.set('n', '[[', '<Cmd>bprev<CR>')
vim.keymap.set('n', ']]', '<Cmd>bnext<CR>')
vim.keymap.set('n', '<S-Tab>', '<Cmd>bprev<CR>')
vim.keymap.set('n', '<Tab>', '<Cmd>bnext<CR>')
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>",
  { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

vim.keymap.set('n', '<leader>d', function() notify.dismiss({ pending = true, silent = true }) end)

local close_buffer_keep_window_open = function(force)
  local bufnum = vim.fn.bufnr()
  vim.cmd('bprev')

  forceStr = ''
  if force then
    forceStr = '!'
  end
  vim.cmd(string.format('bd%s%s', forceStr, bufnum))
end

local close_buffer_keep_window_open_soft = function() close_buffer_keep_window_open(false) end
local close_buffer_keep_window_open_force = function() close_buffer_keep_window_open(true) end
vim.keymap.set('n', '<leader>q', close_buffer_keep_window_open_soft)
vim.keymap.set('n', '<leader>fq', close_buffer_keep_window_open_force)

vim.keymap.set('n', '<C-Left>', '<Cmd>wincmd h<CR>')
vim.keymap.set('n', '<C-Down>', '<Cmd>wincmd j<CR>')
vim.keymap.set('n', '<C-Up>', '<Cmd>wincmd k<CR>')
vim.keymap.set('n', '<C-Right>', '<Cmd>wincmd l<CR>')

vim.keymap.set('n', '<C-b>', '<Cmd>DapToggleBreakpoint<CR>')
