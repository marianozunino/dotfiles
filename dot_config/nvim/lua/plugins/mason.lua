local M = {
	"williamboman/mason.nvim",

	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

M.config = function()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})

	local registry = require("mason-registry")

	for _, pkg_name in ipairs({
		-- Servers
		"rust_analyzer",
		-- "tsserver",
		"vtsls",
		"lua_ls",
		-- "typescript-language-server",
		"graphql-language-service-cli",
		"gopls",
		"templ",
		"json-lsp",
		"htmx-lsp",
		-- "svelte-language-server",

		-- Fixers/Linters
		"stylua",
		"eslint_d",
		"prettierd",
		"latexindent",
		"shfmt",
	}) do
		local ok, pkg = pcall(registry.get_package, pkg_name)
		if ok then
			if not pkg:is_installed() then
				print("Installing ", pkg)
				pkg:install()
			end
		end
	end
end

return M
