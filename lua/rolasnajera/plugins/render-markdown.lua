return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    file_types = { "markdown" },
  },
  keys = {
    { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown rendering" },
  },
}
