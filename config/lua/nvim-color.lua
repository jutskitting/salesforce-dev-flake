vim.cmd('colorscheme 256_noir')

-- Define your colors
local colors = {
    background = "#000000",   -- Black background
    search_bg = "#000000",   
    search_fg = "#FFFFFF",    
    comment_fg = "#8CC6D9",   -- Deep blood red for comments
    normal_fg = "##666699",   
    line_nr_fg = "#FF0000",   -- white

    keyword_fg = "#006699", 
    function_fg = "#FFFFFF", -- white
    class_fg = "#FF4500",    
    constant_fg = "#FFFFFF", -- white
    special_fg = "#FF69B4",  -- Hot pink
    operator_fg = "#F08080", -- Light coral
    type_fg = "#FFFFFF",     -- white
    preproc_fg = "#FF7F50",  
    number_fg = "#FFD700",   -- Gold
    string_fg = "#A6A6BF",   
}

-- Set the colors for the highlight groups
vim.api.nvim_set_hl(0, "Normal", { bg = colors.background, fg = colors.normal_fg })
vim.api.nvim_set_hl(0, "Search", { bg = colors.search_bg, fg = colors.search_fg })
vim.api.nvim_set_hl(0, "IncSearch", { bg = colors.search_bg, fg = colors.search_fg }) -- For incremental search
vim.api.nvim_set_hl(0, "Comment", { fg = colors.comment_fg })

-- Set line numbers to the same red as strings
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.line_nr_fg })

vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.line_nr_fg })

-- Apply the colors to the highlight groups

vim.api.nvim_set_hl(0, "Number", { fg = colors.number_fg })
vim.api.nvim_set_hl(0, "Keyword", { fg = colors.keyword_fg })
vim.api.nvim_set_hl(0, "Function", { fg = colors.function_fg })
vim.api.nvim_set_hl(0, "Class", { fg = colors.class_fg })
vim.api.nvim_set_hl(0, "Constant", { fg = colors.constant_fg })
vim.api.nvim_set_hl(0, "Special", { fg = colors.special_fg })
vim.api.nvim_set_hl(0, "Operator", { fg = colors.operator_fg })
vim.api.nvim_set_hl(0, "Type", { fg = colors.type_fg })
vim.api.nvim_set_hl(0, "PreProc", { fg = colors.preproc_fg })
vim.api.nvim_set_hl(0, "String", { fg = colors.string_fg })
