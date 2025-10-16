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
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

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

    local function map(mode, lhs, rhs, desc, bufnr)
      keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
    end

    local on_attach = function(client, bufnr)
      map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references", bufnr)
      map("n", "gD", vim.lsp.buf.declaration, "Go to declaration", bufnr)
      map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions", bufnr)
      map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations", bufnr)
      map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions", bufnr)
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions", bufnr)
      map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename", bufnr)
      map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic", bufnr)
      map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic", bufnr)
      map("n", "K", vim.lsp.buf.hover, "Show documentation under cursor", bufnr)
      map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP", bufnr)

      if client.name == "svelte" then
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
          end,
        })
      end
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()
    capabilities.offsetEncoding = { "utf-16" }

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
      on_attach = on_attach,
      capabilities = capabilities,
    }

    for _, server in ipairs(ensure_servers) do
      local overrides = server_overrides[server] or {}
      local config = vim.tbl_deep_extend("force", {}, base_config, overrides)
      local ok, err = pcall(vim.lsp.config, server, config)
      if not ok then
        vim.notify(string.format("lspconfig: skipping %s (%s)", server, err), vim.log.levels.WARN)
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
