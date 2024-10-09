local M = {
	"folke/trouble.nvim",
	branch = "main", -- IMPORTANT!
}

M.config = function()
	require("trouble").setup({
		mode = "workspace_diagnostics",
	})

	vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Next todo comment" })

	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "[Diag] Next Issue" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "[Diag] Next Issue" })

	local t = require("trouble")
	vim.keymap.set("n", "<a-k>", function()
		t.prev({ skip_groups = true, jump = true })
	end, { desc = "Previous trouble" })
	vim.keymap.set("n", "<a-j>", function()
		t.next({ skip_groups = true, jump = true })
	end, { desc = "Next trouble" })

	local icons = require("plugins.icons")
	vim.diagnostic.config({
		virtual_text = {
			prefix = "",
			suffix = "",
			format = function(diagnostic)
				return "󰍡 " .. diagnostic.message .. " "
			end,
		},
		underline = false,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
				[vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
				[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
				[vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
			},
		},
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})
end

return M
