# annotate.nvim

Code review annotations with virtual text display for Neovim.

![Neovim](https://img.shields.io/badge/Neovim-0.9+-blueviolet.svg?style=flat&logo=Neovim&logoColor=white)

## Features

- **Add annotations** to selected code ranges with visual text display
- **Drift detection** - highlights when annotated code has changed
- **Virtual text** displayed below annotated hunks with word-wrap
- **Sign column** indicators for annotated lines
- **Line highlighting** with customizable background colors
- **Trouble.nvim integration** for browsing annotations
- **Telescope picker** for fuzzy searching annotations
- **Persistence** - optionally save/load annotations to JSON
- **Import/Export** to markdown format
- **Undo/Redo** support for deletions

## Requirements

- Neovim >= 0.9

### Optional

- [trouble.nvim](https://github.com/folke/trouble.nvim) - Enhanced annotation list
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy search annotations

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "hugooliveirad/annotate.nvim",
  opts = {},
  keys = {
    { "<leader>ra", mode = "v", desc = "Add annotation" },
    { "<leader>rl", desc = "List annotations" },
    { "<leader>rs", desc = "Search annotations (Telescope)" },
    { "]r", desc = "Next annotation" },
    { "[r", desc = "Previous annotation" },
  },
  cmd = { "Annotate", "AnnotateAdd", "AnnotateList" },
}
```

## Configuration

<details>
<summary>Default configuration</summary>

```lua
{
  keymaps = {
    add = "<leader>ra",           -- Visual mode: add annotation
    list = "<leader>rl",          -- Open Trouble list
    telescope = "<leader>rs",     -- Open Telescope picker
    yank = "<leader>ry",          -- Yank all annotations to clipboard
    delete = "<leader>rd",        -- Delete annotation under cursor
    edit = "<leader>re",          -- Edit annotation under cursor
    delete_all = "<leader>rD",    -- Delete all annotations
    undo = "<leader>ru",          -- Undo last delete
    redo = "<leader>rU",          -- Redo last undo
    write = "<leader>rw",         -- Export to markdown file
    import = "<leader>ri",        -- Import from markdown file
    next_annotation = "]r",       -- Jump to next annotation
    prev_annotation = "[r",       -- Jump to previous annotation
  },
  virtual_text = {
    wrap_at = 80,                 -- Wrap long comments (0 to disable)
  },
  sign = {
    text = "",                   -- Sign column text
    hl = "DiagnosticSignInfo",    -- Sign highlight
  },
  highlights = {
    virtual_text = "Comment",
    virtual_text_drifted = "DiagnosticWarn",
    sign = "DiagnosticSignInfo",
    sign_drifted = "DiagnosticSignWarn",
    line = "AnnotateLine",        -- Line background (false to disable)
    line_drifted = "AnnotateLineDrifted",
  },
  persist = {
    enabled = false,              -- Auto-save/load annotations
    path = ".annotations.json",   -- Path relative to cwd or absolute
  },
}
```

</details>

## Usage

### Adding Annotations

1. Visual select the lines you want to annotate
2. Press `<leader>ra`
3. Type your annotation comment
4. Press `Enter` to save

### Commands

| Command | Description |
|---------|-------------|
| `:Annotate` | Open annotation list (default) |
| `:Annotate add` | Add annotation on current line |
| `:Annotate list` | Open Trouble list |
| `:Annotate telescope` | Open Telescope picker |
| `:Annotate delete` | Delete annotation under cursor |
| `:Annotate edit` | Edit annotation under cursor |
| `:Annotate yank` | Copy all annotations to clipboard |
| `:Annotate write` | Export to markdown file |
| `:Annotate import` | Import from markdown file |
| `:Annotate undo` | Undo last delete |
| `:Annotate redo` | Redo last undo |
| `:Annotate clear` | Delete all annotations |
| `:Annotate next/prev` | Jump to next/prev annotation |
| `:Annotate help` | Show help |

Shortcuts: `:AnnotateAdd`, `:AnnotateList`, `:AnnotateTelescope`, `:AnnotateDelete`, `:AnnotateEdit`

### Keymaps

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ra` | v | Add annotation to selection |
| `<leader>rl` | n | Open annotation list |
| `<leader>rs` | n | Search with Telescope |
| `<leader>ry` | n | Yank all to clipboard |
| `<leader>rd` | n | Delete under cursor |
| `<leader>re` | n | Edit under cursor |
| `<leader>rD` | n | Delete all |
| `<leader>ru` | n | Undo delete |
| `<leader>rU` | n | Redo delete |
| `<leader>rw` | n | Export to file |
| `<leader>ri` | n | Import from file |
| `]r` | n | Next annotation |
| `[r` | n | Previous annotation |

### Telescope Actions

| Key | Action |
|-----|--------|
| `<CR>` | Jump to annotation |
| `d` | Delete annotation |
| `e` | Edit annotation |
| `D` | Filter drifted only |

## Highlights

The plugin defines these highlight groups (with defaults):

| Group | Default | Description |
|-------|---------|-------------|
| `AnnotateLine` | `#3d3d00` bg | Background for annotated lines |
| `AnnotateLineDrifted` | `#4d2626` bg | Background for drifted lines |

Override in your config:

```lua
vim.api.nvim_set_hl(0, "AnnotateLine", { bg = "#2d2d00" })
vim.api.nvim_set_hl(0, "AnnotateLineDrifted", { bg = "#3d1616" })
```

## Health Check

Run `:checkhealth annotate` to verify installation.

## License

Apache-2.0
