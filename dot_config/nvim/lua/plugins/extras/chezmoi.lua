return {
	"xvzc/chezmoi.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("chezmoi").setup({
			-- default values
			edit = {
				watch = false,
				force = false,
			},
			notification = {
				on_open = true,
				on_apply = true,
				on_watch = true,
			},
		})
	end,
}
