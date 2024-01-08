local M = {
	"anuvyklack/pretty-fold.nvim",
}

M.config = function()
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldnestmax = 10
	require("pretty-fold").setup({})
end

return M
