local M = {
	"echasnovski/mini.nvim",
}

M.config = function()
	require("mini.ai").setup({})
	require("mini.surround").setup({})
end

return M
