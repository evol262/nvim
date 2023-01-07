local M = {}

function M.search_dotfiles()
   require("telescope.builtin").find_files {
      prompt_title = "< Neovim Dotfiles >",
      cwd = "~/.config/nvim",
   }
end

-- hide line numbers , statusline in specific buffers!
function M.hideStuff()
   vim.api.nvim_exec(
      false,
      [[
   au TermOpen term://* setlocal nonumber
   au TermClose term://* bd!
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
]]
   )
end

return M
