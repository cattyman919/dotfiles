vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set clipboard=unnamed")

-- Remappings
vim.g.mapleader = " "

-- Escape from insert mode using jj or jk
vim.cmd("inoremap jj <Esc>")
vim.cmd("inoremap jk <Esc>")

-- Move between windows
vim.cmd("nmap <up> <C-w><up>")
vim.cmd("nmap <down> <C-w><down>")
vim.cmd("nmap <left> <C-w><left>")
vim.cmd("nmap <right> <C-w><right>")

-- Write only if something is changed
vim.cmd("noremap <leader>w :up<cr>")

-- Terminal Mapping
-- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)

-- Ignore Shada Files
-- vim.opt.shadafile = "NONE"

require("config.lazy")
