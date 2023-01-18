local nnoremap = require("forbi.keymap").nnoremap
local inoremap = require("forbi.keymap").inoremap
local vnoremap = require("forbi.keymap").vnoremap
local dev_folders = require("forbi.telescope").dev_folders
local tmux_switcher = require("forbi.telescope").tmux_switcher
local file_browser = require("forbi.telescope").file_browser

nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap("Y", "yy")
nnoremap("?", "?\\v")
nnoremap("/", "/\\v")

nnoremap("<c-s>", ":w<CR>")
inoremap("<c-s>", "<Esc>:w<CR>")

nnoremap("<leader><leader>", "<c-^>")

nnoremap("<leader>qr", function()
	R("forbi")
end)

nnoremap("<leader>gf", function()
	require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ") })
end)

nnoremap("<leader>gw", function()
	require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
end)

nnoremap("<leader>gr", ":Telescope lsp_references<cr>")
nnoremap("<leader>tt", dev_folders)
nnoremap("<leader>gg", tmux_switcher)
nnoremap("<C-p>", file_browser)

nnoremap(";", require("telescope.builtin").buffers)
nnoremap("<leader>vh", require("telescope.builtin").help_tags)
-- nnoremap("<leader>n", require("telescope.builtin").help_tags)
nnoremap("<leader>n", ":NeoTreeRevealToggle<cr>")

nnoremap("<space>vv", ":DiffviewOpen ")

nnoremap("<leader>gs", function()
	require("neogit").open()
end)
nnoremap("<leader>gc", function()
	require("neogit").open({ "commit" })
end)

-- jester
nnoremap("<leader>jr", ":lua require('jester').run()<CR>")
nnoremap("<leader>jd", ":lua require('jester').debug()<CR>")

nnoremap("<M-h>", ":vertical resize +3<CR>")
nnoremap("<M-l>", ":vertical resize -3<CR>")
nnoremap("<M-j>", ":resize +3<CR>")
nnoremap("<M-k>", ":resize -3<CR>")
--
-- create a user command to exit all buffers without saving
vim.api.nvim_create_user_command("Q", function()
	vim.api.nvim_command("bd!|qall!")
end, { nargs = 0 })

-- move lines
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- undo tree
nnoremap("<leader>u", ":UndotreeShow<CR>")

-- tmux navigation
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
nnoremap("<C-g>", "<cmd>silent !tmux-switcher<CR>")

-- togle set list F3
nnoremap("<F3>", ":set list! list?<CR>")

-- reload current lua file
nnoremap("<leader>rl", function()
	local file = vim.api.nvim_buf_get_name(0)
	if file:match("lua") then
		vim.cmd("luafile " .. file)
	end
	print("Reloaded :D")
end)

-- Harpoon mappings

nnoremap("<leader>a", require("harpoon.mark").add_file, { silent = true })
nnoremap("<C-h>", require("harpoon.ui").toggle_quick_menu, { silent = true })
-- nnoremap("<leader>tc", require("harpoon.cmd-ui").toggle_quick_menu, { silent = true })

nnoremap("<leader>1", function()
	require("harpoon.ui").nav_file(1)
end, { silent = true })

nnoremap("<leader>2", function()
	require("harpoon.ui").nav_file(2)
end, { silent = true })

nnoremap("<leader>3", function()
	require("harpoon.ui").nav_file(3)
end, { silent = true })

nnoremap("<leader>4", function()
	require("harpoon.ui").nav_file(4)
end, { silent = true })

nnoremap("<Leader><Leader>i", "<cmd>IconPickerNormal<cr>")

-- nnoremap yl :let @" = expand("%:p")<cr>
nnoremap("yl", function()
	local file = vim.fn.expand("%:p")
	print("Copied path to clipboard: " .. file)
	-- copy to os clipboard
	vim.fn.setreg("+", file)
end)

nnoremap("<Leader>x", "<cmd>!chmod +x %<cr>")
