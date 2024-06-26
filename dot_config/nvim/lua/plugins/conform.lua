local M = {
	"stevearc/conform.nvim",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
}

M.config = function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			graphql = { { "prettierd", "prettier" } },
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			sh = { "shfmt" },
			bash = { "shfmt" },
			tex = { "latexindent" },
			-- go = { "gofmt" },
			go = { { "gofumpt", "goimports-reviser", "golines" } },
			cs = { "csharpier" },
		},
		formatters = {
			csharpier = {
				command = "dotnet-csharpier",
				args = { "--write-stdout" },
			},
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
			async = false,
		},
		notify_on_error = false,
	})

	vim.keymap.set("n", "<leader>ff", conform.format, { desc = "Format file or range (in visual mode)" })
end

return M
