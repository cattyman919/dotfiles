pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)
require("nvim-treesitter.install").prefer_git = false
require 'nvim-treesitter.install'.compilers = { "zig","clang", "gcc" }
return {
  ensure_installed = {
    "lua",
    "luadoc",
    "printf",
    "vim",
    "vimdoc",
    "c",
    "go",
    "rust",
    "javascript",
    "json",
    "python",
    "cpp",
    "css",
  },
  auto_install = true,
  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}
