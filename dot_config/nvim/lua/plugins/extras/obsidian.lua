vim.opt.conceallevel = 1
local M = {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
}

M.config = function()
	require("obsidian").setup({
		workspaces = {
			{
				name = "personal",
				path = "~/Sync/Obsidian/Vault",
			},
		},
	})

	local keymap = vim.keymap.set
	keymap("n", "<leader>os", "<cmd>ObsidianSearch<CR>")
	keymap("n", "<leader>on", "<cmd>ObsidianNew<CR>")
	keymap("n", "<leader>or", "<cmd>ObsidianRename<CR>")
end

return M