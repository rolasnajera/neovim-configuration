return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    -- Configure diagnostic signs (Neovim 0.11+ API)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN]  = " ",
          [vim.diagnostic.severity.HINT]  = "󰠠 ",
          [vim.diagnostic.severity.INFO]  = " ",
        },
      },
    })

    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions", noremap = true, silent = true, buffer = bufnr })
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor", noremap = true, silent = true, buffer = bufnr })
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP", noremap = true, silent = true, buffer = bufnr })

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

    -- Ensure servers are installed and set default handler
    mason_lspconfig.setup({
      ensure_installed = {
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
      },
      automatic_installation = true,
    })

    local servers = {
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

    -- Prefer setup_handlers when available; fallback for older versions
    if type(mason_lspconfig.setup_handlers) == "function" then
      mason_lspconfig.setup_handlers({
        function(server_name)
          local server_config = servers[server_name] or {}
          local final_config = vim.tbl_deep_extend("force", {
            on_attach = on_attach,
            capabilities = capabilities,
          }, server_config)
          lspconfig[server_name].setup(final_config)
        end,
      })
    else
      -- Fallback path: iterate installed servers
      for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
        local server_config = servers[server_name] or {}
        local final_config = vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, server_config)
        lspconfig[server_name].setup(final_config)
      end
    end
  end,
}
