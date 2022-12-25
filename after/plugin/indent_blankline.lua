vim.opt.list = true
vim.opt.listchars:append "space:⋅"

require('indent_blankline').setup {
    char = '┊',
    show_trailing_blankline_indent = true,
    show_current_context = true,
}
