local M = {
	-- "github/copilot.vim",
	"Exafunction/codeium.vim",
	cmd = "CodeiumEnable",
	commit = "289eb72",
}

M.config = function()
	vim.g.codeium_disable_bindings = 1
	local keymap = vim.keymap.set

	keymap("i", "<Tab>", function()
		return vim.fn["codeium#Accept"]()
	end, { expr = true, silent = true, desc = "[codeium] Accept completion" })
	keymap("i", "<c-;>", function()
		return vim.fn["codeium#CycleCompletions"](1)
	end, { expr = true, silent = true, desc = "[codeium] Cycle completions" })
	keymap("i", "<c-,>", function()
		return vim.fn["codeium#CycleCompletions"](-1)
	end, { expr = true, silent = true, desc = "[codeium] Cycle completions" })

	-- keymap("i", "<Tab>", function()
	-- 	return vim.fn["copilot#Accept"]()
	-- end, { expr = true, silent = true })
	-- keymap("i", "<c-;>", function()
	-- 	return vim.fn["copilot#Next"]()
	-- end, { expr = true, silent = true })
	-- keymap("i", "<c-,>", function()
	-- 	return vim.fn["codeium#Prev"]()
	-- end, { expr = true, silent = true })
end

return M
