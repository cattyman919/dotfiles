return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "go", "gomod" },
  -- This automatically installs/updates the required Go binaries (impl, gotests, gomodifytags, etc.)
  build = ':lua require("go.install").update_all_sync()',
  config = function()
    require("go").setup({
      -- CRITICAL: Prevents go.nvim from overwriting your custom gopls config in lsp.lua
      lsp_cfg = false,

      -- Disable go.nvim's inlay hints because you already enabled them natively inside your gopls settings
      lsp_inlay_hints = { enable = false },

      -- You are using conform.nvim for formatting, so we disable go.nvim's formatting hooks
      lsp_document_formatting = false,

      -- Route diagnostics and errors to trouble.nvim (since you have it installed)
      trouble = true,

      -- Enable integration with LuaSnip (which you have configured in completion.lua)
      luasnip = true,
    })
  end,
}
