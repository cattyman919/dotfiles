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
    },
    opts = {
      servers = {
        lua_ls = {},
        gopls = {},
        basedpyright = {},
        bashls = {},
        ts_ls = {},
        -- denols = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require "lspconfig"

      for server, config in pairs(opts.servers) do
        -- Ensure server_settings is a table if you plan to add .capabilities to it
        if type(config) ~= "table" then
          config = {}
        end

        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      -- Enable Formatting when saved
      -- vim.api.nvim_create_autocmd('LspAttach', {
      --   callback = function(args)
      --     local c = vim.lsp.get_client_by_id(args.data.client_id)
      --     if not c then return end
      --
      --     if c.supports_method('textDocument/formatting') then
      --       -- Format the current buffer on save
      --       vim.api.nvim_create_autocmd('BufWritePre', {
      --         buffer = args.buf,
      --         callback = function()
      --           vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
      --         end,
      --       })
      --     end
      --   end,
      -- })
    end,
  },
}
