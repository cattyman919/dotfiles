require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local builtin = require('telescope.builtin')

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

map("n", "<leader>fs", builtin.lsp_document_symbols, {desc = "Telescope Symbol Picker"})
map("n", "<leader>ds", builtin.diagnostics, {desc = "Telescope Diagnostics Picker"})
map("n", "<leader>ts", builtin.treesitter, {desc = "Telescope Treesitter Picker"})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
