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
				"utilyre/barbecue.nvim",
				name = "barbecue",
				version = "*",
				dependencies = {
					"SmiteshP/nvim-navic",
					"nvim-tree/nvim-web-devicons",
				},
				opts = {
					show_dirname = false,
					create_autocmd = false, -- prevent barbecue from updating itself automatically
				},
			},
		},
		opts = {
			servers = {
				lua_ls = {},
				basedpyright = {},
				bashls = {},
				slint_lsp = {},
				ts_ls = {},
				qmlls = {},
				cssls = {},
				neocmake = {},
				angularls = {},
				tailwindcss = {},
				clangd = {
					cmd = { "clangd", "--background-index", "--log=verbose", "--clang-tidy", "--inlay-hints=true" },
				},
				yamlls = {},
				-- sqlls = {},
				sqls = {},
				astro = {},
				dockerls = {},
				-- jdtls = {},
				gopls = {
					settings = {
						gopls = {
							-- enable all types of inlay hints for gopls
							hints = {
								assignVariableTypes = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				bacon_ls = {
					-- Bacon export filename (default: .bacon-locations).
					locationsFile = ".bacon-locations",
					-- Try to update diagnostics every time the file is saved (default: true).
					updateOnSave = true,
					--  How many milliseconds to wait before updating diagnostics after a save (default: 1000).
					updateOnSaveWaitMillis = 50,
					-- Try to update diagnostics every time the file changes (default: true).
					updateOnChange = true,
					-- Try to validate that bacon preferences are setup correctly to work with bacon-ls (default: true).
					validateBaconPreferences = true,
					-- f no bacon preferences file is found, create a new preferences file with the bacon-ls job definition (default: true).
					createBaconPreferencesFile = true,
					-- Run bacon in background for the bacon-ls job (default: true)
					runBaconInBackground = true,
					-- Command line arguments to pass to bacon running in background (default "--headless -j bacon-ls")
					runBaconInBackgroundCommandArguments = "--headless -j bacon-ls",
					-- How many milliseconds to wait between background diagnostics check to synchronize all open files (default: 2000).
					synchronizeAllOpenFilesWaitMillis = 100,
				},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = false,
							diagnostics = false,
							-- enable inlay hints for types and chains
							inlayHints = {
								typeHints = {
									enable = true,
								},
								chainingHints = {
									enable = true,
								},
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")

			if opts.servers.phpactor then
				opts.servers.phpactor.root_dir =
					util.root_pattern(".git", "composer.json", ".phpactor.json", ".phpactor.yml")
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
	"mfussenegger/nvim-jdtls",
	{
		"mason-org/mason.nvim",
		opts = {},
	},
}
