return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local handlers = require("rolasnajera.lsp.handlers")

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    local capabilities = handlers.capabilities()

    local ensure_servers = {
      "ansiblels",
      "bashls",
      "clangd",
      "cssls",
      "dockerls",
      "emmet_ls",
      "eslint",
      "html",
      "jdtls",
      "jsonls",
      "lua_ls",
      "graphql",
      "prismals",
      "pyright",
      "kotlin_language_server",
      "marksman",
      "mdx_analyzer",
      "rust_analyzer",
      "sqlls",
      "ts_ls",
      "tailwindcss",
    }

    local server_overrides = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      },
      graphql = {
        filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
      },
      emmet_ls = {
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "c" },
      },
    }

    local base_config = {
      on_attach = handlers.on_attach,
      capabilities = capabilities,
    }

    for _, server in ipairs(ensure_servers) do
      local overrides = server_overrides[server] or {}
      if server ~= "rust_analyzer" then
        local config = vim.tbl_deep_extend("force", {}, base_config, overrides)
        local ok, err = pcall(vim.lsp.config, server, config)
        if not ok then
          vim.notify(string.format("lspconfig: skipping %s (%s)", server, err), vim.log.levels.WARN)
        end
      end
    end

    mason_lspconfig.setup({
      ensure_installed = ensure_servers,
      automatic_enable = {
        exclude = { "stylua" }, -- stylua CLI lacks --lsp; avoid auto-enabling its pseudo-LSP
      },
    })
  end,
}
