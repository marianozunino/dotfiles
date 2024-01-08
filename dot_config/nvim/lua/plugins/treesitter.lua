local M = {
	"nvim-treesitter/nvim-treesitter",
}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"javascript",
			"typescript",
			"c",
			"lua",
			"rust",
			"bash",
			"graphql",
			"tsx",
			"jsdoc",
		},
		highlight = { enable = true },
		indent = { enable = true },
		sync_install = false,
		auto_install = true,
		modules = {},
	})
end

return M
