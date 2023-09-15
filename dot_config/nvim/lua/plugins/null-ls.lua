return {
	"davidmh/cspell.nvim",
	dependencies = { "jose-elias-alvarez/null-ls.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local cspell = require("cspell")

		local sources = {
			null_ls.builtins.formatting.prettier.with({
				filetypes = {
					"svelte",
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
					"qtpl",
				},
			}),
			null_ls.builtins.formatting.rustfmt,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.rubocop,
			null_ls.builtins.formatting.beautysh,
			null_ls.builtins.code_actions.refactoring,
			null_ls.builtins.formatting.gofmt,
			null_ls.builtins.formatting.latexindent,
			null_ls.builtins.formatting.clang_format,
			null_ls.builtins.code_actions.eslint_d.with({
				condition = function(utils)
					return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml", ".eslintrc.yaml" })
				end,
			}),
			null_ls.builtins.diagnostics.eslint_d.with({
				condition = function(utils)
					return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc.yml", ".eslintrc.yaml" })
				end,
			}),
			cspell.diagnostics.with({
				condition = function(utils)
					return utils.root_has_file({ "cspell.json" })
					-- if not lua file, return true
					-- return vim.bo.filetype ~= "lua"
				end,
				-- config = {},
			}),
			cspell.code_actions.with({
				condition = function(utils)
					return utils.root_has_file({ "cspell.json" })
				end,
				-- config = {},
			}),
		}

		null_ls.setup({
			sources = sources,
		})
	end,
}
-- return {
-- 	{
-- 		"stevearc/conform.nvim",
-- 		opts = {
-- 			notify_on_error = true,
-- 			formatters_by_ft = {
-- 				lua = { "stylua" },
-- 				go = { { "gofmt", "goimports" } },
-- 				javascript = { { "eslint_d", "prettier", "prettierd" } },
-- 				typescript = { { "eslint_d", "prettier", "prettierd" } },
-- 				typescriptreact = { { "eslint_d", "prettier", "prettierd" } },
-- 				["*"] = { "trim_whitespace" },
-- 			},
-- 			format_on_save = {
-- 				-- These options will be passed to conform.format()
-- 				timeout_ms = 500,
-- 				lsp_fallback = true,
-- 			},
-- 		},
-- 	},
-- 	{
-- 		"mfussenegger/nvim-lint",
-- 		config = function()
-- 			require("lint").linters_by_ft = {
-- 				javascript = { "eslint_d" },
-- 				typescript = { "eslint_d" },
-- 				typescriptreact = { "eslint_d" },
-- 			}
-- 			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 				callback = function()
-- 					require("lint").try_lint()
-- 				end,
-- 			})
-- 		end,
-- 	},
-- }
