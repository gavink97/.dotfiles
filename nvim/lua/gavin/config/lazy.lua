require("lazy").setup({
    ({
        'neanias/everforest-nvim',
        version = false,
        lazy = false,
        priority = 1000,
    }),

    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/playground',
    'gavink97/nvim-cursorline',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    "laytan/cloak.nvim",
    'm4xshen/autoclose.nvim',
    'christoomey/vim-tmux-navigator',
    'lewis6991/gitsigns.nvim',

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { {"nvim-lua/plenary.nvim"} }
    },

    ({
        'folke/trouble.nvim',
        config = function()
            require("trouble").setup {
                --icons = false,
            }
        end
    }),

    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    },

    {
        'mg979/vim-visual-multi',
        branch = 'master'
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },

    ({
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
    }),

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},
            {'L3MON4D3/LuaSnip'},     -- Required
            {'rafamadriz/friendly-snippets'}
        }
    }
})
