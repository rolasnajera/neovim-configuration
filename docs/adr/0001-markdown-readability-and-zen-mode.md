# 1. Markdown Readability, In-Buffer Rendering, and Zen Focus Mode

Date: 2026-10-28

## Status

Accepted

## Context

When editing and reading prose, documentation, notes, and specifications in Markdown format within Neovim:
1. **Unwrapped Long Lines / Horizontal Overflow**: Neovim default buffer settings do not soft-wrap lines, causing prose lines that exceed screen width to overflow horizontally. This forces horizontal scrolling (`sidescroll`) and awkward cursor movements just to read continuous text.
2. **Ultra-Wide Monitor Eye Fatigue**: On high-resolution, ultrawide, or multi-window displays, text stretched across the entire viewport width requires extensive horizontal saccadic eye movements. The optimal typographical reading line length is widely recognized as 65–100 characters per line.
3. **Markdown Syntax Noise**: Markdown source formatting (`#`, `**`, `[label](url)`, `|---|` tables, `- [ ]` checklist syntax) introduces visual clutter when reading documentation.

## Decision

We introduced a three-tier architecture to optimize Markdown readability:

1. **Buffer-Level Filetype Overrides (`after/ftplugin/markdown.lua`)**:
   - `wrap = true`: Soft-wraps long lines to fit the current viewport.
   - `linebreak = true`: Breaks lines cleanly at whole words rather than splitting characters.
   - `breakindent = true`: Preserves list and blockquote indentation levels across wrapped lines.
   - `conceallevel = 2`: Conceals raw markup syntax while preserving formatting visuals.
   - `concealcursor = ""`: Automatically reveals underlying raw markup tags on the active line in all modes for effortless editing.
   - Mapped `j` and `k` to visual line navigation (`gj` / `gk`) when `v:count == 0`, ensuring natural vertical movement across soft-wrapped lines while preserving jump motions like `10j`.

2. **In-Buffer Markdown Rendering (`MeanderingProgrammer/render-markdown.nvim`)**:
   - Uses Treesitter and extmarks to visually render headings with icons/colors, format callouts/alerts (`> [!NOTE]`, `> [!WARNING]`), render interactive checkboxes, style code block banners, and format Markdown tables with clean box-drawing glyphs.
   - Does not alter the underlying buffer content.
   - Keymap: `<leader>mr` toggles rendering on/off.

3. **Distraction-Free Centered Layout (`folke/zen-mode.nvim` and `folke/twilight.nvim`)**:
   - `zen-mode.nvim` constrains viewport width to a comfortable 100 columns and centers the buffer on the display, eliminating horizontal neck and eye strain on ultra-wide monitors.
   - `twilight.nvim` softly dims inactive paragraphs and text blocks outside the cursor focus.
   - Keymaps: `<leader>zm` toggles Zen Mode; `<leader>tw` toggles Twilight.

## Consequences

### Positive
- Markdown files are immediately readable without horizontal scrolling or manual cursor navigation.
- Preserves indentation and word integrity for nested lists and task items.
- Ultrawide screen reading is centered and comfortable at 100 characters max width.
- Markdown documents look styled and published directly in the terminal buffer.
- Motion commands (`j`/`k`) remain intuitive on wrapped lines without breaking count jumps.

### Neutral / Trade-offs
- `conceallevel = 2` hides raw formatting tags until editing, which is mitigated by `concealcursor = ""` exposing the exact syntax under the cursor.
- Adds two lightweight UI dependencies (`render-markdown.nvim` and `zen-mode.nvim` / `twilight.nvim`), lazy-loaded on filetype and keymaps.
