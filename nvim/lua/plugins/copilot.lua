return {
	{
		"zbirenbaum/copilot.lua",
		enabled = false,
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			-- Disable the default UI from copilot.lua
			-- We want blink.cmp to handle the display
			panel = { enabled = false },
			suggestion = { enabled = false },
		},
	},
}
