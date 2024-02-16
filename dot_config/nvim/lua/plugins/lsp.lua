local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",

		"nvim-telescope/telescope.nvim",
		"neovim/nvim-lspconfig",
		"ray-x/guihua.lua",
		{
			"olexsmir/gopher.nvim",
			ft = "go",
			config = function(_, opts)
				require("gopher").setup(opts)
				local keymap = vim.keymap.set
				keymap("n", "<leader>gmt", ":GoMod tidy<cr>", { desc = "[Go] Tidy" })
			end,
			build = function()
				vim.cmd([[silent! GoInstallDeps]])
			end,
		},
		{
			"yioneko/nvim-vtsls",
			ft = { "typescript", "javascript", "jsx", "tsx", "json" },
		},
		{
			"folke/neodev.nvim",
			ft = "lua",
			config = function()
				require("neodev").setup()
			end,
		},
	},
}

function M.config()
	require("lspconfig.ui.windows").default_options.border = "rounded"

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			-- Enable completion triggered by <c-x><c-o>
			vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			local builtin = require("telescope.builtin")

			map("gd", builtin.lsp_definitions, "Goto Definition")
			map("K", vim.lsp.buf.hover, "Hover Documentation")
			map("gi", vim.lsp.buf.implementation, "Goto Implementation")
			map("gr", builtin.lsp_references, "Goto References")
			map("gl", vim.diagnostic.open_float, "Open Diagnostics")
			map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			map("<leader>cw", vim.lsp.buf.rename, "Rename")
			map("<leader>r", vim.lsp.buf.rename, "Rename")
			map("<C-h>", vim.lsp.buf.signature_help, "Signature Help")
			map("vd", vim.diagnostic.open_float, "Open Diagnostics")
			map("<leader>lr", ":LspRestart<CR>", "Restart LSP")
			map("<leader>li", ":LspInfo<CR>", "LSP Info")

			-- When you move your cursor, the highlights will be cleared (the second autocommand).
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end,
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local require_ok, server = pcall(require, "plugins.lspsettings." .. server_name)

				if not require_ok then
					server = {}
				end

				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end

return M
