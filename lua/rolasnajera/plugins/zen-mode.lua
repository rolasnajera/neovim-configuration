return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  dependencies = { "folke/twilight.nvim" },
  opts = {
    window = {
      backdrop = 0.95,
      width = 100,
      height = 1,
      options = {
        signcolumn = "no",
        number = false,
        relativenumber = false,
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
        laststatus = 0,
      },
      twilight = { enabled = true },
      gitsigns = { enabled = false },
    },
  },
  keys = {
    { "<leader>zm", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
  },
}
