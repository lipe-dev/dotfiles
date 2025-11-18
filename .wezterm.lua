local wezterm = require("wezterm")

return {
	keys = {
		-- Disable the default Alt+j binding
		{
			key = "j",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- Disable the default Alt+k binding
		{
			key = "k",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}
