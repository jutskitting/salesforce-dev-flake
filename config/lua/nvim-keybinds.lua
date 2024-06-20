-- Set complete options
vim.o.completeopt = 'menuone,noinsert,noselect'

-- Define custom completion function in Lua
local function custom_complete(findstart, base)
  if findstart == 1 then
    -- Locate the start of the word
    local line = vim.fn.getline('.')
    local start = vim.fn.col('.') - 1
    while start > 0 and string.match(string.sub(line, start, start), '[%a.]') do
      start = start - 1
    end
    return start
  else
    -- Only show the completion menu if the base is longer than 4 characters
    if string.len(base) < 4 then
      return {}
    end

    -- Gather completion candidates from the current buffer
    local matches = {}
    local lines = vim.fn.getbufline('%', 1, '$')
    for _, line in ipairs(lines) do
      for match in string.gmatch(line, '%f[%a.]'..base..'[%w.]*') do
        table.insert(matches, match)
      end
    end

    -- Remove duplicates and limit the number of items to 4
    local unique_matches = {}
    local hash = {}
    for _, v in ipairs(matches) do
      if not hash[v] then
        table.insert(unique_matches, v)
        hash[v] = true
      end
    end

    return {unpack(unique_matches, 1, 4)}
  end
end

-- Register the custom_complete function in the global scope
_G.custom_complete = custom_complete

-- Set the completefunc globally
vim.o.completefunc = 'v:lua.custom_complete'

-- Automatically trigger completion after 4 characters are typed, only in insert mode
vim.api.nvim_create_autocmd("InsertCharPre", {
  pattern = "*",
  callback = function()
    if vim.fn.mode() == 'i' and vim.fn.col('.') > 4 then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-u>", true, true, true), 'n')
    end
  end
})

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
