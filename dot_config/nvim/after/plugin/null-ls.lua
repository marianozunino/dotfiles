local null_ls = require("null-ls")
local cspell = require("cspell")

local sources = {
	null_ls.builtins.formatting.prettier.with({
		filetypes = {
			"javascript",
			"typescript",
			"typescriptreact",
			"javascriptreact",
			"json",
			"yaml",
			"markdown",
			"html",
			"css",
			"scss",
			"less",
			"graphql",
			"vue",
			"svelte",
			"lua",
			"gohtmltmpl",
			"jinja.html",
			"jinja",
		},
	}),
	null_ls.builtins.formatting.rustfmt,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.rubocop,
	null_ls.builtins.formatting.beautysh,
	null_ls.builtins.code_actions.refactoring,
	null_ls.builtins.code_actions.eslint_d,
	null_ls.builtins.diagnostics.eslint_d,
	cspell.diagnostics.with({
		condition = function(utils)
			-- return utils.root_has_file({ "cspell.json" })
			-- if not lua file, return true
			return vim.bo.filetype ~= "lua"
		end,
		config = {},
	}),
	cspell.code_actions.with({
		-- condition = function(utils)
		-- 	return utils.root_has_file({ "cspell.json" })
		-- end,

		config = {},
	}),
}

null_ls.setup({
	sources = sources,
})