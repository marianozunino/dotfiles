local M = {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

M.config = function()
	require("todo-comments").setup({
		keywords = {
			FUCK = { icon = "󰇷 ", color = "error" },
			SHITTY = { icon = "󰇷 ", color = "error" },
		},
	})
end

return M
