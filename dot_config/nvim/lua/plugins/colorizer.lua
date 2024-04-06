local M = {
	"NvChad/nvim-colorizer.lua",
}

M.config = function()
	require("colorizer").setup({
		filetypes = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javascriptreact",
			"css",
			"html",
			"astro",
			"lua",
			"go",
			"golang",
			"bash",
			"sh",
		},
		user_default_options = {
			names = false,
			rgb_fn = true,
			hsl_fn = true,
			tailwind = "both",
		},
		buftypes = {},
	})
end

return M
