local M = {
	"github/copilot.vim",
	event = "BufEnter",
}

function M.config()
	local keymap = vim.keymap.set

	-- vim.g.codeium_disable_bindings = 1
	-- keymap("i", "<Tab>", function()
	-- 	return vim.fn["codeium#Accept"]()
	-- end, { expr = true, silent = true })
	-- keymap("i", "<c-;>", function()
	-- 	return vim.fn["codeium#CycleCompletions"](1)
	-- end, { expr = true, silent = true })
	-- keymap("i", "<c-,>", function()
	-- 	return vim.fn["codeium#CycleCompletions"](-1)
	-- end, { expr = true, silent = true })

	keymap("i", "<Tab>", function()
		return vim.fn["copilot#Accept"]()
	end, { expr = true, silent = true })
	keymap("i", "<c-;>", function()
		return vim.fn["copilot#Next"]()
	end, { expr = true, silent = true })
	keymap("i", "<c-,>", function()
		return vim.fn["codeium#Prev"]()
	end, { expr = true, silent = true })
end

return M
