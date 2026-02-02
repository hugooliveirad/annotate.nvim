-- User commands for annotate.nvim

local M = {}

function M.setup()
  local api = require("annotate.api")

  -- Main command with subcommands
  vim.api.nvim_create_user_command("Annotate", function(opts)
    local subcmd = opts.fargs[1] or "list"

    if subcmd == "add" then
      local line = vim.api.nvim_win_get_cursor(0)[1]
      api.add(line, line)
    elseif subcmd == "list" or subcmd == "trouble" then
      api.open_list()
    elseif subcmd == "telescope" or subcmd == "search" then
      api.open_telescope()
    elseif subcmd == "delete" or subcmd == "del" then
      api.delete_under_cursor()
    elseif subcmd == "edit" then
      api.edit_under_cursor()
    elseif subcmd == "yank" or subcmd == "copy" then
      api.yank_all()
    elseif subcmd == "cut" then
      api.yank_and_delete_all()
    elseif subcmd == "write" or subcmd == "export" then
      api.write_to_file()
    elseif subcmd == "import" or subcmd == "load" then
      api.import_from_file()
    elseif subcmd == "undo" then
      api.undo_delete()
    elseif subcmd == "redo" then
      api.redo_delete()
    elseif subcmd == "clear" then
      api.delete_all()
    elseif subcmd == "next" then
      api.next_annotation()
    elseif subcmd == "prev" then
      api.prev_annotation()
    elseif subcmd == "help" then
      vim.notify(
        [[
Annotate commands:
  :Annotate add       - Add annotation on current line
  :Annotate list      - Open Trouble list (default)
  :Annotate telescope - Open Telescope picker
  :Annotate delete    - Delete annotation under cursor
  :Annotate edit      - Edit annotation under cursor
  :Annotate yank      - Copy all annotations to clipboard
  :Annotate cut       - Copy all annotations and delete them
  :Annotate write     - Export to markdown file
  :Annotate import    - Import from markdown file
  :Annotate undo      - Undo last delete
  :Annotate redo      - Redo last undo
  :Annotate clear     - Delete all annotations
  :Annotate next/prev - Jump to next/prev annotation
  :Annotate help      - Show this help

Visual mode: Select lines and use <leader>ra to add annotation
]],
        vim.log.levels.INFO
      )
    else
      vim.notify("Unknown subcommand: " .. subcmd .. ". Use :Annotate help", vim.log.levels.WARN)
    end
  end, {
    nargs = "?",
    complete = function()
      return {
        "add",
        "list",
        "telescope",
        "delete",
        "edit",
        "yank",
        "cut",
        "write",
        "import",
        "undo",
        "redo",
        "clear",
        "next",
        "prev",
        "help",
      }
    end,
    desc = "Annotate commands",
  })

  -- Shortcuts for common operations
  vim.api.nvim_create_user_command("AnnotateAdd", function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    api.add(line, line)
  end, { desc = "Add annotation on current line" })

  vim.api.nvim_create_user_command("AnnotateList", api.open_list, { desc = "List annotations in Trouble" })
  vim.api.nvim_create_user_command(
    "AnnotateTelescope",
    api.open_telescope,
    { desc = "Search annotations with Telescope" }
  )
  vim.api.nvim_create_user_command(
    "AnnotateDelete",
    api.delete_under_cursor,
    { desc = "Delete annotation under cursor" }
  )
  vim.api.nvim_create_user_command("AnnotateEdit", api.edit_under_cursor, { desc = "Edit annotation under cursor" })
end

return M
