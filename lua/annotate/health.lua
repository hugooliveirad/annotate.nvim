-- Health check for annotate.nvim

local M = {}

function M.check()
  vim.health.start("annotate.nvim")

  -- Check Neovim version
  if vim.fn.has("nvim-0.9") == 1 then
    vim.health.ok("Neovim >= 0.9")
  else
    vim.health.error("Neovim >= 0.9 required")
  end

  -- Check optional dependencies
  local ok_trouble, _ = pcall(require, "trouble")
  if ok_trouble then
    vim.health.ok("trouble.nvim installed (optional)")
  else
    vim.health.info("trouble.nvim not installed (optional, for enhanced list view)")
  end

  local ok_telescope, _ = pcall(require, "telescope")
  if ok_telescope then
    vim.health.ok("telescope.nvim installed (optional)")
  else
    vim.health.info("telescope.nvim not installed (optional, for fuzzy search)")
  end

  -- Check if plugin is loaded
  local ok_annotate, annotate = pcall(require, "annotate")
  if ok_annotate then
    vim.health.ok("annotate.nvim loaded successfully")
  else
    vim.health.error("Failed to load annotate.nvim: " .. tostring(annotate))
  end
end

return M
