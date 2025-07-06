return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = {
					window = {
						size = { width = "100%", height = "50%" },
						position = "100%",
						sections = {
							left = {
								size = "15%",
							},
						},
					},
					lsp = { auto_attach = true },
				},
			},
		},
		opts = {
			servers = {
				lua_ls = {},
				gopls = {},
				basedpyright = {},
				bashls = {},
				ts_ls = {},
				qmlls = {},
				cssls = {},
				tailwindcss = {},
				rust_analyzer = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")

      if opts.servers.phpactor then
        opts.servers.phpactor.root_dir = util.root_pattern(".git", "composer.json", ".phpactor.json", ".phpactor.yml")
      end

      for server, config in pairs(opts.servers) do
        if type(config) ~= "table" then
          config = {}
        end

				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end,
	},
}
