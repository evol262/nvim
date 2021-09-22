-- This is a example config
-- 'Sv' is the global options object
-- General Settings
Sv.pumheight = 20
Sv.timeoutlen = 100

Sv.shell = "bash"

Sv.undofile = true

Sv.leader_key = "space"
Sv.colorscheme = "github_dark_default"
Sv.relative_number = true

Sv.format_on_save = true

-- TreeSitter parsers config
Sv.treesitter.ensure_installed = {
   "lua",
   "bash",
   "json",
   "python",
   -- "c",
   -- "c_sharp",
   -- "clojure",
   "comment",
   -- "cpp",
   -- "commonlisp",
   -- "cuda",
   -- "dart",
   "dockerfile",
   -- "elixir",
   -- "erlang",
   "go",
   -- "fish",
   -- "haskell",
   -- "java",
   -- "jsdoc",
   "json",
   -- "graphql",
   -- "julia",
   -- "kotlin",
   -- "ledger",
   -- "latex",
   -- "php",
   "python",
   -- "nix",
   -- "ocamel",
   -- "ql",
   "regex",
   -- "ruby",
   "rust",
   -- "rst",
   -- "scss",
   -- "sparql",
   -- "teal",
   "toml",
   -- "typescript",
   -- "vue",
   "yaml",
   -- "zig"
}
Sv.treesitter.ignore_install = { "haskell" }
Sv.treesitter.highlight.enabled = true

-- lua
-- Sv.lang.lua.formatter.exe = "stylua"

-- python
-- Sv.lang.python.isort = true
-- Sv.lang.python.diagnostics.virtual_text = true
Sv.lang.python.analysis.use_library_code_types = true
--- to change default formatter from yapf to black
Sv.lang.python.formatter.exe = "black"
Sv.lang.python.formatter.args = { "--line-length 99 -" }

vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 0
vim.g.nvim_tree_quit_on_open = 0
-- go
-- to change default formatter from gofmt to goimports
-- Sv.lang.go.formatter.exe = "goimports"

-- javascript formatter is prettier

-- rust
-- Sv.lang.rust.formatter = {
-- 	exe = "rustfmt",
-- 	args = { "--emit=stdout" },
-- }

-- Additional Plugins
Sv.user_plugins = {
   { "b3nj5m1n/kommentary" },
   { "evol262/github-neovim-theme" },
   {
      "projekt0n/github-nvim-theme",
      config = function()
         require("github-theme").setup {
            theme_style = "dark_default",
         }
      end,
   },
   --     {"kyazdani42/blue-moon"},
}

vim.g.colorscheme = "github_dark_default"

-- Additional Leader bindings for WhichKey
-- Sv.user_which_key = {

--   A = {
--     name = "+Custom Leader Keys",
--     a = { "<cmd>'Command for a key'<cr>", "Description for a" },
--     b = { "<cmd>'Command for b key'<cr>", "Description for b" },
--   },

-- }

-- Additional Autocommands
Sv.user_autocommands = {
   { "BufWritePost,BufEnter", "*", "set nofoldenable foldmethod=manual foldlevelstart=99" },
   { "BufWritePre", [[*\(.md\|.MD\)\@<!]], [[:%s/\s\+$//e]] },
   { "BufRead", "*", [[call setpos(".", getpos("'\""))]] },
}
