require("gitsigns").setup({
	current_line_blame = true,
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

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
		map("n", "<leader>hS", gs.stage_buffer)
		map("n", "<leader>ha", gs.stage_hunk)
		map("n", "<leader>hu", gs.undo_stage_hunk)
		map("n", "<leader>rf", gs.reset_buffer)
		map("n", "<leader>hp", gs.preview_hunk)
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end)
		map("n", "<leader>tb", gs.toggle_current_line_blame)
		map("n", "<leader>hd", gs.diffthis)
		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end)
		map("n", "<leader>td", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

function git_commit_message()
	-- Get the current branch name
	local branch = vim.fn.systemlist("git symbolic-ref --short HEAD")[1]

	-- Check if the branch name starts with the pattern ocst-<number>-whatever or OCST-<number>-whatever
	local pattern = "^%a%a%a%a%-%d%d%d%d"
	local ocst_number = string.match(branch, pattern)
	local cmd = 'Git commit -m "'

	if ocst_number ~= nil then
		-- Remove the prefix and hyphen from the matched string
		ocst_number = string.gsub(ocst_number, "^%a%a%a%a%-", "")
		-- make ocst_number lowercase
		ocst_number = string.lower(ocst_number)
		-- command
		input = vim.fn.input("Commit message: ")
		cmd = cmd .. "feat(ocst-" .. ocst_number .. "): " .. input .. '"'
	else
		-- command
		-- request user input
		input = vim.fn.input("Commit message: ")
		cmd = cmd .. input .. '"'
	end
	vim.api.nvim_feedkeys(":" .. cmd, "n", true)
end

vim.keymap.set("n", "<leader>cc", git_commit_message, { noremap = true, silent = true })
