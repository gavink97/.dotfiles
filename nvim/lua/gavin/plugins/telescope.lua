require("telescope").load_extension("remote-sshfs")
local builtin = require("telescope.builtin")
local api = require("remote-sshfs.api")
local connections = require("remote-sshfs.connections")

vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>vm", builtin.man_pages, {})

vim.keymap.set("n", "<leader>ps", function()
	local pref = {
		find_command = {
			"fd",
			"--type",
			"file",
			"--exclude",
			"*_templ.go",
		},
	}

	if connections.is_connected() then
		api.live_grep()
	else
		builtin.live_grep(pref)
	end
end, {})

vim.keymap.set("n", "<leader>pf", function()
	local pref = {
		find_command = {
			"fd",
			"--type",
			"file",
			"--exclude",
			"*_templ.go",
		},
	}

	if connections.is_connected() then
		api.find_files()
	else
		builtin.find_files(pref)
	end
end, {})

vim.keymap.set("n", "<leader>ph", function()
	local pref = {
		find_command = {
			"fd",
			"--type",
			"file",
			"--hidden",
			"--exclude",
			"node_modules",
			"--exclude",
			"site-packages",
			"--exclude",
			".git",
			"--exclude",
			"*_templ.go",
			"--exclude",
			".DS_Store",
		},
		no_ignore = true,
		no_ignore_parent = true,
	}

	if connections.is_connected() then
		api.find_files()
	else
		builtin.find_files(pref)
	end
end, {})

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
})
