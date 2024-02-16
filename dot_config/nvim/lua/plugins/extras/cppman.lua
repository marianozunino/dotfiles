local M = {
	"madskjeldgaard/cppman.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	ft = { "c", "cpp" },
}

M.config = function()
	local cppman = require("cppman")
	cppman.setup()

	-- Make a keymap to open the word under cursor in CPPman
	vim.keymap.set("n", "<leader>cm", function()
		cppman.open_cppman_for(vim.fn.expand("<cword>"))
	end, { desc = "[cppman] Open the word under cursor in CPPman" })

	-- Open search box
	vim.keymap.set("n", "<leader>cc", function()
		cppman.input()
	end, { desc = "[cppman] Open search box" })
end

return M
