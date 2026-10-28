-- Markdown buffer settings for improved prose readability
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = ""

-- Navigate visual (wrapped) lines unless preceded by a count (e.g. 5j)
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true,
  buffer = true,
  desc = "Down visual line",
})
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true,
  buffer = true,
  desc = "Up visual line",
})
