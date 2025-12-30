return {
  "mrcjkb/rustaceanvim",
  version = "^4",
  ft = { "rust" },
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  init = function()
    local handlers = require("rolasnajera.lsp.handlers")

    local function map_rust(bufnr, lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    local function rust_on_attach(client, bufnr)
      handlers.on_attach(client, bufnr)

      map_rust(bufnr, "<leader>rr", "<cmd>RustLsp runnables<CR>", "Rust: runnables")
      map_rust(bufnr, "<leader>rD", "<cmd>RustLsp debuggables<CR>", "Rust: debuggables")
      map_rust(bufnr, "<leader>re", "<cmd>RustLsp expandMacro<CR>", "Rust: expand macro")
      map_rust(bufnr, "<leader>rh", "<cmd>RustLsp hover actions<CR>", "Rust: hover actions")
    end

    local rustacean_config = {
      tools = {
        hover_actions = {
          auto_focus = false,
        },
        inlay_hints = {
          auto = true,
          highlight = "NonText",
        },
      },
      server = {
        on_attach = rust_on_attach,
        capabilities = handlers.capabilities(),
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
            check = {
              command = "clippy",
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      dap = {
        adapter = false,
      },
    }

    vim.g.rustaceanvim = rustacean_config
  end,
}
