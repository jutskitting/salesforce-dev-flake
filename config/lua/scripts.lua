vim.api.nvim_exec([[
    au! BufRead,BufNewFile *.component setfiletype html
    au! BufRead,BufNewFile *.cls set filetype=java
    au! BufRead,BufNewFile *.cmp set filetype=html
    au! BufRead,BufNewFile *.trigger set filetype=java
    au! BufRead,BufNewFile *.page set filetype=java
]], false)
