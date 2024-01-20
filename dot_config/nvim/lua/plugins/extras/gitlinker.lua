local M = {
	"ruifm/gitlinker.nvim",
	requires = "nvim-lua/plenary.nvim",
}

M.config = function()
	require("gitlinker").setup()
end

return M
