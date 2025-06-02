require("config.lazy")

-- Configs
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus" -- Allow system clipboards
vim.opt.number = true
vim.opt.relativenumber = true

-- Themes
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme kanagawa]])

-- Keymaps
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<C-s>", ":write<CR>")
vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)
end)
vim.keymap.set("n", "<C-n>", ":Oil --float .<CR>")

-- AutoCommands

-- See `:help vim_highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
