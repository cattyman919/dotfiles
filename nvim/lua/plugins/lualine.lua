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
				always_show_tabline = false,
				globalstatus = true,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {
					-- 1. Add the Snippet Indicator here
					{
						function()
							-- Check if 'luasnip' is available and if a snippet is active
							if package.loaded["luasnip"] and require("luasnip").in_snippet() then
								return "⚡ SNIP" -- You can use an icon like  or 󰆐
							end
							return ""
						end,
						color = { fg = "#ff9e64", gui = "bold" }, -- Orange color for visibility
					},
					"diff",
					"diagnostics",
				},
				lualine_y = { "lsp_status" },
				lualine_z = { "location" },
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
