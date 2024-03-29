vim.g.mapleader=' '
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('n', '<leader>ci', '<Cmd>edit ~/.config/nvim/lua/kaup/init.lua<CR>')
vim.keymap.set('n', '<leader>cr', '<Cmd>edit ~/.config/nvim/lua/kaup/remap.lua<CR>')
vim.keymap.set('n', '<leader>cb', '<Cmd>edit ~/.bashrc<CR>')
vim.keymap.set('n', '<leader>e', '<Cmd>Ex<CR>')
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>gh', '<Cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<leader>tn', '<Cmd>tabnew<CR>')
vim.keymap.set('n', '<leader>tc', '<Cmd>tabclose<CR>')

