require('lazy').setup({
    -- Speed
    -- { 'nathom/filetype.nvim' },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- LSP status updates
            { 'j-hui/fidget.nvim', tag = 'legacy' },

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
            'jose-elias-alvarez/null-ls.nvim'
        }
    },
    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            {"nvim-tree/nvim-web-devicons"},
            --Please make sure you install markdown and markdown_inline parser
            {"nvim-treesitter/nvim-treesitter"}
        }
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets'
        },
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'debugloop/telescope-undo.nvim'
        }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-file-browser.nvim' },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    },

    -- File tree
    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        }
    },
    { 'stevearc/oil.nvim' },

    -- Themes
    { 'catppuccin/nvim', name = 'catppuccin' },
--    { 'navarasu/onedark.nvim' },
--    { 'folke/tokyonight.nvim' },
--    { 'nyoom-engineering/oxocarbon.nvim' },
--    { 'rose-pine/neovim', name = 'rose-pine' },

    -- UI
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'nvim-lualine/lualine.nvim' },

    -- Git
    { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'sindrets/diffview.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

    -- validated untill here
    -- Utility
    { 'numToStr/Comment.nvim' },
    { 'kylechui/nvim-surround' },
    { 'tpope/vim-repeat' },
    { 'ellisonleao/glow.nvim' },
    { 'dccsillag/magma-nvim', build = ':UpdateRemotePlugins' },

    -- DB
    { 'tpope/vim-dadbod' },
    { 'kristijanhusak/vim-dadbod-ui' },
    { 'kristijanhusak/vim-dadbod-completion' },
})
