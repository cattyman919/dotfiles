return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "b0o/schemastore.nvim",
      { "qvalentin/helm-ls.nvim", ft = "helm" },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
          "SmiteshP/nvim-navic",
          "nvim-tree/nvim-web-devicons",
        },
        opts = {
          show_dirname = false,
          create_autocmd = false, -- prevent barbecue from updating itself automatically
        },
      },
    },
    opts = {
      servers = {
        lua_ls = {},
        basedpyright = {},
        bashls = {},
        slint_lsp = {},
        ts_ls = {},
        qmlls = {},
        cssls = {},
        ols = {},
        zls = {},
        neocmake = {},
        angularls = {},
        tailwindcss = {},
        terraformls = {},
        buf_ls = {},
        clangd = {
          cmd = { "clangd", "--background-index", "--log=verbose", "--clang-tidy", "--inlay-hints=true" },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
        yamlls = {
          filetypes = { "yaml", "yaml.docker-compose" },
          settings = {
            yaml = {
              keyOrdering = false,
              format = { enable = true },
              -- suggest = {
              --   parentSkeletonSelectedFirst = true
              -- },
              validate = true,
              schemaStore = {
                enable = false,
                url = "",
              },
            },
          },
        },
        helm_ls = {
          settings = {
            ["helm-ls"] = {
              helmLint = {
                enabled = true,
                ignoredMessages = {},
              },
              yamlls = {
                enabled = true,
                enabledForFilesGlob = "*.{yaml,yml}",
                diagnosticsLimit = 50,
                showDiagnosticsDirectly = false,
                path = "yaml-language-server", -- or something like { "node", "yaml-language-server.js" }
                initTimeoutSeconds = 3,
                config = {
                  schemas = {
                    kubernetes = "templates/**",
                  },
                  completion = true,
                  hover = true,
                  -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
                }
              }
            },
          },
        },
        -- sqlls = {},
        sqls = {},
        astro = {},
        dockerls = {},
        -- jdtls = {},
        nimls = {},
        -- nim_langserver = {},
        gopls = {
          buildFlags = { "-tags=wireinject" },
          settings = {
            gopls = {
              -- enable all types of inlay hints for gopls
              hints = {
                assignVariableTypes = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        -- bacon_ls = {
        -- 	-- Bacon export filename (default: .bacon-locations).
        -- 	locationsFile = ".bacon-locations",
        -- 	-- Try to update diagnostics every time the file is saved (default: true).
        -- 	updateOnSave = true,
        -- 	--  How many milliseconds to wait before updating diagnostics after a save (default: 1000).
        -- 	updateOnSaveWaitMillis = 350,
        -- 	-- Try to update diagnostics every time the file changes (default: true).
        -- 	updateOnChange = true,
        -- 	-- Try to validate that bacon preferences are setup correctly to work with bacon-ls (default: true).
        -- 	validateBaconPreferences = true,
        -- 	-- f no bacon preferences file is found, create a new preferences file with the bacon-ls job definition (default: true).
        -- 	createBaconPreferencesFile = true,
        -- 	-- Run bacon in background for the bacon-ls job (default: true)
        -- 	runBaconInBackground = true,
        -- 	-- Command line arguments to pass to bacon running in background (default "--headless -j bacon-ls")
        -- 	runBaconInBackgroundCommandArguments = "--headless -j bacon-ls",
        -- 	-- How many milliseconds to wait between background diagnostics check to synchronize all open files (default: 2000).
        -- 	synchronizeAllOpenFilesWaitMillis = 1500,
        -- },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = { enable = true },
              diagnostics = { enable = true },
              inlayHints = {
                typeHints = { enable = true },
                chainingHints = { enable = true },
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      if opts.servers.yamlls then
        opts.servers.yamlls.settings.yaml.schemas = require("schemastore").yaml.schemas({
          extra = {
            {
              description = "Kubernetes Resources",
              fileMatch = { "k8s/*.yaml", "kube/*.yaml" },
              name = "Kubernetes",
              url =
              "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.32.1-standalone/all.json",
            },
          },
        })
      end

      if opts.servers.phpactor then
        opts.servers.phpactor.root_dir =
            util.root_pattern(".git", "composer.json", ".phpactor.json", ".phpactor.yml")
      end

      for server, config in pairs(opts.servers) do
        if type(config) ~= "table" then
          config = {}
        end

        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
  "mfussenegger/nvim-jdtls",
  {
    "mason-org/mason.nvim",
    opts = {},
  },
}
