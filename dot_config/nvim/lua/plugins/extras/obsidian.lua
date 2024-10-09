local M = {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit

	lazy = false,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
			---@module 'render-markdown'
			---@type render.md.UserConfig
			opts = {},
		},
	},
}

M.config = function()
	vim.opt.conceallevel = 1
	require("obsidian").setup({
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Vault/",
			},
		},
	})

	local keymap = vim.keymap.set
	keymap("n", "<leader>os", "<cmd>ObsidianSearch<CR>")
	keymap("n", "<leader>on", "<cmd>ObsidianNew<CR>")
	keymap("n", "<leader>or", "<cmd>ObsidianRename<CR>")
end

return M
