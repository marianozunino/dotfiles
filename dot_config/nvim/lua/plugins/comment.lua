return {
	"numToStr/Comment.nvim", --  Commenting plugin
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("Comment").setup({
			opleader = {
				line = "gc",
				block = "gb",
			},
			mappings = {
				basic = true,
			},
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
