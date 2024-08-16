local M = {
	"Exafunction/codeium.vim",
	cmd = "CodeiumEnable",
}

M.config = function()
	vim.g.codeium_disable_bindings = 1
	local keymap = vim.keymap.set

	keymap("i", "<Tab>", function()
		return vim.fn["codeium#Accept"]()
	end, { expr = true, silent = true, desc = "[codeium] Accept completion" })

	keymap("i", "<M-;>", function()
		return vim.fn["codeium#CycleCompletions"](1)
	end, { expr = true, silent = true, desc = "[codeium] Cycle completions" })

	keymap("i", "<M-,>", function()
		return vim.fn["codeium#CycleCompletions"](-1)
	end, { expr = true, silent = true, desc = "[codeium] Cycle completions" })
end

return M
