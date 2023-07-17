return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"CodeGradox/onehalf-lush",
		priority = 1000,
		lazy = false,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
			})
		end,
	},
}
