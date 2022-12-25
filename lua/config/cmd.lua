-- Automatically run :PackerCompile whenever this file is updated
local packer_group = vim.api.nvim_create_augroup(
    'Packer',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    {
        'BufWritePost'
    },
    {
        pattern = 'plugins.lua',
        command = 'source <afile> | PackerCompile',
        group = packer_group
    }
)


-- local function get_reg(char)
-- 	return vim.api.nvim_exec([[echo getreg(']]..char..[[')]], true):gsub("[\n\r]", "^J")
-- end
--
-- local yank_clipboard_after_close_group = vim.api.nvim_create_augroup(
--     'YankClipboardAfterCloseGroup',
--     { clear = true }
-- )
--
-- vim.api.nvim_create_autocmd(
--     {
--         'VimLeave'
--     },
--     {
--         pattern = '*',
--         command = 'vim.api.nvim_exec([[call system("echo -n sddd | xclip -selection clipboard")]])',
--         group = yank_clipboard_after_close_group
--     }
-- )

-- Show relative numbers and absolute number on current line
local numbertoggle_group = vim.api.nvim_create_augroup(
    'NumberToggle',
    { clear = true }
)

vim.api.nvim_create_autocmd(
    {
        'BufEnter,FocusGained,InsertLeave,WinEnter'
    },
    {
        command = 'if &nu && mode() != "i" | set rnu | endif',
        group = numbertoggle_group
    }
)

vim.api.nvim_create_autocmd(
    {
        'BufLeave,FocusLost,InsertEnter,WinLeave'
    },
    {
        command = 'if &nu | set nornu | endif',
        group = numbertoggle_group
    }
)

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup(
    'YankHighlight',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
        callback = function()
            vim.highlight.on_yank()
        end,
        group = highlight_group,
        pattern = '*',
    }
)
