require("lazy").setup({
    ({
        'neanias/everforest-nvim',
        version = false,
        lazy = false,
        priority = 1000,
    }),

    'nvim-tree/nvim-web-devicons',
    --'gavink97/nvim-cursorline',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'ThePrimeagen/vim-be-good',
    'm4xshen/autoclose.nvim',
    'christoomey/vim-tmux-navigator',
    'lewis6991/gitsigns.nvim',
    'mhartington/formatter.nvim',

    {
        'Exafunction/codeium.vim',
        event = 'BufEnter'
    },

    {
        "laytan/cloak.nvim",
        dependencies= {'nvim-telescope/telescope.nvim'},
    },

    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
    },

    {
        'nvim-telescope/telescope.nvim',
        branch = 'master',
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
        'tigion/nvim-asciidoc-preview',
        cmd = { 'AsciiDocPreview' },
        ft = { 'asciidoc' },
        build = 'cd server && npm install',
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/nvim-cmp'},
            {'saadparwaiz1/cmp_luasnip'},
            {"j-hui/fidget.nvim"},
        }
    },

    {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" }
    },

    {
        "danymat/neogen",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "L3MON4D3/LuaSnip",
        },
    },

})
