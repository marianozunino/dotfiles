local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"gbrlsnchs/telescope-lsp-handlers.nvim",
	},
	lazy = false,
	cmd = "Telescope",
}

M.config = function()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local sorters = require("telescope.sorters")
	local utils = require("telescope.utils")
	local action_state = require("telescope.actions.state")
	local actions = require("telescope.actions")
	local builtin = require("telescope.builtin")
	local trouble = require("trouble.providers.telescope")

	local function dev_folders()
		local name = "Development"
		local cmd = {
			vim.o.shell,
			"-c",
			"/bin/fd --base-directory ~/Dev --search-path . -t d -d 2 2>/dev/null",
		}
		pickers
			.new(require("telescope.themes").get_dropdown({}), {
				prompt_title = name,
				finder = finders.new_table({ results = utils.get_os_command_output(cmd) }),
				sorter = sorters.get_fuzzy_file(),
				attach_mappings = function(prompt_bufnr)
					actions.select_default:replace(function()
						actions.close(prompt_bufnr)
						local selection = action_state.get_selected_entry()
						local command =
							string.format("nohup sh -c 'code %s --tmux' disown", "~/Development/" .. selection[1])
						local file = assert(io.popen(command, "r"))
						file:close()
					end)
					return true
				end,
			})
			:find()
	end

	local function file_browser()
		local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
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

	vim.keymap.set("n", "<leader>gr", ":Telescope lsp_references<cr>")
	vim.keymap.set("n", "<leader>tm", dev_folders)
	vim.keymap.set("n", "<leader>/", file_browser)

	vim.keymap.set("n", ";", builtin.buffers)
	vim.keymap.set("n", "<leader>vh", builtin.help_tags)

	vim.keymap.set("n", "<leader>gf", function()
		vim.ui.input({ prompt = "Grep For:" }, function(search)
			builtin.grep_string({ search = search })
		end)
	end)

	vim.keymap.set("n", "<leader>gw", function()
		builtin.grep_string({ search = vim.fn.expand("<cword>") })
	end)

	vim.keymap.set("n", "<leader>gW", function()
		builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
	end)
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
end

return M
