local M = {
	"williamboman/mason-lspconfig.nvim",
	priority = 100,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"yioneko/nvim-vtsls",
			"neovim/nvim-lspconfig",
			"ray-x/go.nvim",
			"folke/neodev.nvim",
		},
	},
}

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap(bufnr, "n", "<leader>cw", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	keymap(bufnr, "i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "vd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	-- restart lsp
	keymap(bufnr, "n", "<leader>lr", ":LspRestart<CR>", opts)
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)

	if client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(bufnr, true)
	end
end

function M.common_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return capabilities
end

M.toggle_inlay_hints = function()
	local bufnr = vim.api.nvim_get_current_buf()
	vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
end

function M.config()
	-- This is now being set by noice:
	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	require("lspconfig.ui.windows").default_options.border = "rounded"

	local lspconfig = require("lspconfig")

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local opts = {
					on_attach = M.on_attach,
					capabilities = M.common_capabilities(),
				}

				local require_ok, settings = pcall(require, "plugins.lspsettings." .. server_name)
				if require_ok then
					opts = vim.tbl_deep_extend("force", settings, opts)
				end

				if server_name == "lua_ls" then
					require("neodev").setup({})
				end

				lspconfig[server_name].setup(opts)
			end,
		},
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			-- Enable completion triggered by <c-x><c-o>
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			lsp_keymaps(ev.buf)
		end,
	})
end

return M
