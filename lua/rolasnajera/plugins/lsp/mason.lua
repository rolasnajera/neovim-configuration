return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- To see the complete list of lsp go to:  https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
      -- list of servers for mason to install
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
        "tsserver",
        "tailwindcss",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
      },
    })
  end,
}
