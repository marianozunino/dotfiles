local dev_folders = require("mzunino.telescope").dev_folders
local tmux_switcher = require("mzunino.telescope").tmux_switcher
local file_browser = require("mzunino.telescope").file_browser

vim.keymap.set("n", "<space>n", ":Oil<CR>")

vim.keymap.set("n", "Y", "yy")
vim.keymap.set("n", "?", "?\\v")
vim.keymap.set("n", "/", "/\\v")

vim.keymap.set("n", "<leader><leader>", "<c-^>")

vim.keymap.set("n", "<leader>qr", function()
	R("forbi")
end)

vim.keymap.set("n", "<leader>gf", function()
	require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ") })
end)

vim.keymap.set("n", "<leader>gw", function()
	require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
end)

vim.keymap.set("n", "<leader>gr", ":Telescope lsp_references<cr>")
vim.keymap.set("n", "<leader>tt", dev_folders)
vim.keymap.set("n", "<leader>gg", tmux_switcher)
vim.keymap.set("n", "<C-p>", file_browser)

vim.keymap.set("n", ";", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>vh", require("telescope.builtin").help_tags)

vim.keymap.set("n", "<space>vv", ":DiffviewOpen ")

-- jester
vim.keymap.set("n", "<leader>jr", ":lua require('jester').run()<CR>")
vim.keymap.set("n", "<leader>jd", ":lua require('jester').debug()<CR>")

vim.keymap.set("n", "<M-h>", ":vertical resize +3<CR>")
vim.keymap.set("n", "<M-l>", ":vertical resize -3<CR>")
vim.keymap.set("n", "<M-j>", ":resize +3<CR>")
vim.keymap.set("n", "<M-k>", ":resize -3<CR>")
--
-- create a user command to exit all buffers without saving
vim.api.nvim_create_user_command("Q", function()
	vim.api.nvim_command("bd!|qall!")
end, { nargs = 0 })

-- create a user command to save without formatting :noa w
vim.api.nvim_create_user_command("W", function()
	-- if buffer is empty, don't save
	if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
		return vim.notify("Buffer is empty, not saving", vim.log.levels.ERROR)
	end
	vim.api.nvim_command("noa w")
end, { nargs = 0 })

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- undo tree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- tmux navigation
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-g>", "<cmd>silent !tmux-switcher<CR>")

-- togle set list F3
vim.keymap.set("n", "<F3>", ":set list! list?<CR>")

-- reload current lua file
vim.keymap.set("n", "<leader>rl", function()
	local file = vim.api.nvim_buf_get_name(0)
	if file:match("lua") then
		vim.cmd("luafile " .. file)
	end
	print("Reloaded :D")
end)

-- Harpoon mappings

vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file, { silent = true })
vim.keymap.set("n", "<C-h>", require("harpoon.ui").toggle_quick_menu, { silent = true })
-- vim.keymap.set("n", "<leader>tc", require("harpoon.cmd-ui").toggle_quick_menu, { silent = true })

vim.keymap.set("n", "<leader>1", function()
	require("harpoon.ui").nav_file(1)
end, { silent = true })

vim.keymap.set("n", "<leader>2", function()
	require("harpoon.ui").nav_file(2)
end, { silent = true })

vim.keymap.set("n", "<leader>3", function()
	require("harpoon.ui").nav_file(3)
end, { silent = true })

vim.keymap.set("n", "<leader>4", function()
	require("harpoon.ui").nav_file(4)
end, { silent = true })

vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>")

-- nnoremap yl :let @" = expand("%:p")<cr>
vim.keymap.set("n", "yl", function()
	local file = vim.fn.expand("%:p")
	print("Copied path to clipboard: " .. file)
	-- copy to os clipboard
	vim.fn.setreg("+", file)
end)

vim.keymap.set("n", "<Leader>x", "<cmd>!chmod +x %<cr>")
vim.keymap.set("n", "<Leader>cc", ":CloakToggle<cr>")

vim.g.user_emmet_leader_key = ","

vim.keymap.set("n", "<leader>gs", "<CMD>G<CR>")
vim.keymap.set("n", "<leader>gq", "<CMD>G<CR><CMD>q<CR>")
vim.keymap.set("n", "<leader>gp", "<CMD>Git push<CR>")

vim.keymap.set("n", "]t", function()
	-- jump to the previous item, skipping the groups
	require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	-- jump to the first item, skipping the groups
	require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "Previous todo comment" })
