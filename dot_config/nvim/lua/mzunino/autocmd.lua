local cmd = vim.cmd
cmd([[ autocmd BufWritePost ~/.local/share/chezmoi/* silent! ! chezmoi apply --source-path "%" ]])

cmd([[ autocmd FileType netrw lua vim.diagnostic.disable(0) ]])

cmd([[ au BufRead,BufNewFile *.templ set filetype=templ ]])

local augroup = vim.api.nvim_create_augroup
local MZuninoGroup = augroup("mzunino", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = MZuninoGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd({ "BufWritePost" }, {
	group = MZuninoGroup,
	pattern = "~/.local/share/chezmoi/*",
	command = [[! chezmoi apply --source-path "%"]],
})
