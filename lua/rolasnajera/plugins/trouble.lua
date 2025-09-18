return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    {
      "<leader>xx",
      function()
        require("trouble").toggle("diagnostics")
      end,
      desc = "Trouble diagnostics",
    },
    {
      "<leader>xw",
      function()
        require("trouble").toggle("workspace_diagnostics")
      end,
      desc = "Trouble workspace diagnostics",
    },
    {
      "<leader>xd",
      function()
        require("trouble").toggle("document_diagnostics")
      end,
      desc = "Trouble document diagnostics",
    },
    {
      "<leader>xr",
      function()
        require("trouble").toggle("lsp_references")
      end,
      desc = "Trouble LSP references",
    },
    {
      "<leader>xq",
      function()
        require("trouble").toggle("quickfix")
      end,
      desc = "Trouble quickfix",
    },
  },
}
