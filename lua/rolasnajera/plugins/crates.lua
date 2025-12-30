return {
  "saecki/crates.nvim",
  ft = { "toml" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local crates = require("crates")

    crates.setup({
      completion = {
        cmp = {
          enabled = true,
        },
      },
      null_ls = {
        enabled = false,
      },
    })

    local group = vim.api.nvim_create_augroup("rolasnajera_crates", { clear = true })

    vim.api.nvim_create_autocmd("BufEnter", {
      group = group,
      pattern = "Cargo.toml",
      callback = function(ctx)
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = ctx.buf, desc = desc })
        end

        map("<leader>cv", crates.show_versions_popup, "Crates: show versions")
        map("<leader>cd", crates.show_dependencies_popup, "Crates: show dependencies")
        map("<leader>cu", crates.update_crate, "Crates: update crate")
        map("<leader>cU", crates.upgrade_crate, "Crates: upgrade crate")
        map("<leader>ca", crates.update_all_crates, "Crates: update all")
      end,
    })
  end,
}
