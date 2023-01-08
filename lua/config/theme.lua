vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"

-- catppuccin
require('catppuccin').setup({
    flavour = "mocha",
    integrations = {
        neotree = true,
    }
})

vim.cmd.colorscheme("catppuccin-mocha") -- latte, frappe, macchiato, mocha

-- onedark
-- require('onedark').setup({
--     style = 'darker'
-- })
-- require('onedark').load()

-- tokyonight
-- vim.cmd.colorscheme("tokyonight-night") -- night, storm, day, moon

-- oxocarbon
-- vim.opt.background = "dark"
-- vim.cmd.colorscheme("oxocarbon")

-- rose pine
-- vim.cmd.colorscheme('rose-pine')

return {
    lualine_theme = 'catppuccin'
}
