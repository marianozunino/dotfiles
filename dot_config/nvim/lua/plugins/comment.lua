local M = {
	"numToStr/Comment.nvim", --  Commenting plugin
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "VeryLazy",
	},
}

M.config = function()
	vim.g.skip_ts_context_commentstring_module = true
	require("ts_context_commentstring").setup({
		enable_autocmd = false,
	})

	require("Comment").setup({
		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		opleader = {
			line = "gc",
			block = "gC",
		},
		mappings = {
			basic = true,
		},
	})
end

return M
