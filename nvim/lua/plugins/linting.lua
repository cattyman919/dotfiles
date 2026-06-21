return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Assign qmllint to the qml filetype
    -- lint.linters_by_ft = {
    --   qml = { "qmllint" },
    -- }

    -- Inject your Quickshell and Qt6 paths into qmllint so it can resolve imports
    -- local qmllint = lint.linters.qmllint
    -- if qmllint then
    --   -- Insert custom arguments before the default ones
    --   table.insert(qmllint.args, 1, "--build-dir")
    --   table.insert(qmllint.args, 2, vim.fn.expand("~/.config/quickshell"))
    --   table.insert(qmllint.args, 3, "-I")
    --   table.insert(qmllint.args, 4, "/usr/lib/qt6/qml")
    --   table.insert(qmllint.args, 5, "--compiler-warnings=off")
    -- end

    -- Create an autocmd to trigger linting automatically
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
