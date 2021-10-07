local status_ok, _ = pcall(require, "lint")
if not status_ok then
   return
end

require("core.autocmds").define_augroups {
   autolint = {
      {
         "BufWritePost",
         "<buffer>",
         ":silent lua require('lint').try_lint()",
      },
      {
         "BufEnter",
         "<buffer>",
         ":silent lua require('lint').try_lint()",
      },
   },
}

if not Sv.lint_on_save then
   vim.cmd [[if exists('#autolint#BufWritePost')
	:autocmd! autolint
	endif]]
end
