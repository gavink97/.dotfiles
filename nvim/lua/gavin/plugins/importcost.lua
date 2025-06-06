require("import-cost").setup({
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	format = {
		byte_format = "%.1fb",
		kb_format = "%.1fk",
		virtual_text = "%s (gzipped: %s)",
	},
	highlight = "Comment",
})
