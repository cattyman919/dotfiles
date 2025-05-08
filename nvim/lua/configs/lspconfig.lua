-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"html",
		"cssls",
		"clangd",
		"gopls",
		"ts_ls",
		"yamlls",
		"rust_analyzer",
		"texlab",
		"lua_ls",
	},
})

local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")

-- setup with mason-lspconfig
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
				on_attach = nvlsp.on_attach,
				on_init = nvlsp.on_init,
				capabilities = nvlsp.capabilities,
		})
	end,
})
