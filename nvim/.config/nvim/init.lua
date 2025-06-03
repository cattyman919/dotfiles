require "config.lazy"

-- Configs
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus" -- Allow system clipboards
vim.opt.number = true
vim.opt.relativenumber = true

-- Themes
vim.o.background = "dark" -- or "light" for light mode
vim.cmd [[colorscheme kanagawa]]

-- Diagnostics
vim.diagnostic.config {
  -- Show signs in the gutter
  signs = {
    active = true,
    -- text = {
    --   [vim.diagnostic.severity.ERROR] = "", -- Icon for Error
    --   [vim.diagnostic.severity.WARN] = "", -- Icon for Warning
    --   [vim.diagnostic.severity.INFO] = "", -- Icon for Info
    --   [vim.diagnostic.severity.HINT] = "", -- Icon for Hint
    -- },
  }, -- or a table to customize (see below)

  -- Show virtual text (inline messages)
  virtual_text = true, -- or a table to customize (see below)

  -- Underline the diagnostic'd text
  underline = true,

  -- Update diagnostics in insert mode (can be distracting for some)
  update_in_insert = false,

  -- Sort diagnostics by severity
  severity_sort = true,

  -- Configure the floating window for diagnostics (e.g., when using vim.diagnostic.open_float())
  float = {
    focusable = false, -- Whether the float window can receive focus
    style = "minimal", -- "minimal" or "border" (deprecated in favor of border option)
    border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
    source = "always", -- "always", "if_many" (show source only if multiple sources) or false
    header = "", -- Text to put at the top of the float
    prefix = "", -- Text to put before each diagnostic in the float
    -- scope = "cursor", -- "cursor", "line", "buffer" (for vim.diagnostic.open_float)
  },
}

-- Keymaps
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<C-s>", ":write<CR>")
vim.keymap.set("n", "<C-x>", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)
vim.keymap.set("n", "<C-c>", ":%y<CR>")
vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 5)
end)
vim.keymap.set("n", "<C-n>", function()
  require("oil").toggle_float()
end)

-- AutoCommands

-- See `:help vim_highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
