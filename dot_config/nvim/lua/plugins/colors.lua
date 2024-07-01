local M = {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("rose-pine").setup({
				-- extend_background_behind_borders = false,

				disable_background = true,
				styles = {
					-- transparency = true,
					italic = true,
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
			-- vim.api.nvim_set_hl(1, "Normal", { bg = "none" })
			-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000,
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		config = function()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
				},
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}

M.config = function() end

return M
