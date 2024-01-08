local M = {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
}

M.config = function()
	require("persistence").setup({
		options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
	})

	local keymap = vim.keymap.set

	keymap("n", "ql", function()
		vim.notify("Loading session...")
		require("persistence").load()
	end, { desc = "Restore last session" })
end

return M
