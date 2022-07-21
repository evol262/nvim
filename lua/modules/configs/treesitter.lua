local ts_config = require "nvim-treesitter.configs"

ts_config.setup {
  ensure_installed = {
    "lua",
    "bash",
    "json",
    "python",
    "comment",
    "dockerfile",
    "go",
    "json",
    "python",
    "regex",
    "rust",
    "toml",
    "yaml",
  },
  ignore_installed = "haskell",
  highlight = { enable = true, use_languagetree = true },
  indent = {
    enable = true,
    disable = { "python", "go" },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}
