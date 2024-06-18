local wezterm = require("wezterm")
local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local ws = wezterm.mux.get_active_workspace()
	return ws
end)

return {
	colors = theme.colors(),
	enable_tab_bar = false,
	font_size = 12.0,
	font = wezterm.font("JetBrains Mono"),

	window_background_opacity = 0.92,
	window_decorations = "NONE",
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	hyperlink_rules = wezterm.default_hyperlink_rules(),

	mouse_bindings = {
		-- Disable the default click behavior
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
		-- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.Nop,
		},
	},
}
