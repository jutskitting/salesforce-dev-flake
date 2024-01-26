vim.cmd('colorscheme 256_noir')

-- Define your colors
local colors = {
    background = "#000000",   -- Black background
    search_fg = "#FFFFFF",   
    search_bg = "#305959",    
    normal_fg = "#339966",   
    comment_fg = "#70862D",   
    line_nr_fg = "#70DBA6",   

    keyword_fg = "#006290", 
    function_fg = "#FFFFFF", -- white
    class_fg = "#FF4500",    
    constant_fg = "#FFFFFF", -- white
    special_fg = "#3069B4",  -- Hot pink
    operator_fg = "#3811C8", -- Light coral
    type_fg = "#FFFFFF",     -- white
    preproc_fg = "#4F7F50",  
    number_fg = "#787170",   -- Gold
    string_fg = "#288A8A",   
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
