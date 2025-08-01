return {
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			require("luasnip").filetype_extend("typescript", { "html" })
			require("luasnip").filetype_extend("javascript", { "html" })

			require("luasnip").filetype_extend("typescriptreact", { "html", "typescript" })
			require("luasnip").filetype_extend("javascriptreact", { "html", "javascript" })
		end,
	},

	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"Kaiser-Yang/blink-cmp-avante",
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
			"nvim-tree/nvim-web-devicons",
			"onsails/lspkind.nvim",
		},

		version = "1.*",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {

			keymap = {
				preset = "none",
				["<M-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<M-e>"] = { "hide" },
				["<C-e>"] = { "hide" },
				["<C-l>"] = { "select_and_accept" },
				["<M-l>"] = { "select_and_accept" },
				-- ["<CR>"] = { "select_and_accept" },
				["<M-j>"] = { "select_next", "fallback_to_mappings" },
				["<M-k>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { -- Define 'completion' as a key
				trigger = {
					show_on_keyword = true,
				},

				documentation = {
					auto_show = true,
					-- Delay before showing the documentation window
					auto_show_delay_ms = 1000,
					-- Delay before updating the documentation window when selecting a new item,
					-- while an existing item is still visible
					update_delay_ms = 50,
				},
				menu = {
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } }, -- 'columns' is a key in 'draw'
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
			},
			signature = {
				enabled = true,
			},
			sources = {
				-- Add 'avante' to the list
				default = { "lsp", "buffer", "snippets", "path" },
				-- providers = {
				-- 	avante = {
				-- 		module = "blink-cmp-avante",
				-- 		name = "Avante",
				-- 		opts = {
				-- 			-- options for blink-cmp-avante
				-- 		},
				-- 	},
				-- },
			},
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
