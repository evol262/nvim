require("nvim-tree").setup {
   disable_netrw = true,
   hijack_netrw = true,
   open_on_setup = false,
   ignore_ft_on_setup = { "dashboard" },
   open_on_tab = false,
   hijack_cursor = false,
   update_cwd = false,
   git = {
      ignore = true,
   },
   actions = {
      open_file = {
         quit_on_open = false,
      },
   },
   update_focused_file = {
      enable = false,
      update_cwd = false,
      ignore_list = {},
   },
   filters = {
      dotfiles = true,
      custom = { ".git", "node_modules", ".cache" },
   },
   renderer = {
      indent_markers = {
         enable = true,
      },
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
