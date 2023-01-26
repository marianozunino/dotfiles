require("forbi.packer")

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})

require("forbi.utils")
require("impatient")
require("forbi.set")
require("forbi.lsp")
require("forbi.snip")
require("forbi.cmp")
require("forbi.null-ls")
require("forbi.nvim-tree")
require("forbi.treesitter")
require("forbi.others")
require("forbi.remap")
require("forbi.dap")
