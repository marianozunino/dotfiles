local M = {
	-- "Exafunction/codeium.vim",
	"Exafunction/codeium.nvim",
	event = "BufEnter",
}

function M.config()
	require("codeium").setup({})
	-- vim.g.codeium_disable_bindings = 1
	-- local keymap = vim.keymap.set
	--
	-- keymap("i", "<Tab>", function()
	-- 	return vim.fn["codeium#Accept"]()
	-- end, { expr = true, silent = true })
	-- keymap("i", "<c-;>", function()
	-- 	return vim.fn["codeium#CycleCompletions"](1)
	-- end, { expr = true, silent = true })
	-- keymap("i", "<c-,>", function()
	-- 	return vim.fn["codeium#CycleCompletions"](-1)
	-- end, { expr = true, silent = true })
end

return M
