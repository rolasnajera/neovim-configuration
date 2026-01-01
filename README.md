# Neovim Config – rolasnajera

Opinionated, fast Neovim setup powered by lazy.nvim. Includes LSP, Treesitter, Telescope, statusline, completion, formatting/linting, and handy keymaps.

<p align="left">
  <a href="https://neovim.io/">
    <img alt="Neovim" src="https://img.shields.io/badge/Neovim-0.11%2B-57A143?logo=neovim&logoColor=white" />
  </a>
  <img alt="OS" src="https://img.shields.io/badge/macOS-Tahoe-blue?logo=apple&logoColor=white" />
  <a href="#license">
    <img alt="License" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
  <a href="https://github.com/folke/lazy.nvim">
    <img alt="lazy.nvim" src="https://img.shields.io/badge/Plugin%20Manager-lazy.nvim-orange" />
  </a>
  <a href="https://github.com/rolasnajera/neovim-configuration">
    <img alt="GitHub" src="https://img.shields.io/badge/GitHub-rolasnajera%2Fneovim--configuration-black?logo=github" />
  </a>
</p>

- OS: macOS
- Neovim: 0.11+ recommended
- Plugin manager: lazy.nvim
- Colorscheme: tokyonight (storm variant)

## Table of contents
- Overview
- Requirements
- Install
- Update
- Project structure
- Screenshot
- Bootstrap (one‑liner)
- Plugins
- GitHub Copilot
- Keymaps
- LSP and tools
- Treesitter
- Formatting and linting
- UI/UX niceties
- Getting started
- Tips and troubleshooting
- Contributing
- Credits
- License

## Overview
This is my personal Neovim configuration. It uses lazy.nvim to declaratively manage plugins and provides a productive out-of-the-box editing experience for web, scripting, and general-purpose development.

## Requirements
- Neovim 0.11 or newer
- Git
- A Nerd Font (for icons). Example: install Meslo Nerd Font
- True color terminal (e.g., iTerm2) with termguicolors enabled

## Install
Clone this repository into your Neovim config directory.

- Linux/macOS: ~/.config/nvim

On first launch, lazy.nvim will bootstrap itself and install plugins.

Useful commands:
- :Lazy – plugin UI
- :checkhealth lazy – health info

## Update
- :Lazy sync – install/update/remove plugins
- :Lazy clean – remove unused plugins
- :TSUpdate – update Treesitter parsers

## Project structure
- init.lua – entrypoint that loads core and plugin setup
- lua/rolasnajera/core
  - options.lua – editor options
  - keymaps.lua – general keybindings
  - init.lua – requires the above
- lua/rolasnajera/lazy.lua – lazy.nvim bootstrap and specs import
- lua/rolasnajera/plugins – plugin specs and configs
  - lsp/ – LSP, Mason, and tooling configuration
  - other feature-specific files (telescope.lua, bufferline.lua, etc.)
- lazy-lock.json – locked plugin versions for reproducibility

## Screenshot
Add your own screenshot or GIF to docs/ and update the path below. Example:

![Neovim UI](docs/screenshot.png)

## Bootstrap (one‑liner)
Pick one that matches your setup.

- Fresh install into default path:
  git clone https://github.com/rolasnajera/neovim-configuration.git ~/.config/nvim

- Using a dotfiles repo with a different path (symlink):
  ln -sfn /path/to/this/repo ~/.config/nvim

- Backup existing config first:
  mv ~/.config/nvim ~/.config/nvim.bak

## Plugins
Managed with lazy.nvim. Highlights include:

Core/dev experience
- nvim-lua/plenary.nvim – Lua utilities
- folke/lazy.nvim – plugin manager

Discoverability
- folke/which-key.nvim – pop-up hints for leader mappings

Navigation and search
- nvim-telescope/telescope.nvim (+ telescope-fzf-native) – fuzzy find files, grep, etc.
- debugloop/telescope-undo.nvim – undo history presented in Telescope
- ThePrimeagen/harpoon (harpoon2) – quick file lists and jumps

Editing
- hrsh7th/nvim-cmp (+ cmp-buffer, cmp-path, LuaSnip, cmp_luasnip, friendly-snippets, lspkind.nvim) – autocompletion
- windwp/nvim-autopairs – auto pairs with cmp integration
- numToStr/Comment.nvim (+ ts-context-commentstring) – smarter comments
- lukas-reineke/indent-blankline.nvim (ibl) – tree-style indent guides

UI
- folke/tokyonight.nvim – default colorscheme (storm)
- nvim-lualine/lualine.nvim – statusline with lazy update indicator
- akinsho/bufferline.nvim – tab-like buffers
- stevearc/dressing.nvim – improved input/select UI
- nvim-tree/nvim-web-devicons – file icons

File tree
- nvim-neo-tree/neo-tree.nvim – source-aware file explorer

Git
- lewis6991/gitsigns.nvim – git hunk signs, staging, and blame helpers

Diagnostics
- folke/trouble.nvim – diagnostics, references, and quickfix viewer
- folke/todo-comments.nvim – highlight and list TODO/FIX/FIXME comments

Rust development
- mrcjkb/rustaceanvim – rust-analyzer integration with enhanced features
- rust-lang/rust.vim – Rust file detection and syntax
- saecki/crates.nvim – Cargo.toml dependency management and completion

LSP and tools
- williamboman/mason.nvim – tool installer
- williamboman/mason-lspconfig.nvim – LSP integration
- neovim/nvim-lspconfig – LSP client configs
- nvimtools/none-ls.nvim – formatters/linters via null-ls (install tools with Mason)

See lazy-lock.json for pinned versions.

## GitHub Copilot
This config includes AI code suggestions via `zbirenbaum/copilot.lua`.

- Load behavior: enabled on first Insert mode entry (`event = "InsertEnter"`).
- Suggestions: auto-triggered while typing. Press `Ctrl-l` to accept the current inline suggestion.
- Panel: open with `Ctrl-c` then `p` to view multiple suggestions and history.
  - Navigate: `[[` (prev) / `]]` (next)
  - Accept: `Enter`
  - Refresh: `gr`
- Filetypes: enabled globally with explicit entries for yaml, markdown, gitcommit, python, and lua. To disable for a filetype, edit `lua/rolasnajera/plugins/copilot.lua` and set `filetypes["<type>"] = false`.

Notes
- Requires an active GitHub Copilot subscription on your account.
- If suggestions don’t appear, open `:Lazy` to confirm the plugin is installed and check for any startup errors.

## Keymaps
Leader key: Space

General
- <leader>nh – clear search highlights
- <leader>+ / <leader>- – increment/decrement number
- Window splits: <leader>sv (vertical), <leader>sh (horizontal), <leader>se (equalize), <leader>sx (close)
- Tabs: <leader>to (new), <leader>tx (close), <leader>tn (next), <leader>tp (prev), <leader>tf (current buffer -> new tab)

Which-key
- <leader>? – show available keymaps

Telescope
- <leader>ff – find files
- <leader>fr – recent files
- <leader>fs – live grep in cwd
- <leader>fc – grep string under cursor
- <leader>fu – undo history

Harpoon
- <leader>a – add file
- Ctrl-e – toggle quick menu
- <leader>hm / Ctrl-t / Ctrl-n / Ctrl-s – jump to items 1..4
- <leader>hp / <leader>hn – previous/next

File explorer (Neo-tree)
- <leader>ee – toggle file tree
- <leader>ef – reveal current file

Git (gitsigns)
- ]h / [h – next/previous hunk
- <leader>hs / <leader>hr – stage or reset hunk (visual mode supported)
- <leader>hS / <leader>hR – stage or reset buffer
- <leader>hu – undo stage
- <leader>hv – preview hunk
- <leader>hb – show detailed blame for line
- <leader>hB – toggle inline blame
- <leader>hd / <leader>hD – diff against index or HEAD~
- ih – select hunk text object (operator-pending/visual)

Diagnostics (Trouble)
- <leader>xx – toggle diagnostics list
- <leader>xw – workspace diagnostics
- <leader>xd – document diagnostics
- <leader>xr – LSP references
- <leader>xq – quickfix list

Todo comments
- ]t / [t – next/previous TODO comment
- <leader>xt – TODO items in Trouble
- <leader>xT – TODO items in Telescope

LSP (set on attach)
- gR – references (Telescope)
- gD – declaration
- gd – definitions (Telescope)
- gi – implementations (Telescope)
- gt – type definitions (Telescope)
- <leader>ca – code action
- <leader>rn – rename
- <leader>D – buffer diagnostics (Telescope)
- <leader>d – line diagnostics
- [d / ]d – prev/next diagnostic
- K – hover
- <leader>rs – restart LSP

Rust-specific (rustaceanvim)
- <leader>rr – show runnables
- <leader>rD – show debuggables
- <leader>re – expand macro
- <leader>rh – hover actions

Cargo.toml (crates.nvim)
- <leader>cv – show crate versions
- <leader>cd – show dependencies
- <leader>cu – update crate under cursor
- <leader>cU – upgrade crate under cursor
- <leader>ca – update all crates

## LSP and tools
Mason installs and manages language servers. Configured servers include:
- ansiblels, bashls, clangd, cssls, dockerls, emmet_ls, eslint, html, jdtls, jsonls, lua_ls, graphql, prismals, pyright, kotlin_language_server, marksman, mdx_analyzer, sqlls, ts_ls, tailwindcss

Rust support:
- rust-analyzer via rustaceanvim (version ^4) with clippy checks, inlay hints, and cargo integration
- Cargo.toml completion and management via crates.nvim

Capabilities are extended via nvim-cmp; custom per-server settings include:
- lua_ls – recognizes vim globals and adds runtime libraries
- graphql – adds additional filetypes (svelte, react, etc.)
- emmet_ls – configured for common web filetypes
- rust-analyzer – clippy as default checker, all cargo features enabled, call snippet completion

## Treesitter
Parsers ensured for: json, java, javascript, jsdoc, python, rust, toml, sql, typescript, tsx, yaml, html, xml, css, prisma, markdown, markdown_inline, graphql, git_rebase, bash, lua, vim, dockerfile, gitignore, query

Features:
- Syntax highlight and indentation
- Incremental selection (<C-space>, <bs>)
- Autotag for HTML/TSX

## Formatting and linting (null-ls/none-ls)
Install formatters/linters via :Mason and configure them through none-ls:
- Formatters: prettier (incl. svelte), stylua, isort, black
- Linters: eslint_d (auto-activated if .eslintrc.{js,cjs} is present), pylint

Format on save: enabled via null-ls for buffers whose attached client supports formatting (prefers null-ls over LSP server formatting).

## UI/UX niceties
- Tokyonight (storm) loads by default; override with :colorscheme if desired (termguicolors enabled)
- Lualine: custom theme with Lazy update indicator
- Bufferline: tabs mode with slant separators
- Dressing: improved prompts/selects

## Getting started
1) Launch Neovim to bootstrap plugins:
   nvim
2) Open Mason to verify tools and LSP servers:
   :Mason
3) Optionally install extra servers (examples):
   :MasonInstall tsserver eslint lua-language-server pyright jdtls
4) Update Treesitter parsers:
   :TSUpdate
5) Verify LSP status for a filetype (open a file, then):
   :LspInfo
6) Try Telescope:
   <leader>ff, <leader>fs

Notes
- ESLint linter via eslint_d activates only if .eslintrc.js or .eslintrc.cjs exists at project root.
- Formatting on save is handled by none-ls (null-ls). To temporarily format manually:
  :lua vim.lsp.buf.format()

## Tips and troubleshooting
- If icons don’t render, install a Nerd Font and configure your terminal to use it.
- If Treesitter highlighting looks off, run :TSUpdate.
- If LSP doesn’t start, check :Mason to confirm the server is installed and :LspInfo for status.
- For plugin issues, open :Lazy and check the “Health” tab or run :checkhealth.

## Contributing
- Review the [Repository Guidelines](AGENTS.md) for structure, commands, and review expectations
- Fork and create a feature branch
- Keep changes small and focused (one plugin/feature per PR when possible)
- Follow existing Lua style and patterns in lua/rolasnajera/
- Test locally (startup without errors, keymaps work, LSP/formatters load)
- Open a PR with a clear description and screenshots if UI-related

## Credits
- lazy.nvim by folke
- telescope by nvim-telescope
- lspconfig, mason by neovim/williamboman
- null-ls/none-ls by nvimtools
- And many others listed above

## License
Personal configuration. Use at your own discretion. If you copy large parts, consider crediting or forking this repository.
