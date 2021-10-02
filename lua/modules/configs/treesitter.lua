local ts_config = require "nvim-treesitter.configs"

ts_config.setup {
   ensure_installed = Sv.treesitter.ensure_installed,
   ignore_installed = Sv.treesitter.ignore_install,
   highlight = { enable = true, use_languagetree = true },
   indent = {
      enable = true,
      disable = { "python" },
   },
}
