require("mason").setup()

local registry = require("mason-registry")

for _, pkg_name in ipairs({
	-- Servers
	"rust_analyzer",
	"tsserver",
	"lua-language-server",
	"typescript-language-server",
	"graphql-language-service-cli",
	"gopls",
	"solargraph",

	-- Fixers/Linters
	"stylua",
	"eslint_d",
	"prettierd",
	"rubocop",

	-- dap
	"node-debug2-adapter",
	"go-debug-adapter",
}) do
	local ok, pkg = pcall(registry.get_package, pkg_name)
	if ok then
		if not pkg:is_installed() then
			print("Installing ", pkg)
			pkg:install()
		end
	end
end

