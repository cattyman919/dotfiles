return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    local configs = require("nvim-web-devicons")
    configs.setup({
      default = true,
    })
  end,
}
