return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- Configure treesitter
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site"
      })

      -- Install parsers
      require("nvim-treesitter").install({
        "json",
        "java",
        "javascript",
        "jsdoc",
        "python",
        "rust",
        "toml",
        "sql",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "xml",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "graphql",
        "git_rebase",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
      })

      -- Enable highlighting
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Enable indentation
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Enable incremental selection using Neovim's built-in functions
      vim.keymap.set({ "n", "x" }, "<C-space>", function()
        require("vim.treesitter._select").select_parent(vim.v.count1)
      end, { desc = "Expand treesitter selection" })

      vim.keymap.set("x", "<bs>", function()
        require("vim.treesitter._select").select_child(vim.v.count1)
      end, { desc = "Shrink treesitter selection" })

      -- Enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
      require("ts_context_commentstring").setup({})
    end,
  },
}
