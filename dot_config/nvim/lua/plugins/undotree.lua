return {
	"mbbill/undotree",
	cmd = {
		"UndotreeToggle",
	},
	config = function()
		vim.opt.undodir = vim.fn.expand("~/.config/undodir")
	end,
}
