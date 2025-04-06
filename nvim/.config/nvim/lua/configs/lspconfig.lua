-- load defaults i.e lua_lsp
-- require("nvchad.configs.lspconfig").defaults()

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

-- EXAMPLE
-- local servers = {
-- 	"html",
-- 	"cssls",
-- 	"lua_ls",
-- 	"clangd",
-- 	"gopls",
-- 	"ts_ls",
-- 	"yamlls",
-- 	"html",
-- 	"mdx_analyzer",
-- 	"rust_analyzer",
-- 	"texlab",
-- 	"basedpyright",
-- }

-- lsps with default config
-- for _, lsp in ipairs(servers) do
-- 	lspconfig[lsp].setup({
-- 		on_attach = nvlsp.on_attach,
-- 		on_init = nvlsp.on_init,
-- 		capabilities = nvlsp.capabilities,
-- 	})
-- end

-- setup with mason-lspconfig
require("mason-lspconfig").setup_handlers({
	function(server)
		lspconfig[server].setup({
			{
				on_attach = nvlsp.on_attach,
				on_init = nvlsp.on_init,
				capabilities = nvlsp.capabilities,
			},
		})
	end,
})
