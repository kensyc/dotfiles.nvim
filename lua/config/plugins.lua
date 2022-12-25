require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Speed
    use 'lewis6991/impatient.nvim'
    use 'nathom/filetype.nvim'

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- LSP status updates
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
            'jose-elias-alvarez/null-ls.nvim'
        }
    }

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets'
        },
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'debugloop/telescope-undo.nvim'
        }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope-file-browser.nvim' }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- File tree
    use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }

    -- Themes
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use 'navarasu/onedark.nvim'
    use 'folke/tokyonight.nvim'
    use 'nyoom-engineering/oxocarbon.nvim'
    use { 'rose-pine/neovim', as = 'rose-pine' }

    -- UI
    use 'nvim-lualine/lualine.nvim'
    use 'lukas-reineke/indent-blankline.nvim'

    -- Git
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

    -- validated untill here
    -- Utility
    use 'numToStr/Comment.nvim'
    use 'kylechui/nvim-surround'
    use 'tpope/vim-repeat'
    use 'ellisonleao/glow.nvim'
    use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

    -- DB
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'
    use 'kristijanhusak/vim-dadbod-completion'
end)
