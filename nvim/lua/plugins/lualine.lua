return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("battery").setup({})
		local nvimbattery = {
			function()
				return require("battery").get_status_line()
			end,
		}
		require("lualine").setup({
			options = {
				theme = "ayu_mirage",
			},
			sections = {
        lualine_x = { nvimbattery, 'filetype'},
			},
		})
	end,
}
