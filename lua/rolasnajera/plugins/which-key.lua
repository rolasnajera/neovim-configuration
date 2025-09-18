return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      spelling = true,
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.add({
      { "<leader>f", group = "+find" },
      { "<leader>h", group = "+git" },
      { "<leader>x", group = "+diagnostics" },
      { "<leader>e", group = "+explorer" },
      { "<leader>d", desc = "Show line diagnostics" },
      { "<leader>D", desc = "Show buffer diagnostics" },
      { "<leader>?", "<cmd>WhichKey<CR>", desc = "Show available keymaps" },
    })
  end,
}
