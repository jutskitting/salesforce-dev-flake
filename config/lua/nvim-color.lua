vim.cmd("colorscheme orbital")

-- Define your colors
local colors = {
    background = "#000000",   
    search_bg = "#CCCCCC",    
    search_fg = "#000000",    
    comment_fg = "#4a9a99",   
    normal_fg = "#4d7e1b",   
    line_nr_fg = "#AACCAA",   

    keyword_fg = "#66b3CC",  
    function_fg = "#669933", 
    class_fg = "#99ad85",    
    constant_fg = "#FFFFFF", 
    special_fg = "#6c8993",  
    operator_fg = "#4d9900", 
    type_fg = "#527a66",     
    preproc_fg = "#ac8f39",  
    number_fg = "#40BF8C",    
    string_fg = "#998FA3",   
    special_char_fg = "#118FA3",   
}
--
-- -- Set the colors for the highlight groups
vim.api.nvim_set_hl(0, "Normal", { bg = colors.background, fg = colors.normal_fg })
vim.api.nvim_set_hl(0, "Search", { bg = colors.search_bg, fg = colors.search_fg })
vim.api.nvim_set_hl(0, "IncSearch", { bg = colors.search_bg, fg = colors.search_fg }) -- For incremental search
vim.api.nvim_set_hl(0, "Comment", { fg = colors.comment_fg })
--
-- -- Set line numbers to the same red as strings
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.line_nr_fg })
--
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.line_nr_fg })
--
-- -- Apply the colors to the highlight groups
--
vim.api.nvim_set_hl(0, "Number", { fg = colors.number_fg })
vim.api.nvim_set_hl(0, "Keyword", { fg = colors.keyword_fg })
vim.api.nvim_set_hl(0, "Function", { fg = colors.function_fg })
vim.api.nvim_set_hl(0, "Class", { fg = colors.class_fg })
vim.api.nvim_set_hl(0, "Constant", { fg = colors.constant_fg })
vim.api.nvim_set_hl(0, "Special", { fg = colors.special_fg })
vim.api.nvim_set_hl(0, "Operator", { fg = colors.operator_fg })
vim.api.nvim_set_hl(0, "Type", { fg = colors.type_fg })
vim.api.nvim_set_hl(0, "PreProc", { fg = colors.preproc_fg })
vim.api.nvim_set_hl(0, 'SpecialChar', { fg = colors.special_char_fg })
--
vim.api.nvim_set_hl(0, "String", { fg = colors.string_fg })

-- Set background color for the current line
vim.api.nvim_set_hl(0, "CursorLine", { bg = '#262626' })

-- Set background color for the current column
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = '#262626' })

vim.api.nvim_set_hl(0, 'Conditional', { fg = '#c6a339' })
vim.api.nvim_set_hl(0, 'Identifier', { fg = '#8c8673' })
