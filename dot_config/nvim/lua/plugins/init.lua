return {
	"nvim-lua/popup.nvim",

	-- "tamago324/lir.nvim",

	"theprimeagen/harpoon",
	"theprimeagen/refactoring.nvim",

	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",

	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},

	"github/copilot.vim",

	"stevearc/dressing.nvim",
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true,
			})
		end,
	},

	-- debugger
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
	"leoluz/nvim-dap-go",
	"David-Kunz/jester",
}
