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
				basedpyright = {},
				bashls = {},
				ts_ls = {},
				qmlls = {},
				cssls = {},
				tailwindcss = {},
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
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
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

			-- [[ Configure Inlay Hints on LspAttach ]]
			-- This block will enable inlay hints automatically for any attached LSP that supports them.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}), -- Create a new augroup or use an existing one
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					-- Check if the server supports inlay hints
					if client and client.server_capabilities.inlayHintProvider then
						-- Enable inlay hints for the buffer
						vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
					end
				end,
			})

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
}
