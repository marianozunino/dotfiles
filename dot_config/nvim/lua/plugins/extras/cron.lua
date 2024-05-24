local M = {
	"fabridamicelli/cronex.nvim",
}

M.config = function()
	require("cronex").setup({})
	vim.keymap.set(
		"n",
		"<leader>ce",
		":CronExplainedDisable<cr>",
		{ desc = "[cronex] Turn off the explanations permanently" }
	)

	vim.keymap.set(
		"n",
		"<leader>cE",
		":CronExplainedEnable<cr>",
		{ desc = "[cronex] Turn on the explanations permanently" }
	)
end

return M
