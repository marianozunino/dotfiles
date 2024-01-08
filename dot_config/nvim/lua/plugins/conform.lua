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
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			sh = { "shfmt" },
			bash = { "shfmt" },
			tex = { "latexindent" },
			go = { "gofmt" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
		},
	})

	vim.keymap.set({ "n", "v" }, "<leader>ff", function()
		conform.format({
			timeout_ms = 500,
			lsp_fallback = true,
			async = false,
		})
	end, { desc = "Format file or range (in visual mode)" })

	local format_augroup = vim.api.nvim_create_augroup("format", { clear = true })

	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		group = format_augroup,
		callback = function(args)
			conform.format({
				timeout_ms = 500,
				lsp_fallback = true,
				async = false,
				bufnr = args.buf,
			})
		end,
	})
end

return M
