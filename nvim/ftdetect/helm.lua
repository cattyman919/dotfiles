vim.api.nvim_create_autocmd({ "Filetype", "BufRead", "BufNewFile" }, {
  pattern = { "*.yaml", "*.yml", "*.tpl", "*.gotmpl", "helmfile.yaml" },
  callback = function(args)
    -- 1. Check strict filename patterns
    if args.file:match("helmfile.yaml") or args.file:match("%.gotmpl$") or args.file:match("%.tpl$") then
      vim.opt_local.filetype = "helm"
      return
    end

    -- 2. Check if file is inside a "templates" directory
    if args.file:match("/templates/") then
      vim.opt_local.filetype = "helm"
      return
    end

    -- 3. Smart Check: Look for Chart.yaml in parent directories
    local root = vim.fs.find("Chart.yaml", { path = args.file, upward = true })[1]
    if root then
      vim.opt_local.filetype = "helm"
    end
  end,
})
