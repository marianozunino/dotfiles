return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.3",
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
			extensions = {
				git_worktree = {
					prompt_title = "Git Worktree",
					theme = "dropdown",
					path_display = { "shorten" },
					layout_config = {
						width = 70,
						height = 20,
					},

					-- determine what worktree items to show, in order and their corresponding width
					-- possible items to show are `branch`, `path`, `sha`
					items = {
						{ "branch", 50 },
						{ "sha", 20 },
					},
					-- set custom bindings for worktree related actions
					mappings = {
						["i"] = {
							["<C-d>"] = require("telescope").extensions.git_worktree.actions.delete_worktree,
							["<C-f>"] = require("telescope").extensions.git_worktree.actions.toggle_forced_deletion,
						},
						["n"] = {
							["<C-d>"] = require("telescope").extensions.git_worktree.actions.delete_worktree,
							["<C-f>"] = require("telescope").extensions.git_worktree.actions.toggle_forced_deletion,
						},
					},
				},
			},
		})

		require("telescope").load_extension("lsp_handlers")
		require("telescope.builtin").quickfix()
		require("git-worktree").setup()
		require("telescope").load_extension("git_worktree")
	end,
}
