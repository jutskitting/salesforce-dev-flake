vim.g.mapleader = " "
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=2
vim.opt.ignorecase = true
vim.o.expandtab = true
vim.o.smartindent=true
vim.o.number=true
vim.cmd('colorscheme 256_noir')
vim.o.wrap=true
vim.o.swapfile=false
vim.o.history=500
vim.o.cursorline=true
vim.o.scrolloff=20
vim.o.filetype = "on"
vim.opt.termguicolors = true
vim.opt.showtabline = 0                         -- always show tabs
vim.opt.fdc = "1"
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.updatetime = 2000                        -- faster completion (4000ms default)
vim.opt.foldclose = "all"
vim.opt.foldopen = "all"
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.ruler = true
vim.opt.numberwidth = 1                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "auto"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.scrolloff =  22                          -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.fillchars.eob=""
vim.opt.shortmess:append "c"
vim.opt.whichwrap:append("<,>,[,]")
vim.opt.iskeyword:append("-")

