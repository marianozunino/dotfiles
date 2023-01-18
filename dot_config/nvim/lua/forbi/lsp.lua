-- Requires NeoVim >= 0.8
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			if client.name == "gopls" then
				return true
			end
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function(client)
			--			if client.name == "tsserver" or client == "sumneko_lua" then
			--				client.resolved_capabilities.document_formatting = false
			--			end
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end

			local nnoremap = require("forbi.keymap").nnoremap
			local inoremap = require("forbi.keymap").inoremap
			local vnoremap = require("forbi.keymap").vnoremap
			nnoremap("gd", vim.lsp.buf.definition)
			nnoremap("gt", vim.lsp.buf.type_definition)
			nnoremap("gi", vim.lsp.buf.implementation)
			nnoremap("K", vim.lsp.buf.hover)

			nnoremap("<leader>r", vim.lsp.buf.rename)
			nnoremap("<leader>ca", vim.lsp.buf.code_action)
			vnoremap("<leader>ca", vim.lsp.buf.code_action)

			nnoremap("[d", vim.diagnostic.goto_next) -- goto next diagnostic
			nnoremap("]d", vim.diagnostic.goto_prev) -- goto prev diagnostic

			nnoremap("<leader>vd", vim.diagnostic.open_float)
			inoremap("<C-h>", vim.lsp.buf.signature_help)
		end,
	}, _config or {})
end

require("lspconfig").tsserver.setup(config())
require("lspconfig").solargraph.setup(config())
require("lspconfig").gopls.setup(config())
require("lspconfig").graphql.setup(config())
require("lspconfig").sumneko_lua.setup(config({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "use", "bufnr" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}))

-- vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]])
