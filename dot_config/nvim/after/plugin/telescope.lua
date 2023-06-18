local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		path_display = { truncate = 3 },
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
		layout_strategy = "horizontal",
		file_ignore_patterns = { "^undodir/" },
	},
	pickers = {
		buffers = {
			sort_lastused = true,
		},
	},
	extensions = {},
})

require("telescope").load_extension("lsp_handlers")
require("telescope.builtin").quickfix()
