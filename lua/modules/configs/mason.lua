local opts = {
   ui = {
      border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
      icons = {
         package_installed = "✓",
         package_pending = "➜",
         package_uninstalled = "✗",
      },
   },
   ensure_installed = {
      "black",
      "codespell",
      "gopls",
      "isort",
      "mypy",
      "shellcheck",
      "shfmt",
   },
}
require("mason").setup { opts }

local mr = require "mason-registry"
for _, tool in ipairs(opts.ensure_installed) do
   local p = mr.get_package(tool)
   if not p:is_installed() then
      p:install()
   end
end
