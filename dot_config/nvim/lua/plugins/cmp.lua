-- local M = {
-- 	"hrsh7th/nvim-cmp",
-- 	dependencies = {
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"hrsh7th/cmp-nvim-lua",
-- 		"hrsh7th/cmp-cmdline",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-emoji",
-- 	},
-- 	config = function()
-- 		local cmp = require("cmp")
-- 		local luasnip = require("luasnip")
-- 		local select_opts = { behavior = cmp.SelectBehavior.Select }
--
-- 		local kind_icons = {
-- 			Text = "",
-- 			Method = "󰆧",
-- 			Function = "󰊕",
-- 			Constructor = "",
-- 			Field = "󰇽",
-- 			Variable = "󰂡",
-- 			Class = "󰠱",
-- 			Interface = "",
-- 			Module = "",
-- 			Property = "󰜢",
-- 			Unit = "",
-- 			Value = "󰎠",
-- 			Enum = "",
-- 			Keyword = "󰌋",
-- 			Snippet = "",
-- 			Color = "󰏘",
-- 			File = "󰈙",
-- 			Reference = "",
-- 			Folder = "󰉋",
-- 			EnumMember = "",
-- 			Constant = "󰏿",
-- 			Struct = "",
-- 			Event = "",
-- 			Operator = "󰆕",
-- 			TypeParameter = "󰅲",
-- 			Codeium = "",
-- 			Emoji = "󰞅",
-- 		}
--
-- 		vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
-- 		vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#a3be8c" })
--
-- 		cmp.setup({
-- 			snippet = {
-- 				expand = function(args)
-- 					luasnip.lsp_expand(args.body)
-- 				end,
-- 			},
-- 			sources = {
-- 				{ name = "codeium" },
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" },
-- 				{ name = "path" },
-- 				{ name = "buffer" },
-- 				{ name = "calc" },
-- 				{ name = "emoji" },
-- 			},
-- 			fields = { "menu", "kind", "abbr" },
-- 			formatting = {
-- 				format = function(entry, vim_item)
-- 					vim_item.kind = kind_icons[vim_item.kind]
-- 					vim_item.menu = ({
-- 						path = "[Path]",
-- 						emoji = "[Emoji]",
-- 						buffer = "[Buffer]",
-- 						codeium = "[Codeium]",
-- 						nvim_lsp = "[LSP]",
-- 						luasnip = "[LuaSnip]",
-- 						nvim_lua = "[Lua]",
-- 						latex_symbols = "[LaTeX]",
-- 					})[entry.source.name]
--
-- 					if entry.source.name == "emoji" then
-- 						vim_item.kind = kind_icons.Emoji
-- 						vim_item.kind_hl_group = "CmpItemKindEmoji"
-- 					end
--
-- 					if entry.source.name == "codeium" then
-- 						vim_item.kind = " "
-- 						vim_item.kind_hl_group = "CmpItemKindCodeium"
-- 					end
--
-- 					return vim_item
-- 				end,
-- 			},
--
-- 			mapping = {
-- 				["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
-- 				["<C-j>"] = cmp.mapping.select_next_item(select_opts),
-- 				["<Down>"] = cmp.mapping.select_next_item(select_opts),
-- 				["<Up>"] = cmp.mapping.select_prev_item(select_opts),
--
-- 				["<C-u>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-d>"] = cmp.mapping.scroll_docs(4),
--
-- 				["<C-e>"] = cmp.mapping.abort(),
-- 				["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 				["<CR>"] = cmp.mapping.confirm({ select = false }),
--
-- 				["<C-f>"] = cmp.mapping(function(fallback)
-- 					if luasnip.jumpable(1) then
-- 						luasnip.jump(1)
-- 					else
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
--
-- 				["<C-b>"] = cmp.mapping(function(fallback)
-- 					if luasnip.jumpable(-1) then
-- 						luasnip.jump(-1)
-- 					else
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
--
-- 				--  trigger completion control+space
-- 				["<C-Space>"] = cmp.mapping.complete(),
-- 			},
-- 			window = {
-- 				completion = {
-- 					border = "rounded",
-- 				},
-- 				documentation = {
-- 					border = "rounded",
-- 				},
-- 			},
-- 			experimental = {
-- 				ghost_text = false,
-- 			},
-- 		})
--
-- 		cmp.setup.cmdline("/", {
-- 			mapping = cmp.mapping.preset.cmdline(),
-- 			sources = {
-- 				{ name = "buffer" },
-- 			},
-- 		})
--
-- 		cmp.setup.cmdline(":", {
-- 			mapping = cmp.mapping.preset.cmdline({
-- 				-- Use default nvim history scrolling
-- 				["<C-j>"] = {
-- 					c = function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_next_item()
-- 						else
-- 							fallback()
-- 						end
-- 					end,
-- 				},
-- 				["<C-k>"] = {
-- 					c = function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_prev_item()
-- 						else
-- 							fallback()
-- 						end
-- 					end,
-- 				},
-- 				["<C-n>"] = {
-- 					c = false,
-- 				},
-- 				["<C-p>"] = {
-- 					c = false,
-- 				},
-- 			}),
-- 			sources = cmp.config.sources({
-- 				{ name = "path" },
-- 			}, {
-- 				{
-- 					name = "cmdline",
-- 					option = {
-- 						ignore_cmds = { "Man", "!" },
-- 					},
-- 				},
-- 			}),
-- 		})
--
-- 		cmp.setup.filetype({ "sql" }, {
-- 			sources = {
-- 				{ name = "vim-dadbod-completion" },
-- 				{ name = "buffer" },
-- 			},
-- 		})
--
-- 		-- gray
-- 		vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
-- 		-- blue
-- 		vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
-- 		vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
-- 		-- light blue
-- 		vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
-- 		vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
-- 		vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
-- 		-- pink
-- 		vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
-- 		vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
-- 		-- front
-- 		vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
-- 		vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
-- 		vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
-- 	end,
-- }
--
-- return M

return {
	"saghen/blink.cmp",
	event = { "LspAttach", "InsertCharPre" },
	version = "v0.*",
	opts = {
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		nerd_font_variant = "normal",
		accept = { auto_brackets = { enabled = true } },
		-- trigger = { signature_help = { enabled = true } },

		keymap = {
			show = "<C-space>",
			hide = { "<C-d>" },
			accept = "<CR>",
			-- select_prev = { "<Up>", "<C-p>" },
			-- select_next = { "<Down>", "<C-n>" },

			show_documentation = {},
			hide_documentation = {},
			scroll_documentation_up = "<C-y>",
			scroll_documentation_down = "<C-e>",
		},

		windows = {
			autocomplete = {
				border = "single",
			},
			documentation = {
				border = "single",
			},
		},
	},
}
