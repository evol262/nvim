-- ~/.config/nvim/lua/plugins/feline/colors.lua
-- One-dark colors

local lsp = require "feline.providers.lsp"
local vi_mode_utils = require "feline.providers.vi_mode"
local diagnostic = vim.diagnostic

local colors = {
   bg = "#282c34",
   fg = "#abb2bf",
   yellow = "#e0af68",
   cyan = "#56b6c2",
   darkblue = "#081633",
   green = "#98c379",
   orange = "#d19a66",
   violet = "#a9a1e1",
   magenta = "#c678dd",
   blue = "#61afef",
   red = "#e86671",
}

local vi_mode_colors = {
   NORMAL = colors.green,
   INSERT = colors.blue,
   VISUAL = colors.violet,
   OP = colors.green,
   BLOCK = colors.blue,
   REPLACE = colors.red,
   ["V-REPLACE"] = colors.red,
   ENTER = colors.cyan,
   MORE = colors.cyan,
   SELECT = colors.orange,
   COMMAND = colors.magenta,
   SHELL = colors.green,
   TERM = colors.blue,
   NONE = colors.yellow,
}

local vi_mode_text = {
   n = "NORMAL",
   i = "INSERT",
   v = "VISUAL",
   [""] = "V-BLOCK",
   V = "V-LINE",
   c = "COMMAND",
   no = "UNKNOWN",
   s = "UNKNOWN",
   S = "UNKNOWN",
   ic = "UNKNOWN",
   R = "REPLACE",
   Rv = "UNKNOWN",
   cv = "UNKWON",
   ce = "UNKNOWN",
   r = "REPLACE",
   rm = "UNKNOWN",
   t = "INSERT",
}

local function file_osinfo()
   local os = vim.bo.fileformat:upper()
   local icon
   if os == "UNIX" then
      icon = " "
   elseif os == "MAC" then
      icon = " "
   else
      icon = " "
   end
   return icon .. os
end

local lsp_get_diag = function(severity)
   return vim.tbl_count(diagnostic.get(0, severity and { severity = severity }))
end

-- LuaFormatter off

local comps = {
   vi_mode = {
      left = {
         provider = function()
            return "  " .. vi_mode_text[vim.fn.mode()] .. " "
         end,
         hl = function()
            local val = {
               name = vi_mode_utils.get_mode_highlight_name(),
               bg = colors.bg,
               fg = vi_mode_utils.get_mode_color(),
               style = "bold",
            }
            return val
         end,
         right_sep = " ",
      },
      right = {
         -- provider = '▊',
         provider = "",
         hl = function()
            local val = {
               name = vi_mode_utils.get_mode_highlight_name(),
               bg = vi_mode_utils.get_mode_color(),
            }
            return val
         end,
         left_sep = " ",
         right_sep = " ",
      },
   },
   file = {
      info = {
         provider = "file_info",
         file_modified_icon = "",
         hl = {
            fg = colors.darkblue,
            bg = colors.blue,
            style = "bold",
         },
         left_sep = {
            { str = " ", hl = { fg = colors.blue, style = "bold" } },
            "",
         },
         right_sep = { "", " " },
      },
      encoding = {
         provider = "file_encoding",
         left_sep = " ",
         hl = {
            fg = colors.violet,
            style = "bold",
         },
      },
      type = {
         provider = "file_type",
      },
      os = {
         provider = file_osinfo,
         left_sep = " ",
         hl = {
            fg = colors.violet,
            style = "bold",
         },
      },
      position = {
         provider = "position",
         hl = {
            fg = colors.cyan,
            -- style = 'bold'
         },
         left_sep = {
            " ",
            "slant_left_thin",
            { str = " ", hl = { fg = colors.blue } },
         },
         right_sep = { "slant_right_thin", " " },
      },
   },
   left_end = {
      provider = function()
         return ""
      end,
      hl = {
         fg = colors.bg,
         bg = colors.blue,
      },
   },
   line_percentage = {
      provider = "line_percentage",
      left_sep = " ",
      hl = {
         style = "bold",
      },
   },
   scroll_bar = {
      provider = "scroll_bar",
      left_sep = " ",
      hl = {
         fg = colors.blue,
         style = "bold",
      },
   },
   diagnos = {
      err = {
         -- provider = 'diagnostic_errors',
         provider = function()
            return "" .. lsp_get_diag(vim.diagnostic.severity.ERROR)
         end,
         -- left_sep = ' ',
         enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
         end,
         hl = {
            fg = colors.red,
         },
      },
      warn = {
         -- provider = 'diagnostic_warnings',
         provider = function()
            return "" .. lsp_get_diag(vim.diagnostic.severity.WARN)
         end,
         -- left_sep = ' ',
         enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
         end,
         hl = {
            fg = colors.yellow,
         },
      },
      info = {
         -- provider = 'diagnostic_info',
         provider = function()
            return "" .. lsp_get_diag(vim.diagnostic.severity.INFO)
         end,
         -- left_sep = ' ',
         enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
         end,
         hl = {
            fg = colors.blue,
         },
      },
      hint = {
         -- provider = 'diagnostic_hints',
         provider = function()
            return "" .. lsp_get_diag(vim.diagnostic.severity.HINT)
         end,
         -- left_sep = ' ',
         enabled = function()
            return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
         end,
         hl = {
            fg = colors.cyan,
         },
      },
   },
   lsp = {
      name = {
         provider = "lsp_client_names",
         -- left_sep = ' ',
         right_sep = " ",
         icon = "  ",
         hl = {
            fg = colors.yellow,
         },
      },
   },
   git = {
      branch = {
         provider = "git_branch",
         icon = " ",
         left_sep = " ",
         hl = {
            fg = colors.violet,
            style = "bold",
         },
      },
      add = {
         provider = "git_diff_added",
         hl = {
            fg = colors.green,
         },
      },
      change = {
         provider = "git_diff_changed",
         hl = {
            fg = colors.orange,
         },
      },
      remove = {
         provider = "git_diff_removed",
         hl = {
            fg = colors.red,
         },
      },
   },
}

local components = {
   active = {},
   inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

-- Left
table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.lsp.name)
table.insert(components.active[1], comps.diagnos.error)
table.insert(components.active[1], comps.diagnos.warn)
table.insert(components.active[1], comps.diagnos.hint)
table.insert(components.active[1], comps.diagnos.info)
table.insert(components.inactive[1], comps.file.info)

-- Right
table.insert(components.active[3], comps.git.add)
table.insert(components.active[3], comps.git.change)
table.insert(components.active[3], comps.git.remove)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.git.branch)
table.insert(components.active[3], comps.scroll_bar)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.vi_mode.right)
table.insert(components.inactive[1], comps.file.os)

-- require("feline").setup {}
require("feline").setup {
   colors = colors,
   components = components,
   vi_mode_colors = vi_mode_colors,
   force_inactive = {
      filetypes = {
         "^NvimTree$",
         "^startify$",
         "^fugitive$",
         "^fugitiveblame$",
         "^qf$",
         "^help$",
      },
      buftypes = {
         "^terminal$",
      },
      bufnames = {},
   },
}
