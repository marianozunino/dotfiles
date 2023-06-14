local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too

require("neo-tree").setup({
	filesystem = {
		hijack_netrw_behavior = "open_default",
		components = {
			harpoon_index = function(config, node)
				local Marked = require("harpoon.mark")
				local path = node:get_id()
				local succuss, index = pcall(Marked.get_index_of, path)
				if succuss and index and index > 0 then
					return {
						text = string.format(" %d", index),
						highlight = config.highlight or "NeoTreeDirectoryIcon",
					}
				else
					return {}
				end
			end,
		},
		renderers = {
			file = {
				{ "icon" },
				{ "name", use_git_status_colors = true },
				{ "diagnostics" },
				{ "git_status", highlight = "NeoTreeDimText" },
				{ "harpoon_index" }, --> This is what actually adds the component in where you want it
			},
		},
		filtered_items = {
			hide_dotfiles = false,
		},
		window = {
			mappings = {
				-- use escape to close
				["<Esc>"] = "close",
				["l"] = "open",
			},
		},
	},
	event_handlers = {
		{
			event = "file_opened",
			handler = function()
				--auto close
				require("neo-tree").close_all()
			end,
		},
	},
})
