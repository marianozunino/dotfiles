local M = {
	"danymat/neogen",
}

M.config = function()
	require("neogen").setup({})
	local keymap = vim.keymap.set
	keymap("n", "<leader>ng", ":lua require('neogen').generate()<CR>", { desc = "Generate documentation" })
	keymap("n", "<leader>nt", ":lua require('neogen').generate('type')<CR>", { desc = "Generate type documentation" })
	keymap(
		"n",
		"<leader>nf",
		":lua require('neogen').generate('func')<CR>",
		{ desc = "Generate function documentation" }
	)
	keymap("n", "<leader>nc", ":lua require('neogen').generate('class')<CR>", { desc = "Generate class documentation" })
end

return M
