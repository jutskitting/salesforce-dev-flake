-- Your existing key mappings and other configurations
local opt = { noremap = true, silent = false }

-- Paste improvements
vim.api.nvim_set_keymap('x', '<leader>yy', '"+y', opt)
vim.api.nvim_set_keymap('v', '<leader>yy', '"+y', opt)
vim.api.nvim_set_keymap('x', '<leader>pp', '"+p', opt)
vim.api.nvim_set_keymap('v', '<leader>pp', '"+p', opt)
vim.api.nvim_set_keymap('n', '<leader>pp', '"+p', opt)
vim.api.nvim_set_keymap("v", "p", '"_dP', opt)

-- Open terminal, run npx command, and switch back to the original window
vim.api.nvim_set_keymap('n', '<Leader>ww', ":w <CR> :belowright 15sp <CR> :terminal npx sf project deploy start --source-dir '%' --ignore-conflicts <CR> :wincmd k <CR>", opt)

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h <CR>', opt)
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j <CR>', opt)
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k <CR>', opt)
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l <CR>', opt)

require("toggleterm").setup{}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({cmd = "lazygit", hidden = true, direction = "float"})
local force = Terminal:new({cmd = "force", hidden = false, direction = "float"})

function _lazygit_toggle()
  lazygit:toggle()
end

function _force_toggle()
  local file_path = vim.fn.expand('%:p') -- Gets the full path of the current file
  local file_name = vim.fn.expand('%:t') -- Gets the name of the current file
  local full_command = "force " .. file_path .. " " .. file_name .. "; bash" -- Combine command, path, and name
  force.cmd = full_command
  force:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fo", "<cmd>lua _force_toggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', "<leader>tt", "<Cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true })
