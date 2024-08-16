local keymap = vim.keymap.set

keymap("n", "<Space>", "")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "Y", "yy")

keymap("n", "<leader><leader>", "<c-^>", { desc = "Switch to last buffer" })

keymap("n", "<M-h>", ":vertical resize +3<CR>", { desc = "Resize window" })
keymap("n", "<M-l>", ":vertical resize -3<CR>", { desc = "Resize window" })
keymap("n", "<M-k>", ":resize +3<CR>", { desc = "Resize window" })
keymap("n", "<M-j>", ":resize -3<CR>", { desc = "Resize window" })

vim.cmd([[
  nnoremap <silent> <C-j> <C-d>
  nnoremap <silent> <C-k> <C-u>
]])

keymap("n", "n", "nzz", { desc = "Move to next search match" })
keymap("n", "N", "Nzz", { desc = "Move to previous search match" })
keymap("n", "*", "*zz", { desc = "Move to next search match" })
keymap("n", "#", "#zz", { desc = "Move to previous search match" })
keymap("n", "g*", "g*zz", { desc = "Move to next search match" })
keymap("n", "g#", "g#zz", { desc = "Move to previous search match" })

-- stay in indent mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- keep register after paste
keymap("x", "p", [["_dP]])

keymap({ "n", "o", "x" }, "<s-h>", "^", { desc = "Move to first non-blank character" })
keymap({ "n", "o", "x" }, "<s-l>", "g_", { desc = "Move to last non-blank character" })

keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", function()
	vim.api.nvim_command("bd!|qall!")
end, { desc = "Quit all" })

-- create a user command to save without formatting :noa w
vim.api.nvim_create_user_command("W", function()
	-- if buffer is empty, don't save
	if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
		return vim.notify("Buffer is empty, not saving", vim.log.levels.ERROR)
	end
	vim.api.nvim_command("noa w")
end, { nargs = 0, desc = "Save without formatting" })

-- move lines
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- undo tree
keymap("n", "<leader>u", vim.cmd.UndotreeToggle)

-- nnoremap yl :let @" = expand("%:p")<cr>
keymap("n", "yl", function()
	local file = vim.fn.expand("%:p")
	print("Copied path to clipboard: " .. file)
	-- copy to os clipboard
	vim.fn.setreg("+", file)
end, { desc = "Copy file path to clipboard" })

keymap("n", "<Leader>x", "<cmd>!chmod +x %<cr>", { desc = "Make file executable" })

vim.g.user_emmet_leader_key = ","

keymap("n", "<leader>gp", "<CMD>Git push<CR>", { desc = "Git push" })

-- reset cmdheight
keymap("n", "<leader>ch", function()
	vim.o.cmdheight = 1
end, { desc = "Reset cmdheight" })

keymap("n", "<leader>w", function()
	vim.api.nvim_command("w")
end, { desc = "Save" })

keymap("n", "<leader>W", function()
	vim.api.nvim_command("wa")
end, { desc = "Save all" })

-- format json using jq
keymap("n", "<leader>jq", ":%!jq '.'<CR>", { desc = "Format json using jq" })
keymap("v", "<leader>jq", ":!jq '.'<CR>", { desc = "Format json using jq" })

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
