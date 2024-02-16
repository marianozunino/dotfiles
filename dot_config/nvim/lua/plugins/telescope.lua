local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"gbrlsnchs/telescope-lsp-handlers.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for install instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	lazy = false,
	cmd = "Telescope",
}

M.config = function()
	local utils = require("telescope.utils")
	local actions = require("telescope.actions")
	local builtin = require("telescope.builtin")
	local trouble = require("trouble.providers.telescope")

	local function file_browser()
		-- check if the current directory has a .git folder
		local _, ret, _ = utils.get_os_command_output({ "stat", ".git" })
		if ret == 0 then
			builtin.git_files({
				show_untracked = true,
				git_command = {
					"git",
					"ls-files",
					"--exclude-standard",
					"--cached",
					"-x",
					"!*.tfvars",
					"-x",
					"!.env",
				},
			})
		else
			builtin.find_files()
		end
	end

	local keymap = vim.keymap.set

	keymap("n", "<leader>gr", ":Telescope lsp_references<cr>", { desc = "LSP References" })
	keymap("n", "<leader>/", file_browser, { desc = "File Browser" })

	keymap("n", ";", builtin.buffers, { desc = "Buffers" })

	keymap("n", "<leader>gf", function()
		vim.ui.input({ prompt = "Grep For:" }, function(search)
			builtin.grep_string({ search = search })
		end)
	end, { desc = "Grep for string" })

	keymap("n", "<leader>gw", function()
		builtin.grep_string({ search = vim.fn.expand("<cword>") })
	end, { desc = "Grep for word under cursor" })

	keymap("n", "<leader>gW", function()
		builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
	end, { desc = "Grep for Word under cursor" })

	keymap("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	keymap("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })

	-- Slightly advanced example of overriding default behavior and theme
	keymap("n", "<leader>b", function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[sb] Fuzzily search in current buffer" })

	local icons = require("plugins.icons")

	require("telescope").setup({
		defaults = {
			prompt_prefix = icons.ui.Telescope,
			selection_caret = icons.ui.Forward,
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
			color_devicons = true,
			path_display = { truncate = 3 },
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
			},
			mappings = {
				i = {
					-- ["<esc>"] = actions.close,
					["<c-t>"] = trouble.open_with_trouble,
					["<c-e>"] = actions.to_fuzzy_refine,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
				},
				n = {
					["<c-t>"] = trouble.open_with_trouble,
					["<esc>"] = actions.close,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["q"] = actions.close,
				},
			},
			layout_strategy = "horizontal",
			file_ignore_patterns = { "^undodir/" },
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
		pickers = {
			live_grep = {
				theme = "dropdown",
			},
			git_files = {
				theme = "dropdown",
				previewer = false,
			},
			grep_string = {
				theme = "dropdown",
			},
			find_files = {
				theme = "dropdown",
				previewer = false,
			},
			buffers = {
				theme = "dropdown",
				previewer = false,
				sort_mru = true,
				ignore_current_buffer = true,
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["dd"] = actions.delete_buffer,
					},
				},
			},

			colorscheme = {
				enable_preview = true,
			},

			lsp_references = {
				theme = "dropdown",
			},

			lsp_definitions = {
				theme = "dropdown",
			},

			lsp_declarations = {
				theme = "dropdown",
			},

			lsp_implementations = {
				theme = "dropdown",
			},
		},
	})

	require("telescope").load_extension("lsp_handlers")
	require("telescope.builtin").quickfix()

	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")
end

return M
