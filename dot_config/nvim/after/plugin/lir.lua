local actions = require("lir.actions")
local mark_actions = require("lir.mark.actions")
local clipboard_actions = require("lir.clipboard.actions")

require("lir").setup({
	show_hidden_files = false,
	ignore = {}, -- { ".DS_Store", "node_modules" } etc.
	devicons = {
		enable = true,
		highlight_dirname = true,
	},
	mappings = {
		["l"] = actions.edit,
		["<cr>"] = actions.edit,
		["<C-s>"] = actions.split,
		["<C-v>"] = actions.vsplit,
		["<C-t>"] = actions.tabedit,

		["h"] = actions.up,

		["q"] = actions.quit,
		["<esc>"] = actions.quit,

		["M"] = function()
			mark_actions.toggle_mark()
		end,

		["H"] = actions.toggle_show_hidden,
		["D"] = actions.delete,
		["R"] = actions.rename,
		["d"] = actions.mkdir,
		["f"] = actions.newfile,
		["Y"] = clipboard_actions.copy,
		["X"] = clipboard_actions.cut,
		["P"] = clipboard_actions.paste,
	},
	float = {
		winblend = 0,
		curdir_window = {
			enable = false,
		},
	},
	hide_cursor = true,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "lir" },
	callback = function()
		-- use visual mode
		vim.api.nvim_buf_set_keymap(
			0,
			"x",
			"J",
			':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
			{ noremap = true, silent = true }
		)

		-- echo cwd
		vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
	end,
})
