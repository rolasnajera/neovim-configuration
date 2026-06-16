return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Install parsers
    local parsers = {
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
    }
    require("nvim-treesitter").install(parsers)

    -- Enable treesitter highlighting and indent for supported filetypes
    local filetypes = {
      "json",
      "java",
      "javascript",
      "jsdoc",
      "python",
      "rust",
      "toml",
      "sql",
      "typescript",
      "typescriptreact",
      "yaml",
      "html",
      "xml",
      "css",
      "prisma",
      "markdown",
      "graphql",
      "gitrebase",
      "bash",
      "sh",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
    }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
