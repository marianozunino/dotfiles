local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = LAZY_PLUGIN_SPEC,
	ui = {
		border = "rounded",
	},
	change_detection = {
		notify = false,
		enable = true,
	},
	install = {
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "rose-pine" },
	},
})

local keymap = vim.keymap.set
keymap("n", "<leader>la", ":Lazy<CR>")
