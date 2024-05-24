local M = {
	"tpope/vim-dadbod",
	dependencies = {
		"kristijanhusak/vim-dadbod-ui",
		"kristijanhusak/vim-dadbod-completion",
	},
}

M.config = function()
	vim.g.db_ui_use_nerd_fonts = 1
end

return M
