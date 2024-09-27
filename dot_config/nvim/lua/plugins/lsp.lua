local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"ibhagwan/fzf-lua",
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
			dependencies = {
				"dmmulroy/ts-error-translator.nvim",
			},
			config = function()
				require("ts-error-translator").setup()
			end,
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

local on_attach = function(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end

	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, {
			buffer = bufnr,
			desc = "LSP: " .. desc,
		})
	end
	--
	map("K", vim.lsp.buf.hover, "Hover Documentation")
	map("gi", vim.lsp.buf.implementation, "Goto Implementation")
	map("gd", vim.lsp.buf.definition, "Goto Definition")
	map("gr", vim.lsp.buf.references, "Goto References")
	map("vd", vim.diagnostic.open_float, "Open Diagnostics")

	map("<C-h>", vim.lsp.buf.signature_help, "Signature Help")
	map("<leader>D", vim.lsp.buf.type_definition, "Tye Definition")

	map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
	map("<leader>cw", vim.lsp.buf.rename, "Rename")
	map("<leader>r", vim.lsp.buf.rename, "Rename")

	map("<leader>lr", ":LspRestart<CR>", "Restart LSP")
	map("<leader>li", ":LspInfo<CR>", "LSP Info")
end

M.config = function()
	vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

	local border = {
		{ "🭽", "FloatBorder" },
		{ "▔", "FloatBorder" },
		{ "🭾", "FloatBorder" },
		{ "▕", "FloatBorder" },
		{ "🭿", "FloatBorder" },
		{ "▁", "FloatBorder" },
		{ "🭼", "FloatBorder" },
		{ "▏", "FloatBorder" },
	}

	-- LSP settings (for overriding per client)
	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	}

	require("lspconfig.ui.windows").default_options.border = "rounded"

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local base_opts = {
					on_attach = on_attach,
					capabilities = capabilities,
					handlers = handlers,
				}

				local require_ok, server_opts = pcall(require, "plugins.lspsettings." .. server_name)

				if require_ok then
					base_opts = vim.tbl_deep_extend("force", base_opts, server_opts)
				end

				require("lspconfig")[server_name].setup(base_opts)
			end,
		},
	})

	-- organize imports
	-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = { "*.go" },
		callback = function()
			local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
			params.context = { only = { "source.organizeImports" } }

			local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
			for _, res in pairs(result or {}) do
				for _, r in pairs(res.result or {}) do
					if r.edit then
						vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
					else
						vim.lsp.buf.execute_command(r.command)
					end
				end
			end
		end,
	})
end

return M
