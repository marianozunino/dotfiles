local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"echasnovski/mini.icons",
		-- "nvim-tree/nvim-web-devicons",
		-- "ofseed/copilot-status.nvim",
	},
}

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

local function filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end

	return string.format("%%<%s/", fpath)
end

local get_file_name = function()
	if vim.b.filetype == "oil" then
		return require("oil").get_current_dir()
	end
	return filepath() .. filename()
end

M.config = function()
	require("lualine").setup({
		options = {
			-- theme = "rose-pine-alt", -- or theme = 'rose-pine'
			-- theme = "catppuccin",
			theme = "rose-pine",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_b = { "branch" },
			lualine_c = { "diagnostics", get_file_name },
			lualine_x = {
				-- {
				-- 	"copilot",
				-- 	show_running = true,
				-- 	symbols = {
				-- 		status = {
				-- 			enabled = "",
				-- 			disabled = "",
				-- 		},
				-- 		spinners = require("copilot-status.spinners").meter,
				-- 	},
				-- },
				"filetype",
				"fileformat",
				"encoding",
			},
			lualine_y = { "progress" },
		},
		winbar = {
			lualine_c = {
				{
					"navic",
					color_correction = nil,
					navic_opts = nil,
				},
			},
		},
	})
end

return M
