vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorcolumn = false
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.wrap = false
vim.o.signcolumn = "number"
vim.o.swapfile = false
vim.o.fen = false
vim.o.undofile = true
vim.o.incsearch = true
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"
vim.o.spell = true

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
	{ src = "https://github.com/3rd/image.nvim" },
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

local telescope = require("telescope")
local ignore = { "node_modules", ".git", ".venv", "*_templ.go", "site-packages", ".DS_Store", "dist" }
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
			follow = true,
			no_ignore = true,
		},
	},
})

vim.keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>ps", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>ph", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>pb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>pm", "<cmd>Telescope man_pages<cr>")

local harpoon = require("harpoon")
harpoon:setup()

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	toggle_telescope(harpoon:list())
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

vim.lsp.enable({ "lua_ls", "gopls", "zls", "ts_ls", "cssls", "tailwindcss", "pylsp", "templ" })

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

local wrap_enabled = false

local function toggle_wrap()
	if wrap_enabled then
		vim.opt.wrap = false
		vim.opt.linebreak = false

		local mappings = { "j", "k", "0", "^", "$" }
		for _, key in ipairs(mappings) do
			vim.api.nvim_del_keymap("n", key)
			vim.api.nvim_del_keymap("v", key)
		end

		wrap_enabled = false
		print("Wrap disabled")
	else
		vim.opt.wrap = true
		vim.opt.linebreak = true

		local mapping_opts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap("n", "j", "gj", mapping_opts)
		vim.api.nvim_set_keymap("n", "k", "gk", mapping_opts)
		vim.api.nvim_set_keymap("n", "0", "g0", mapping_opts)
		vim.api.nvim_set_keymap("n", "^", "g^", mapping_opts)
		vim.api.nvim_set_keymap("n", "$", "g$", mapping_opts)
		vim.api.nvim_set_keymap("v", "j", "gj", mapping_opts)
		vim.api.nvim_set_keymap("v", "k", "gk", mapping_opts)
		vim.api.nvim_set_keymap("v", "0", "g0", mapping_opts)
		vim.api.nvim_set_keymap("v", "^", "g^", mapping_opts)
		vim.api.nvim_set_keymap("v", "$", "g$", mapping_opts)

		wrap_enabled = true
		print("Wrap enabled")
	end
end

vim.keymap.set("n", "<leader>e", toggle_wrap, { noremap = true, silent = true })

require("image").opts = {
	processor = "magick_cli",
}

require("image").setup({
	backend = "kitty",
	processor = "magick_cli",
	integrations = {
		markdown = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = false,
			only_render_image_at_cursor_mode = "popup", -- or "inline"
			floating_windows = false, -- if true, images will be rendered in floating markdown windows
			filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
		},
		neorg = {
			enabled = true,
			filetypes = { "norg" },
		},
		typst = {
			enabled = true,
			filetypes = { "typst" },
		},
		html = {
			enabled = false,
		},
		css = {
			enabled = false,
		},
	},
	max_width = nil,
	max_height = nil,
	max_width_window_percentage = nil,
	max_height_window_percentage = 50,
	scale_factor = 1.0,
	window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
	editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
	tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
})
