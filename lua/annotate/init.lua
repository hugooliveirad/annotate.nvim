-- annotate.nvim - Code review annotations with virtual text display
-- https://github.com/hugooliveirad/annotate.nvim

---@class annotate
local M = {}

---@param opts? annotate.Config
function M.setup(opts)
  require("annotate.config").setup(opts)
  require("annotate.core").init()
  require("annotate.commands").setup()
  require("annotate.autocmds").setup()
end

-- Proxy to API functions via metatable
return setmetatable(M, {
  __index = function(_, k)
    return require("annotate.api")[k]
  end,
})
