local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local utils = require("telescope.utils")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
--
-- require("telescope").load_extension("file_browser")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
		layout_strategy = "vertical",
	},
	pickers = {
		buffers = {
			sort_lastused = true,
		},
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {},
				["n"] = {},
			},
		},
	},
})

require("telescope").load_extension("lsp_handlers")
-- require("telescope").load_extension("emoji")
require("telescope.builtin").quickfix()

local M = {}

function M.dev_folders()
	local name = "Development"
	local cmd = {
		vim.o.shell,
		"-c",
		"/bin/fd --base-directory ~/Development --search-path . -t d -d 2 2>/dev/null",
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

function M.reload()
	-- Telescope will give us something like ju/colors.lua,
	-- so this function convert the selected entry to
	-- the module name: ju.colors
	local function get_module_name(s)
		local module_name

		module_name = s:gsub("%.lua", "")
		module_name = module_name:gsub("%/", ".")
		module_name = module_name:gsub("%.init", "")

		return module_name
	end

	local prompt_title = "~ neovim modules ~"

	-- sets the path to the lua folder
	local path = "~/.config/nvim/lua"

	local opts = {
		prompt_title = prompt_title,
		cwd = path,

		attach_mappings = function(_, map)
			-- Adds a new map to ctrl+e.
			map("i", "<c-e>", function(_)
				-- these two a very self-explanatory
				local entry = require("telescope.actions.state").get_selected_entry()
				local name = get_module_name(entry.value)

				-- call the helper method to reload the module
				-- and give some feedback
				R(name)
				P(name .. " RELOADED!!!")
			end)

			return true
		end,
	}

	-- call the builtin method to list files
	require("telescope.builtin").find_files(opts)
end

function M.tmux_switcher()
	local name = "Tmux Sessions"
	local cmd = {
		vim.o.shell,
		"-c",
		"tmux ls | cut -d: -f1",
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
					-- local command = string.format("nohup sh -c 'tmux switch-client -t %s' &", selection.value)
					local command =
						string.format("nohup sh -c 'code %s --tmux' disown", "~/Development/" .. selection.value)
					local file = assert(io.popen(command, "r"))
					file:close()
				end)
				return true
			end,
		})
		:find()
end

function M.file_browser()
	local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
	if ret == 0 then
		require("telescope.builtin").git_files({
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
		require("telescope.builtin").find_files()
	end
end

return M
