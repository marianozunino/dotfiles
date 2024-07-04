local M = {
	"nvim-treesitter/nvim-treesitter",
}

M.config = function()
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
			"c_sharp",
		},
		highlight = {
			enable = true,
			disable = function()
				-- check if 'filetype' option includes 'chezmoitmpl'
				if string.find(vim.bo.filetype, "chezmoitmpl") then
					return true
				end
			end,
		},
		indent = { enable = true },
		sync_install = false,
		auto_install = true,
		modules = {},
	})
end

return M
