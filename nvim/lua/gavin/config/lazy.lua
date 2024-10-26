require("lazy").setup({
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
	},

	"nvim-tree/nvim-web-devicons",
	--'gavink97/nvim-cursorline',
	"mbbill/undotree",
	"tpope/vim-fugitive",
	"ThePrimeagen/vim-be-good",
	"m4xshen/autoclose.nvim",
	"christoomey/vim-tmux-navigator",
	"lewis6991/gitsigns.nvim",
	"mfussenegger/nvim-dap",
	"mhartington/formatter.nvim",

	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},

	{
		"laytan/cloak.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},

	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"tigion/nvim-asciidoc-preview",
		cmd = { "AsciiDocPreview" },
		ft = { "asciidoc" },
		build = "cd server && npm install",
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "j-hui/fidget.nvim" },
		},
		-- add lsps that mason does not support here
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.sourcekit.setup({
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
				filetypes = { "swift" },
			})
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	{
		"danymat/neogen",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
		},
	},
})
