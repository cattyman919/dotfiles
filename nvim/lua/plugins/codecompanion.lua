return {
	"olimorris/codecompanion.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"ravitemer/mcphub.nvim",
		"nvim-mini/mini.diff",
	},
	opts = {
		display = {
			action_palette = {
				provider = "snacks", -- telescope|fzf_lua|mini_pick|snacks|default
				width = 95,
				height = 10,
				prompt = "Prompt ",
				opts = {
					show_preset_actions = true,
					show_preset_prompts = true,
					show_preset_rules = true,
					title = "CodeCompanion actions",
				},
			},
		},
		interactions = {
			cli = {
				agent = "opencode",
				agents = {
					opencode = {
						cmd = "opencode",
						args = {},
						description = "Opencode CLI",
						provider = "terminal",
					},
				},
			},
			chat = {
				adapter = "opencode",
			},
			inline = {
				adapter = "opencode",
			},
		},
		-- Optional: Only needed if you have to explicitly pass environment variables
		-- that aren't already sourced in your current terminal session.
		adapters = {
			acp = {
				opencode = function()
					return require("codecompanion.adapters").extend("opencode", {
						commands = {
							default = {
								"opencode",
								"acp",
							},
						},
					})
				end,
			},
		},
		-- NOTE: The log_level is in `opts.opts`
		opts = {},
	},
	config = function(_, opts)
		require("codecompanion").setup(opts)

		-- The CLI interaction triggered afterward
		require("codecompanion.interactions.cli").create({ agent = "opencode" })
	end,
}
