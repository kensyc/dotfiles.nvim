vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"


require('ibl').setup({
  indent = { char = '┊' },
  whitespace = {
    remove_blankline_trail = false,
  },
  scope = { show_start = true }
})



-- fix space char turning blue by reloading the theme
vim.cmd.colorscheme(require('config.theme').lualine_theme)
vim.cmd [[highlight IndentBlanklineContextChar guifg=#1e1e2e guibg=#1e1e2e]]
-- vim.g.indent_blankline_context_char = "▎"
