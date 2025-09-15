return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		opts = {
			transparent = false, -- do not set background color
		},
		config = function()
			-- Themes
			vim.o.background = "dark" -- or "light" for light mode
			vim.cmd([[colorscheme kanagawa]])

			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#414868" })
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7" })
			vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#7aa2f7", bold = true })
			-- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "Yellow", bold = true })
		end,
	},
}
