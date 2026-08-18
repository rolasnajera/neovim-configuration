local M = {}

local sensitive_patterns = {
  "%.env$",
  "%.env%..*",
  "%.key$",
  "%.pem$",
  "id_rsa",
  "credentials",
  "secret",
}

local function is_sensitive(bufname)
  if not bufname or bufname == "" then
    return false
  end
  local lower_name = bufname:lower()
  for _, pattern in ipairs(sensitive_patterns) do
    if string.find(lower_name, pattern) then
      return true
    end
  end
  return false
end

function M.setup()
  local group = vim.api.nvim_create_augroup("SecureClipboard", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufNewFile" }, {
    group = group,
    pattern = "*",
    callback = function(args)
      local bufnr = args.buf
      local bufname = vim.api.nvim_buf_get_name(bufnr)

      if is_sensitive(bufname) then
        -- Disable global system clipboard
        vim.opt.clipboard = ""

        -- Map clipboard keys to local registers inside this buffer
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set({ "n", "v" }, "<leader>y", "y", vim.tbl_extend("force", opts, { desc = "Copy to local register (Secure)" }))
        vim.keymap.set("n", "<leader>Y", "Y", vim.tbl_extend("force", opts, { desc = "Copy line to local register (Secure)" }))
        vim.keymap.set({ "n", "v" }, "<leader>p", "p", vim.tbl_extend("force", opts, { desc = "Paste from local register (Secure)" }))
        vim.keymap.set({ "n", "v" }, "<leader>P", "P", vim.tbl_extend("force", opts, { desc = "Paste from local register (Secure) (before)" }))

        -- Visual feedback (notified once per buffer)
        if not vim.b[bufnr].secure_clipboard_notified then
          vim.notify("🔒 Secure buffer: System clipboard integrations are disabled.", vim.log.levels.WARN, {
            title = "Security Alert",
          })
          vim.b[bufnr].secure_clipboard_notified = true
        end
      else
        -- Restore system clipboard globally
        vim.opt.clipboard = "unnamedplus"
      end
    end,
  })
end

return M
