local M = {}

local function buffer_keymap(bufnr)
  return function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
  end
end

function M.on_attach(client, bufnr)
  local map = buffer_keymap(bufnr)

  map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
  map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
  map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
  map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")
  map("n", "K", vim.lsp.buf.hover, "Show documentation under cursor")
  map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")

  if client.name == "svelte" then
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts" },
      callback = function(ctx)
        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
      end,
      desc = "Svelte: trigger LSP refresh when JS/TS files change",
    })
  end
end

local cached_capabilities

function M.capabilities()
  if not cached_capabilities then
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not ok then
      return vim.lsp.protocol.make_client_capabilities()
    end

    cached_capabilities = cmp_nvim_lsp.default_capabilities()
    cached_capabilities.offsetEncoding = { "utf-16" }
  end

  return cached_capabilities
end

return M
