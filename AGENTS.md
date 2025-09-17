# Repository Guidelines

## Project Structure & Module Organization
`init.lua` is the entry point and delegates to modules under `lua/rolasnajera`. The `core/` folder pins editor options and keymaps, while `lazy.lua` bootstraps lazy.nvim and loads plugin specs from `plugins/`. Each feature owns a dedicated file such as `plugins/telescope.lua` or `plugins/lsp/mason.lua`. Language-specific overrides live in `ftplugin/`, and long-form docs or assets belong in `docs/`. Keep `lazy-lock.json` current when adding or upgrading plugins.

## Build, Test, and Development Commands
This project has no external build step—launch Neovim directly. Run `nvim --headless "+Lazy! sync" +qa` after editing plugin specs to verify dependency resolution and update the lockfile. Use `nvim --headless "+Lazy! check" +qa` for a quick validation pass. Inside Neovim, `:Lazy sync`, `:Lazy restore`, and `:Lazy clean` manage plugin lifecycles; `:Mason` handles tool updates; `:TSUpdate` refreshes Treesitter parsers.

## Coding Style & Naming Conventions
Use 2-space indentation for Lua files and align table entries for readability. Modules and filenames follow `lower_snake_case` and should mirror their directory (`core`, `plugins`, `ftplugin`). Prefer returning explicit tables for plugin specs and call Lua APIs instead of embedding Vimscript. Keep keymap identifiers descriptive, and add succinct comments for non-obvious settings as in `core/options.lua`. Format with `stylua` (recommended) before committing.

## Testing Guidelines
Smoke-test headlessly with `nvim --headless "+checkhealth lazy" +qa` to confirm plugin health. Open a full Neovim session to exercise critical flows: `:Telescope find_files`, LSP hover/formatting, bufferline navigation, and nvim-tree toggles. Place language experiments in `ftplugin/<lang>.lua` and document manual verification steps in `docs/README.md` when relevant.

## Commit & Pull Request Guidelines
Match the concise, action-oriented commit style already in history (`configuring autopairs and readme`, `fixing java lsp configuration`). Scope prefixes like `core:` or `plugins:` help reviewers when multiple areas change. Pull requests should describe the user-facing impact, call out touched modules, note plugin version updates, and attach screenshots or recordings for UI tweaks. Link related issues or TODOs and record the headless health check result in the PR body.

## Security & Configuration Tips
Avoid committing personal API tokens or machine-specific paths; prefer `vim.fn.getenv` to read secrets at runtime. Update `lazy-lock.json` alongside plugin upgrades to keep installs deterministic. Store screenshots or supporting media under `docs/` and scrub sensitive workstation details before sharing.
