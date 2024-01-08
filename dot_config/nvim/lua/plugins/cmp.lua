local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-emoji",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local select_opts = { behavior = cmp.SelectBehavior.Select }

		vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

		-- Codeium
		-- vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#00FF00" })

		local icons = require("plugins.icons")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "codeium" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "calc" },
				{ name = "emoji" },
			},
			fields = { "kind", "abbr", "menu" },
			formatting = {
				format = function(entry, vim_item)
					vim_item.kind = icons.kind[vim_item.kind]
					vim_item.menu = ({
						nvim_lsp = "",
						nvim_lua = "",
						luasnip = "",
						buffer = "",
						path = "",
						emoji = "",
					})[entry.source.name]

					if entry.source.name == "emoji" then
						vim_item.kind = icons.misc.Smiley
						vim_item.kind_hl_group = "CmpItemKindEmoji"
					end

					if entry.source.name == "codeium" then
						vim_item.kind = " "
						vim_item.kind_hl_group = "CmpItemKindCodeium"
					end

					return vim_item
				end,
			},
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
				["<C-j>"] = cmp.mapping.select_next_item(select_opts),
				["<Down>"] = cmp.mapping.select_next_item(select_opts),
				["<Up>"] = cmp.mapping.select_prev_item(select_opts),

				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),

				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping.confirm({ select = false }),

				["<C-f>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<C-b>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				--  trigger completion control+space
				["<C-Space>"] = cmp.mapping.complete(),
			},
			window = {
				completion = {
					border = "rounded",
					scrollbar = false,
				},
				documentation = {
					border = "rounded",
				},
			},
			experimental = {
				ghost_text = false,
			},
		})
	end,
}

return M
