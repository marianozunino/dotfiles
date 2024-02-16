local M = {
	"folke/trouble.nvim",
	branch = "dev", -- IMPORTANT!
}

M.config = function()
	require("trouble").setup({
		mode = "workspace_diagnostics",
	})

	vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Next todo comment" })

	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "[Diag] Next Issue" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "[Diag] Next Issue" })

	local icons = require("plugins.icons")
	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
			},
		},
		virtual_text = false,
		update_in_insert = false,
		underline = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end
end

return M
