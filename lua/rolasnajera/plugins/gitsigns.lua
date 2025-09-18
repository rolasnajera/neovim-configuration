return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    current_line_blame = false,
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map("n", "]h", gitsigns.next_hunk, "Next git hunk")
      map("n", "[h", gitsigns.prev_hunk, "Previous git hunk")
      map({ "n", "v" }, "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk")
      map({ "n", "v" }, "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk")
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo stage hunk")
      map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
      map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
      map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, "Blame line details")
      map("n", "<leader>hB", gitsigns.toggle_current_line_blame, "Toggle inline blame")
      map("n", "<leader>hd", gitsigns.diffthis, "Diff against index")
      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, "Diff against last commit")
      map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select git hunk")
    end,
  },
}
