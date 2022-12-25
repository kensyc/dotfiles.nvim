require('telescope').setup({
    extensions = {
        undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
                preview_height = 0.8,
            },
            mappings = require("config.keymaps").undo_mappings
        },
    },
})
require('telescope').load_extension 'fzf'
require('telescope').load_extension 'file_browser'
require('telescope').load_extension 'undo'
