vim.opt.guicursor = "a:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.cursorline = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.hlsearch = true

vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus" -- Global clipboard
vim.opt.mouse = "a" -- Allow to use mouse from terminal
vim.opt.colorcolumn = "80"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.showmatch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

vim.g.neoformat_try_node_exe = 1

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 50 })
	end,
	group = group,
})

vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 3
vim.opt.foldenable = false
vim.opt.scrolloff = 999

vim.g.copilot_filetypes = {
	["dap-repl"] = false,
	["markdown"] = true,
	["yaml"] = true,
}
vim.g.copilot_node_command = "~/.asdf/shims/node"

--
-- neovide
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_animation_length = 0.05
vim.opt.guifont = { "Fira Code Retina", ":h11" }

vim.opt.title = true
vim.opt.titlestring = "Code - %{substitute(getcwd(), $HOME, '~', '')}"

-- Theme
vim.opt.background = "dark"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.cmd("colorscheme gruvbox-material")

vim.opt.listchars = "tab:→ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨"
vim.g.go_doc_keywordprg_enabled = 0

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
vim.g.netrw_localrmdir = "rm -r"
