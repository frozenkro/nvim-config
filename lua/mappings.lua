local builtin = require('telescope.builtin')
local notify = require('notify')
local oil = require('oil')
local dap = require('dap')

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

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').list_breakpoints() end)
vim.keymap.set('n', '<Leader>dc', function() require('dap').clear_breakpoints() end)
vim.keymap.set('n', '<Leader>dp', function() require('dap').pause() end)
vim.keymap.set('n', '<Leader>df', function() require('dap').focus_frame() end)
vim.keymap.set('n', '<Leader>du', function() require('dap').up() end)
vim.keymap.set('n', '<Leader>dd', function() require('dap').down() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)

vim.keymap.set('n', '<Leader>dv', '<Cmd>DapViewOpen<CR>')

local function collapse_all()
    vim.cmd('syntax on')
    vim.cmd('set foldmethod=syntax')
    vim.cmd('set foldlevel=0')
end
vim.keymap.set('n', '<Leader>c', collapse_all, { desc = 'recursive fold entire file based on filetype' })
vim.keymap.set('n', 'left', '<Cmd>foldclose<CR>', { desc = 'close fold at cursor' })
vim.keymap.set('n', 'right', '<Cmd>foldopen<CR>', { desc = 'open fold at cursor' })
