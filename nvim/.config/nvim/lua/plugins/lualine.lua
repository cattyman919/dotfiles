return {

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
				lualine_c = {
					{
						"filetype",
						icon_only = true,
						separator = "",
						padding = 1,
						icon = { align = "right" },
					},
					{
						"filename",
						path = 1,
						padding = 0,
						separator = "",
					},
				},
				lualine_x = { "diff", "diagnostics" },
				lualine_y = { "lsp_status" },
				lualine_z = { "" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},

			inactive_winbar = {},
			extensions = {},
		},
	},
}
