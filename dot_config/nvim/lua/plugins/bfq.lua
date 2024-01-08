local M = {
	"kevinhwang91/nvim-bqf",
	event = "VeryLazy",
}

function M.config()
	require("bqf").setup({
		auto_enable = true,
		magic_window = true,
		auto_resize_height = false,
		preview = {
			auto_preview = false,
			show_title = true,
			delay_syntax = 50,
			wrap = false,
		},
		func_map = {
			ptoggleitem = "p",
			ptoggleauto = "a",
			ptogglemode = "P",
		},
	})

	local keymap = vim.keymap.set
	keymap("n", "<leader>fl", vim.diagnostic.setqflist, { silent = true })
	keymap("n", "<leader>qf", vim.diagnostic.setqflist, { silent = true })
end

return M
