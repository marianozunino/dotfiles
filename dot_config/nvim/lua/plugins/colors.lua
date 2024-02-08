local M = {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
}

M.config = function()
	require("rose-pine").setup({
		extend_background_behind_borders = false,

		styles = {
			transparency = true,
		},

		before_highlight = function(_, highlight, palette)
			-- Disable all undercurls
			if highlight.undercurl then
				highlight.undercurl = false
			end

			-- Change palette colour
			if highlight.fg == palette.pine then
				highlight.fg = palette.foam
			end
		end,
	})
	vim.cmd.colorscheme("rose-pine")
	vim.api.nvim_set_hl(1, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return M
