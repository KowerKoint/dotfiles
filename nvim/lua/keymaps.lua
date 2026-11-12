vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })
vim.keymap.set('n', 'x', '"_x', { noremap = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('n', 'ge', vim.diagnostic.open_float)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
