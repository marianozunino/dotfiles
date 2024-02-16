local M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
M.config = function()
	local harpoon = require("harpoon")

	harpoon:setup({
		settings = {
			save_on_toggle = true,
			sync_on_ui_close = true,
		},
	})

	vim.keymap.set("n", "<leader>a", function()
		harpoon:list():append()
	end)

	vim.keymap.set("n", "<C-h>", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end)

	for i = 1, 4 do
		vim.keymap.set("n", "<leader>" .. i, function()
			harpoon:list():select(i)
		end)
	end
end

return M
