require("flutter-tools").setup({
	debugger = {
		enabled = true,
		register_configurations = function(_)
			require("dap").configurations.dart = {}
			require("dap.ext.vscode").load_launchjs()
		end,
	},
	flutter_path = "~/development/flutter/bin",
	root_patterns = { ".git", "pubspec.yaml" },
	widget_guides = {
		enabled = false,
	},
	closing_tags = {
		highlight = "ErrorMsg",
		prefix = ">",
		priority = 10,
		enabled = true,
	},
	dev_log = {
		enabled = true,
		filter = nil,
		notify_errors = false, -- if there is an error whilst running then notify the user
		open_cmd = "tabedit",
	},
	dev_tools = {
		autostart = false,
		auto_open_browser = false,
	},
	outline = {
		open_cmd = "30vnew",
		auto_open = false,
	},
	lsp = {
		color = {
			enabled = false,
			background = false,
			background_color = nil,
			foreground = false,
			virtual_text = true,
			virtual_text_str = "■",
		},
		settings = {
			showTodos = true,
			completeFunctionCalls = true,
			renameFilesWithClasses = "always",
			enableSnippets = true,
			updateImportsOnRename = true,
		},
	},
})
