return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<C-x>b", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<C-x>d", builtin.buffers, { desc = "Telescope buffers" })

      vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Telescope LSP Definitions" })
      vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Telescope LSP Implementations" })
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
