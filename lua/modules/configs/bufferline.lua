local M = {}

local colors = {
   white = "#abb2bf",
   black = "#1e222a", --  nvim bg
   black2 = "#252931",
   grey_fg = "#565c64",
   light_grey = "#6f737b",
   red = "#d47d85",
   green = "#A3BE8C",
   lightbg = "#2d3139",
   lightbg2 = "#262a32",
}

local bufferline
if not pcall(function()
   bufferline = require "bufferline"
end) then
   return
end

M.config = function()
   bufferline.setup {
      options = {
         offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
         buffer_close_icon = "",
         modified_icon = "",
         close_icon = "",
         left_trunc_marker = "",
         right_trunc_marker = "",
         diagnostics = "nvim_lsp",
         max_name_length = 14,
         max_prefix_length = 13,
         tab_size = 20,
         show_tab_indicators = true,
         enforce_regular_tabs = false,
         view = "multiwindow",
         show_buffer_close_icons = true,
         separator_style = "thin",
         always_show_bufferline = true,
      },
      highlights = {
         fill = {
            fg = colors.grey_fg,
         },
         -- buffers
         buffer_visible = {
            fg = colors.light_grey,
         },
         buffer_selected = {
            fg = colors.white,
            gui = "bold",
         },
         -- tabs
         tab = {
            fg = colors.light_grey,
         },
         tab_selected = {
            fg = colors.black2,
         },
         tab_close = {
            fg = colors.red,
         },
         indicator_selected = {
            fg = colors.black,
         },
         -- separators
         separator = {
            fg = colors.black2,
         },
         separator_visible = {
            fg = colors.black2,
         },
         separator_selected = {
            fg = colors.black2,
         },
         -- modified
         modified = {
            fg = colors.red,
         },
         modified_visible = {
            fg = colors.red,
         },
         modified_selected = {
            fg = colors.green,
         },
         -- close buttons

         close_button = {
            fg = colors.light_grey,
         },
         close_button_visible = {
            fg = colors.light_grey,
         },
         close_button_selected = {
            fg = colors.red,
         },
      },
   }
end

return M
