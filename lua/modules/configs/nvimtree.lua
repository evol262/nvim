local g = vim.g

g.nvim_tree_add_trailing = 1 -- append a trailing slash to folder names
g.nvim_tree_git_hl = 1
g.nvim_tree_gitignore = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = ":t"

g.nvim_tree_show_icons = {
   git = 1,
   folders = 1,
   files = 1,
   -- folder_arrows= 1
}
g.nvim_tree_icons = {
   default = "",
   symlink = "",
   git = {
      unstaged = "✗",
      staged = "✓",
      unmerged = "",
      renamed = "➜",
      untracked = "★",
      deleted = "",
      ignored = "◌",
   },
   folder = {
      -- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
      -- arrow_open = "",
      -- arrow_closed = "",
      default = "",
      open = "",
      empty = "", -- 
      empty_open = "",
      symlink = "",
      symlink_open = "",
   },
}

require("nvim-tree").setup {
   disable_netrw = true,
   hijack_netrw = true,
   open_on_setup = false,
   ignore_ft_on_setup = { "dashboard" },
   auto_close = false,
   open_on_tab = false,
   hijack_cursor = false,
   update_cwd = false,
   lsp_diagnostics = false,
   update_focused_file = {
      enable = false,
      update_cwd = false,
      ignore_list = {},
   },
   system_open = {
      cmd = nil,
      args = {},
   },
   view = {
      width = 30,
      side = "left",
      auto_resize = false,
      mappings = {
         custom_only = false,
         list = {},
      },
   },
}
