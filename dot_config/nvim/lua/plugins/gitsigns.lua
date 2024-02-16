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
			add = {
				hl = "GitSignsAdd",
				text = icons.ui.BoldLineMiddle,
				numhl = "GitSignsAddNr",
				linehl = "GitSignsAddLn",
			},
			change = {
				hl = "GitSignsChange",
				text = icons.ui.BoldLineDashedMiddle,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
			delete = {
				hl = "GitSignsDelete",
				text = icons.ui.TriangleShortArrowRight,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			topdelete = {
				hl = "GitSignsDelete",
				text = icons.ui.TriangleShortArrowRight,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = icons.ui.BoldLineMiddle,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			-- Actions
			map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
			map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
			-- map("n", "<leader>hS", gs.stage_buffer)
			-- map("n", "<leader>ha", gs.stage_hunk)
			-- map("n", "<leader>hu", gs.undo_stage_hunk)
			-- map("n", "<leader>rf", gs.reset_buffer)
			-- map("n", "<leader>hp", gs.preview_hunk)
			-- map("n", "<leader>hb", function()
			-- 	gs.blame_line({ full = true })
			-- end)
			-- map("n", "<leader>tb", gs.toggle_current_line_blame)
			-- map("n", "<leader>hd", gs.diffthis)
			-- map("n", "<leader>hD", function()
			-- 	gs.diffthis("~")
			-- end)
			-- map("n", "<leader>td", gs.toggle_deleted)

			-- Text object
			-- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
		end,
	})
end

return M
