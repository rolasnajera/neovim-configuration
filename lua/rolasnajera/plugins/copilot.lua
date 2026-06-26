
return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  keys = {
    { "<leader>gd", "<cmd>Copilot disable<CR>", desc = "Disable Copilot" },
    { "<leader>ge", "<cmd>Copilot enable<CR>", desc = "Enable Copilot" },
  },
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<cr>",
          refresh = "gr",
          open = "<C-c>p",
        },
        layout = {
          position = "bottom", -- | "right"
          ratio = 0.4,
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitconfig = false,
        hgcommit = false,
        svncommit = false,
        cvs = false,
        ["."] = false,
        python = true,
        lua = true,
        rust = true,
        javascript = true,
        typescript = true,
        typescriptreact = true,
        javascriptreact = true,
        css = true,
        html = true,
        sh = function()
          local name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
          if string.match(name, "^%.env") or string.match(name, "^%.dev%.vars") then
            return false
          end
          return true
        end,
        bash = function()
          local name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
          if string.match(name, "^%.env") or string.match(name, "^%.dev%.vars") then
            return false
          end
          return true
        end,
        go = true,
        c = true,
        cpp = true,
        java = true,
        kotlin = true,
        sql = true,
        ["*"] = false, -- disable all other filetypes by default
      },
    })

    -- Disable Copilot by default on startup/lazy-load
    vim.cmd("Copilot disable")
  end,
}
