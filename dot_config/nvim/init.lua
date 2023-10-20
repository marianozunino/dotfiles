require("mzunino")

function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

-- if file is a C file, use the catppuccino color scheme
-- ColorMyPencils("catppuccin-latte")
ColorMyPencils("rose-pine")

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})
