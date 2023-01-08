vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require('indent_blankline').setup {
    char = '┊',
    show_trailing_blankline_indent = true,
    show_current_context = true,
}

-- fix space char turning blue by reloading the theme
vim.cmd.colorscheme(require('config.theme').lualine_theme)
