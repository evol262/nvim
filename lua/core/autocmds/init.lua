local M = {}

function M.define_augroups(definitions) -- {{{1
   for group_name, definition in pairs(definitions) do
      vim.cmd("augroup " .. group_name)
      vim.cmd "autocmd!"

      for _, def in pairs(definition) do
         local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
         vim.cmd(command)
      end

      vim.cmd "augroup END"
   end
end

M.define_augroups {

   _user_autocommands = {
      { "FileType", "qf", "set nobuflisted" },
      { "BufWritePost,BufEnter", "*", "set nofoldenable foldmethod=manual foldlevelstart=99" },
      { "BufWritePre", [[*\(.md\|.MD\)\@<!]], [[:%s/\s\+$//e]] },
      { "BufRead", "*", [[call setpos(".", getpos("'\""))]] },
   },
   _general_settings = {
      {
         "TextYankPost",
         "*",
         "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
      },
      {
         "BufWinEnter",
         "*",
         "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
      },
      {
         "BufRead",
         "*",
         "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
      },
      {
         "BufNewFile",
         "*",
         "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
      },
   },
}

return M
