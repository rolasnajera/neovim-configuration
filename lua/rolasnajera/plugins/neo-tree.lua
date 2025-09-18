return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>ee",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "Toggle Neo-tree",
    },
    {
      "<leader>ef",
      function()
        require("neo-tree.command").execute({ reveal = true })
      end,
      desc = "Reveal file in Neo-tree",
    },
  },
  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      width = 32,
    },
  },
}
