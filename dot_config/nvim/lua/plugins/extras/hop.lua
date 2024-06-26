local M = {
	"phaazon/hop.nvim",
	branch = "v2", -- optional but strongly recommended
}

M.config = function()
	-- you can configure Hop the way you like here; see :h hop-config
	require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
	vim.keymap.set("n", "<leader>ff", "<cmd>HopWord<cr>", { desc = "Hop Word" })
end

return M
