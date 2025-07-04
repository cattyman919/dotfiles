return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"Kaiser-Yang/blink-cmp-avante",
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},

		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {

			keymap = {
				preset = "super-tab",
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { -- Define 'completion' as a key
				documentation = { auto_show = false },
				menu = {
					draw = {

						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } }, -- 'columns' is a key in 'draw'
					},
				},
			},
			sources = {
				-- Add 'avante' to the list
				default = { "avante", "lsp", "buffer", "snippets", "path" },
				providers = {
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {
							-- options for blink-cmp-avante
						},
					},
				},
			},

			signature = { enabled = true },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
