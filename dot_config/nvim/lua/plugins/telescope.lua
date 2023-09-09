return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.0",
	-- or                            , branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"gbrlsnchs/telescope-lsp-handlers.nvim",
	},

	cmd = "Telescope",

	config = function()
		local actions = require("telescope.actions")
		local trouble = require("trouble.providers.telescope")

		require("telescope").setup({
			defaults = {
				path_display = { truncate = 3 },
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<c-t>"] = trouble.open_with_trouble,
						["<c-e>"] = actions.to_fuzzy_refine,
					},
					n = { ["<c-t>"] = trouble.open_with_trouble },
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
	end,
}
