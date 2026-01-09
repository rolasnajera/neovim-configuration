
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
        yaml = true,
        markdown = true,
        gitcommit = true,
        python = true,
        lua = true,
        ["*"] = true, -- allow all others
      },
    })
  end,
}
