vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorcolumn = false
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.undofile = true
vim.o.incsearch = true
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")

vim.pack.add({
	{ src = "https://github.com/sainnhe/everforest" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("*") },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

vim.o.colorcolumn = "80"
vim.o.guicursor = ""
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.everforest_background = "soft"
vim.g.everforest_better_performance = 1
vim.g.everforest_transparent_background = 1
vim.g.everforest_enable_italic = 0
vim.g.everforest_diagnostic_virtual_text = "grey"
vim.cmd("colorscheme everforest")

local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-t>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-n>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-s>", function()
	harpoon:list():select(4)
end)
vim.keymap.set("n", "<C-S-P>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
	harpoon:list():next()
end)

local telescope = require("telescope")
local ignore = { "node_modules", ".git", ".venv", "*_templ.go", "site-packages", ".DS_Store" }
telescope.setup({
	pickers = {
		live_grep = {
			file_ignore_patterns = ignore,
			additional_args = function(_)
				return { "--hidden" }
			end,
		},
		find_files = {
			file_ignore_patterns = ignore,
			hidden = true,
		},
	},
})

vim.keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>ps", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>ph", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>pb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>pm", "<cmd>Telescope man_pages<cr>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.g.undotree_WindowLayout = 3

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

require("blink.cmp").setup({
	keymap = {
		preset = "default",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = {
			auto_show = true,
		},
		menu = {
			draw = {
				-- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
			},
		},
	},
	signature = { enabled = true },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})

local lua_settings = {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.lsp.config("lua_ls", lua_settings)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.lsp.enable({ "lua_ls", "gopls", "zls" })

local function print_diagnostics()
	local function by_line_num(a, b)
		return a.lnum < b.lnum
	end

	local diagnostics = vim.diagnostic.get(0)
	if not diagnostics or #diagnostics == 0 then
		return
	end

	table.sort(diagnostics, by_line_num)
	local messages = { "" }
	local sev_text = {
		[vim.diagnostic.severity.ERROR] = "Error",
		[vim.diagnostic.severity.WARN] = "Warning",
	}
	for _, d in ipairs(diagnostics) do
		local sev = sev_text[d.severity] or "Info"
		table.insert(messages, sev .. ": " .. d.message .. " [" .. d.lnum .. ":" .. d.col .. "]")
	end
	vim.notify(table.concat(messages, "\n"), vim.log.levels.ERROR)
end

vim.keymap.set("n", "<leader>w", function()
	vim.cmd("write")
	print_diagnostics()
end)

require("conform").setup({
	formatters_by_ft = {
		sh = { "beautysh" },
		css = { "cssbeautifier" },
		go = { "gofmt", "goimports" },
		html = { "html_beautify" },
		javascript = { "biome" },
		javascriptreact = { "biome" },
		lua = { "stylua" },
		nix = { "alejandra" },

		python = { "yapf" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		swift = { "swift" },

		templ = { "templ" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		yaml = { "yamlfmt" },
		zig = { "zigfmt" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
