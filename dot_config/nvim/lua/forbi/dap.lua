local dap = require("dap")
local dapui = require("dapui")
local nnoremap = require("forbi.keymap").nnoremap

require("dap-go").setup()

local home = os.getenv("HOME")

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { home .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
}

dap.configurations.typescript = {
	{
		name = "ts-node (Node2 with ts-node)",
		type = "node2",
		request = "launch",
		cwd = vim.loop.cwd(),
		runtimeArgs = { "-r", "ts-node/register", "-r", "tsconfig-paths/register", "-r", "dotenv/config" },
		runtimeExecutable = "node",
		args = { "--inspect", "${file}" },
		sourceMaps = true,
		skipFiles = { "<node_internals>/**", "node_modules/**" },
	},
	{
		name = "Jest (Node2 with ts-node)",
		type = "node2",
		request = "launch",
		cwd = vim.loop.cwd(),
		runtimeArgs = { "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest" },
		runtimeExecutable = "node",
		args = { "${file}", "--runInBand", "--coverage", "false" },
		sourceMaps = true,
		port = 9229,
		skipFiles = { "<node_internals>/**", "node_modules/**" },
	},
}

vim.g.dap_virtual_text = true

require("nvim-dap-virtual-text").setup({
	enabled = true,

	-- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
	enabled_commands = false,

	-- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
	highlight_changed_variables = true,
	highlight_new_as_changed = true,

	-- prefix virtual text with comment string
	commented = true,

	show_stop_reason = true,

	-- experimental features:
	virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
	all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
})

require("dapui").setup({
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
			},
			size = 0.20,
			position = "left",
		},
		{
			elements = { "repl" },
			size = 0.10,
			position = "bottom",
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open(1)
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

nnoremap("<Home>", function()
	dapui.toggle(1)
end)

nnoremap("<End>", function()
	dapui.toggle(2)
end)

-- nnoremap("<leader><leader>", function()
-- 	dap.close()
-- end)

nnoremap("<Up>", function()
	dap.continue()
end)

nnoremap("<Down>", function()
	dap.step_over()
end)

nnoremap("<Right>", function()
	dap.step_into()
end)

nnoremap("<Left>", function()
	dap.step_out()
end)

nnoremap("<Leader>b", function()
	dap.toggle_breakpoint()
end)

nnoremap("<Leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

nnoremap("<leader>rc", function()
	dap.run_to_cursor()
end)

local config = {
	breakpoint = {
		text = "",
		texthl = "LspDiagnosticsSignError",
		linehl = "",
		numhl = "",
	},
	breakpoint_rejected = {
		text = "",
		texthl = "LspDiagnosticsSignHint",
		linehl = "",
		numhl = "",
	},
	stopped = {
		text = "",
		texthl = "LspDiagnosticsSignInformation",
		linehl = "DiagnosticUnderlineInfo",
		numhl = "LspDiagnosticsSignInformation",
	},
}

vim.fn.sign_define("DapBreakpoint", config.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", config.breakpoint_rejected)
vim.fn.sign_define("DapStopped", config.stopped)
