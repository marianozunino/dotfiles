local M = {
	"https://gitlab.com/itaranto/plantuml.nvim",
	version = "*", -- lazy = true, ft = "plantuml",
	-- "javiorfo/nvim-soil",

	-- dependencies = {
	-- 	"javiorfo/nvim-nyctophilia",
	-- },
}

M.config = function()
	require("plantuml").setup({
		renderer = {
			type = "image",
			options = {
				prog = "feh",
				dark_mode = false,
			},
		},
		render_on_write = true,
	})
end

return M
