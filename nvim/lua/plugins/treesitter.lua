return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local languages = {
        'rust',
        'javascript',
        'typescript',
        'zig',
        "c",
        "proto",
        "lua",
        "vim",
        "json",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "rust",
        "helm",
        "yaml",
        "xml",
        "go",
        "astro",
        "python"
      }

      require('nvim-treesitter').install {
        languages
      }

      -- vim.api.nvim_create_autocmd('FileType', {
      --   pattern = '*',
      --   callback = function(args)
      --     -- Safely attempt to start treesitter.
      --     -- If the parser for the current filetype is missing, it will silently fail instead of crashing.
      --     pcall(vim.treesitter.start, args.buf)
      --   end,
      -- })
      --
      --
      vim.api.nvim_create_autocmd('FileType', {
        pattern = languages,
        callback = function() vim.treesitter.start() end,
      })

      -- vim.api.nvim_create_autocmd('FileType', {
      --   pattern = { '<filetype>' },
      --   callback = function() vim.treesitter.start() end,
      -- })

      -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'


      -- highlight = {
      --   enable = true,
      --
      --   -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      --   -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      --   -- the name of the parser)
      --   -- list of language that will be disabled
      --   -- disable = { "c", "rust" },
      --
      --   -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      --   disable = function(lang, buf)
      --     local max_filesize = 100 * 1024 -- 100 KB
      --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      --     if ok and stats and stats.size > max_filesize then
      --       return true
      --     end
      --   end,
      --   additional_vim_regex_highlighting = false,
      -- },
    end,
  },
  -- NOTE: js,ts,jsx,tsx Auto Close Tags
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
    config = function()
      -- Independent nvim-ts-autotag setup
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,           -- Auto-close tags
          enable_rename = true,          -- Auto-rename pairs
          enable_close_on_slash = false, -- Disable auto-close on trailing `</`
        },
        per_filetype = {
          ["html"] = {
            enable_close = true, -- Disable auto-closing for HTML
          },
          ["typescriptreact"] = {
            enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
          },
        },
      })
    end,
  },
}
