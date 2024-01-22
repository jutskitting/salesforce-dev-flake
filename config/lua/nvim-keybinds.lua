local opt = { noremap = true }

-- paste improvements
vim.api.nvim_set_keymap('x', '<leader>yy', '"+y', { noremap = true, silent = false})
vim.api.nvim_set_keymap('v', '<leader>yy', '"+y', { noremap = true, silent = false})

vim.api.nvim_set_keymap('x', '<leader>pp', '"+p', { noremap = true, silent = false})
vim.api.nvim_set_keymap('v', '<leader>pp', '"+p', { noremap = true, silent = false})
vim.api.nvim_set_keymap('n', '<leader>pp', '"+p', { noremap = true, silent = false})

