-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    use({
        'folke/trouble.nvim',
        config = function()
            require("trouble").setup {
                --icons = false,
            }
        end
    })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use({
        'sainnhe/everforest',
        as = 'everforest',
        config = function()
            vim.cmd('colorscheme everforest')
        end
        })

    use {
        'mg979/vim-visual-multi',
        branch = 'master'
    }

    use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use 'nvim-tree/nvim-web-devicons'
    use('nvim-treesitter/playground')
    use 'yamatsum/nvim-cursorline'
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
    use("laytan/cloak.nvim")
    use 'm4xshen/autoclose.nvim'
    use('christoomey/vim-tmux-navigator')
    use 'lewis6991/gitsigns.nvim'

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
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

end)
