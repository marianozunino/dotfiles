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

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

vim.filetype.add({
	pattern = {
		[".*"] = {
			function(path, buf)
				return vim.bo[buf].filetype ~= "bigfile"
						and path
						and vim.fn.getfsize(path) > vim.g.bigfile_size
						and "bigfile"
					or nil
			end,
		},
	},
})
autocmd({ "FileType" }, {
	group = augroup("bigfile", {}),
	pattern = "bigfile",
	callback = function(ev)
		vim.b.minianimate_disable = true
		vim.schedule(function()
			vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
		end)
	end,
})
