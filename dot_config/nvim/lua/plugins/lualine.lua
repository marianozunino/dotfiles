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

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_c = { get_file_name },
			},
		})
	end,
}
