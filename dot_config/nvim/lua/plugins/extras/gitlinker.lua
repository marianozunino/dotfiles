local M = {
	"ruifm/gitlinker.nvim",
	requires = "nvim-lua/plenary.nvim",
}

M.config = function()
	require("gitlinker").setup({
		message = false,
		console_log = false,
	})

	vim.keymap.set("n", "<leader>gy", "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>")
	vim.keymap.set("n", "<leader>gY", "<cmd>lua require('gitlinker').get_buf_range_url('n', 'blame')<cr>")

	local wk = require("which-key")
	wk.register({
		["<leader>gy"] = { "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>", "Get Git URL" },
		["<leader>gY"] = { "<cmd>lua require('gitlinker').get_buf_range_url('n', 'blame')<cr>", "Get Git Blame URL" },
	})
end

return M
