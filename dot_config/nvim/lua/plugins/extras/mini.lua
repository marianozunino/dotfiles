local M = {
	-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
	"echasnovski/mini.nvim",
}

M.config = function()
	require("mini.surround").setup({})
	require("mini.ai").setup({})
end

return M
