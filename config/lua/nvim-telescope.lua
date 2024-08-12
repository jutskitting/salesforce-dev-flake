
local map_opt = { noremap = true, silent = true }

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

local function search_selected_text()
  local selected_text = vim.fn.getreg('"')
  if selected_text ~= "" then
    require('telescope.builtin').find_files({ default_text = selected_text }).git_files()
  else
    require('telescope.builtin').find_files().git_files()
  end
end

_G.search_selected_text = search_selected_text

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').git_files()<CR>", map_opt)
vim.api.nvim_set_keymap("v", "<leader>ff", "y<cmd>lua search_selected_text()<CR>", { noremap = true, silent = true })
