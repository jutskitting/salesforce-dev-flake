local opt = { noremap = true, silent = false }

-- paste improvements
vim.api.nvim_set_keymap('x', '<leader>yy', '"+y', opt)
vim.api.nvim_set_keymap('v', '<leader>yy', '"+y', opt)

vim.api.nvim_set_keymap('x', '<leader>pp', '"+p', opt)
vim.api.nvim_set_keymap('v', '<leader>pp', '"+p', opt)
vim.api.nvim_set_keymap('n', '<leader>pp', '"+p', opt)

vim.api.nvim_set_keymap("v", "p", '"_dP', opt)


-- Open terminal, run nix run, and switch back to the original window
vim.api.nvim_set_keymap('n', '<Leader>ww', ':w <CR> :belowright 15sp <CR> :terminal npx sf project deploy start --source-dir '%p' --ignore-conflicts <CR> :wincmd k <CR>', opt)

-- toggle term for future
-- au FileType java noremap <buffer> <leader>fo <Cmd>execute v:count . 'ToggleTerm' <CR> force <CR>

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h <CR>', opt)
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j <CR>', opt)
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k <CR>', opt)
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l <CR>', opt)

