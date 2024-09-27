-- local M = {
-- 	"phaazon/hop.nvim",
-- 	branch = "v2", -- optional but strongly recommended
-- }
local M = {
	"folke/flash.nvim",
	-- event = "VeryLazy",
	---@type Flash.Config
	opts = {
		jump = {
			autojump = true,
		},
		modes = {
			char = {
				jump_labels = true,
				multi_line = false,
			},
		},
	},
}

M.config = function()
	vim.keymap.set("n", "<leader>ff", function()
		require("flash").jump()
	end, { desc = "Flash" })
end

return M
