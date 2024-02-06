-- config/lua/nvim-telescope.lua
local telescope = require('telescope')
telescope.setup({
  defaults = {
    -- Enabling ignore_case
    ignore_case = true,
    -- Enabling smart_case
    smart_case = true,
  }
})

-- Setting up key mappings
local map_opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').git_files()<CR>", map_opt)
