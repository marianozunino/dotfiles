local M = {
	"goolord/alpha-nvim",
	event = "VimEnter",
}

function M.config()
	local dashboard = require("alpha.themes.dashboard")
	local nvim_version = vim.version()
	local version = nvim_version.major .. "." .. nvim_version.minor .. "." .. nvim_version.patch

	dashboard.section.header.val = {
		[[ ★　✯   🛸                |                  🪐   .°• ]],
		[[         ° ★　•          / \         🛰               ]],
		[[                        | O |                         ]],
		[[                        | O |                         ]],
		[[                       /| | |\                        ]],
		[[                      /_(.|.)_\                       ]],
		"",
		[[                       Neovim                  ]] .. version,
		"",
	}

	local icons = {
		ui = {
			Files = "",
			NewFile = "",
			History = "",
			Text = "",
			Gear = "",
			SignOut = "",
		},
	}

	dashboard.section.buttons.val = {
		dashboard.button("f", icons.ui.Files .. " Find file", ":Telescope find_files hidden=true no_ignore=true<CR>"),
		dashboard.button("e", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
		-- restore session with persistence.nvim
		-- dashboard.button("l", icons.ui.History .. " Restore last session", ":lua require('persistence').load()<CR>"),
		dashboard.button("t", icons.ui.Text .. " Find text", ":Telescope live_grep <CR>"),
		dashboard.button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
		dashboard.button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
	}

	require("alpha").setup(dashboard.opts)
end

return M
