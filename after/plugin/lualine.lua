-- Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = require('config.theme').lualine_theme,
    component_separators = '|',
    section_separators = '',
    globalstatus = true
  },
}
