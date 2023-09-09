return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			keymaps = {
				["<C-p>"] = false,
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
			},
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "OilEnter",
			callback = vim.schedule_wrap(function(args)
				local oil = require("oil")
				if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
					oil.select({ preview = true })
				end
			end),
		})
	end,
}
