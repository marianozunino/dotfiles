local M = {
	"folke/trouble.nvim",
}

M.config = function()
	require("trouble").setup({
		icons = false,
		mode = "workspace_diagnostics",
	})

	vim.keymap.set("n", "<leader>tt", function()
		-- jump to the previous item, skipping the groups
		require("trouble").toggle()
	end, { desc = "Next todo comment" })

	vim.keymap.set("n", "[d", function()
		require("trouble").next({ skip_groups = true, jump = true })
	end)

	vim.keymap.set("n", "]d", function()
		require("trouble").previous({ skip_groups = true, jump = true })
	end)

	local icons = require("plugins.icons")

	vim.diagnostic.config({
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.error },
				{ name = "DiagnosticSignWarn", text = icons.warning },
				{ name = "DiagnosticSignHint", text = icons.hint },
				{ name = "DiagnosticSignInfo", text = icons.information },
			},
		},
		virtual_text = true,
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
	})

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end
end

return M
