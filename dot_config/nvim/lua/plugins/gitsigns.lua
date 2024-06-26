local M = {
	"lewis6991/gitsigns.nvim",
}

M.config = function()
	local icons = require("plugins.icons")
	require("gitsigns").setup({
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		current_line_blame = true,
		update_debounce = 200,
		max_file_length = 40000,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		preview_config = {
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		signs = {
			add = { text = icons.ui.BoldLineMiddle },
			change = { text = icons.ui.BoldLineDashedMiddle },
			delete = { text = icons.ui.TriangleShortArrowRight },
			topdelete = { text = icons.ui.TriangleShortArrowRight },
			changedelete = { text = icons.ui.BoldLineMiddle },
		},
		on_attach = function()
			local gs = require("gitsigns")
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next git hunk" })

			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Previous git hunk" })
		end,
	})
end

return M
