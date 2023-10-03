return {
	"nvim-lua/popup.nvim",

	"theprimeagen/harpoon",
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup({
				-- prompt for return type
				prompt_func_return_type = {
					go = true,
				},
				-- prompt for function parameters
				prompt_func_param_type = {
					go = true,
				},
			})
		end,
	},

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
	{
		"olexsmir/gopher.nvim",
		requires = { -- dependencies
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({
				keywords = {
					FUCK = { icon = "󰇷 ", color = "error" },
					SHITTY = { icon = "󰇷 ", color = "error" },
				},
			})
		end,
	},
	{
		"barrett-ruth/live-server.nvim",
		build = "npm i -g live-server",
		config = true,
	},

	"MunifTanjim/nui.nvim",
}
