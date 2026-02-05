-- ftdetect/helm.lua
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/templates/*.yaml", "*/templates/*.tpl", "*.gotmpl", "helmfile.yaml" },
  callback = function()
    vim.opt_local.filetype = "helm"
  end,
})
