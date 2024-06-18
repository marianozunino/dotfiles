local M = {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons", "xvzc/chezmoi.nvim" },
	keys = {
		{
			"<leader>/",
			function()
				require("fzf-lua").files({ cwd_prompt = false, preview_opts = "hidden" })
			end,
			desc = "Find Files",
		},
		{
			desc = "Chezmoi Files",
			"<leader>cf",
			function()
				require("fzf-lua").files({
					prompt = "Chezmoi: ",
					cmd = "chezmoi managed --path-style absolute",
					file_icons = false, -- show file icons?
					actions = {
						["default"] = function(selected)
							local file = selected[1]

							require("chezmoi.commands").edit({
								targets = file,
								args = { "--watch" },
							})
						end,
					},
				})
			end,
		},
		{
			";",
			"<cmd> :FzfLua buffers<CR>",
			desc = "Find Buffers",
		},
		{
			"<leader>gf",
			"<cmd> :FzfLua live_grep<CR>",
			desc = "Find Live Grep",
		},
		{
			"<leader>sb",
			"<cmd> :FzfLua grep_curbuf<CR>",
			desc = "Search Current Buffer",
		},
		{
			"<leader>gw",
			"<cmd> :FzfLua grep_cword<CR>",
			desc = "Search word under cursor",
		},
		{
			"<leader>gW",
			"<cmd> :FzfLua grep_cWORD<CR>",
			desc = "Search WORD under cursor",
		},
		{
			"<leader>sk",
			"<cmd> :FzfLua keymaps<CR>",
			desc = "Search Keymaps",
		},
		{
			"<leader>sh",
			"<cmd> :FzfLua help_tags<CR>",
			desc = "Search Help",
		},
	},
}

M.config = function()
	local fzf_lua = require("fzf-lua")

	fzf_lua.setup({
		layout = "telescope",
		keymap = {
			fzf = {
				["CTRL-Q"] = "select-all+accept",
			},
		},
		grep = {
			fzf_opts = {
				["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
			},
		},
	})

	vim.lsp.handlers["textDocument/codeAction"] = fzf_lua.lsp_code_actions
	vim.lsp.handlers["textDocument/declaration"] = fzf_lua.lsp_declarations
	vim.lsp.handlers["textDocument/typeDefinition"] = fzf_lua.lsp_typedefs
	vim.lsp.handlers["textDocument/documentSymbol"] = fzf_lua.lsp_document_symbols
	vim.lsp.handlers["workspace/symbol"] = fzf_lua.lsp_workspace_symbols
	vim.lsp.handlers["callHierarchy/incomingCalls"] = fzf_lua.lsp_incoming_calls
	vim.lsp.handlers["callHierarchy/outgoingCalls"] = fzf_lua.lsp_outgoing_calls
	vim.lsp.handlers["textDocument/implementation"] = function()
		return fzf_lua.lsp_implementations({ jump_to_single_result = true })
	end
	vim.lsp.handlers["textDocument/references"] = function()
		return fzf_lua.lsp_references({ ignore_current_line = true })
	end
	vim.lsp.handlers["textDocument/definition"] = function()
		return fzf_lua.lsp_definitions({ jump_to_single_result = true })
	end

	-- Automatic sizing of height/width of vim.ui.select
	fzf_lua.register_ui_select(function(_, items)
		local min_h, max_h = 0.60, 0.80
		local h = (#items + 4) / vim.o.lines
		if h < min_h then
			h = min_h
		elseif h > max_h then
			h = max_h
		end
		return { winopts = { height = h, width = 0.80, row = 0.40 } }
	end)
end

return M
