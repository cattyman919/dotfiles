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
		end,
	},
}
