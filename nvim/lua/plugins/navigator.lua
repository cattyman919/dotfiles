return {
  "ray-x/navigator.lua",
  dependencies = {
    -- guihua.lua is strictly required by navigator.lua for its floating windows and UI
    { "ray-x/guihua.lua",     build = "cd lua/fzy && make" },
    { "neovim/nvim-lspconfig" },
  },
  event = { "BufReadPre", "BufNewFile" }, -- Lazy load it when opening a file
  config = function()
    require("navigator").setup({
      mason = false, -- You already handle Mason in your lsp.lua
      transparency = 100,
      lsp = {
        -- CRITICAL: This prevents navigator from running lspconfig[server].setup()
        -- and breaking your existing blink.cmp and yamlls configurations!
        disable_lsp = "all",
        code_action = { sign = false, virtual_text = false },
        code_lens_action = { sign = false, virtual_text = false },
      },
      -- Navigator sets up its own default keymaps (e.g., 'gr' for references, 'gd' for definition).
      -- Set this to false if you want to strictly use the ones you defined in lua/config/core/keymaps.lua
      default_mapping = true,
    })
  end,
}
