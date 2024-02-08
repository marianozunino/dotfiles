local keymap = vim.keymap.set

keymap("n", "<Space>", "")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "Y", "yy")
-- keymap("n", "?", "?\\v")
-- keymap("n", "/", "/\\v")

keymap("n", "<leader><leader>", "<c-^>")

keymap("n", "<M-h>", ":vertical resize +3<CR>")
keymap("n", "<M-l>", ":vertical resize -3<CR>")
keymap("n", "<M-j>", ":resize +3<CR>")
keymap("n", "<M-k>", ":resize -3<CR>")

vim.cmd([[
  nnoremap <silent> <C-j> <C-d>
  nnoremap <silent> <C-k> <C-u>
]])

keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "*", "*zz")
keymap("n", "#", "#zz")
keymap("n", "g*", "g*zz")
keymap("n", "g#", "g#zz")

-- stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- keep register after paste
keymap("x", "p", [["_dP]])

keymap({ "n", "o", "x" }, "<s-h>", "^")
keymap({ "n", "o", "x" }, "<s-l>", "g_")

keymap("n", "<leader>q", ":q<CR>")
keymap("n", "<leader>Q", function()
	vim.api.nvim_command("bd!|qall!")
end)

-- create a user command to save without formatting :noa w
vim.api.nvim_create_user_command("W", function()
	-- if buffer is empty, don't save
	if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
		return vim.notify("Buffer is empty, not saving", vim.log.levels.ERROR)
	end
	vim.api.nvim_command("noa w")
end, { nargs = 0 })

-- move lines
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- undo tree
keymap("n", "<leader>u", vim.cmd.UndotreeToggle)

-- togle set list F3
keymap("n", "<F3>", ":set list! list?<CR>")

-- nnoremap yl :let @" = expand("%:p")<cr>
keymap("n", "yl", function()
	local file = vim.fn.expand("%:p")
	print("Copied path to clipboard: " .. file)
	-- copy to os clipboard
	vim.fn.setreg("+", file)
end)

keymap("n", "<Leader>x", "<cmd>!chmod +x %<cr>")

vim.g.user_emmet_leader_key = ","

keymap("n", "<leader>gp", "<CMD>Git push<CR>")

-- reset cmdheight
keymap("n", "<leader>ch", function()
	vim.o.cmdheight = 1
end)

keymap("n", "<leader>w", ":w<CR>")
keymap("n", "<leader>W", ":wa<CR>")

-- format json using jq
keymap("n", "<leader>jq", ":%!jq '.'<CR>")
keymap("v", "<leader>jq", ":!jq '.'<CR>")
