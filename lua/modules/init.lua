local functions = require "core.functions"

vim.cmd [[packadd packer.nvim]]

local present, _ = pcall(require, "modules.configs.packer")

if present then
   packer = require "packer"
else
   return false
end

local use = packer.use

return packer.startup(function()
   use { "wbthomason/packer.nvim", event = "VimEnter" }

   -- Lua Libraries
   use { "nvim-lua/popup.nvim", module = "popup" }
   use { "nvim-lua/plenary.nvim", module = "plenary" }

   ------------------------ UI ---------------------------

   -- Bufferline
   local disabled_tabline = functions.is_plugin_disabled "tabline"
   use {
      "akinsho/nvim-bufferline.lua",
      config = function()
         require("modules.configs.bufferline").config()
      end,
      event = "BufWinEnter",
      disable = disabled_tabline,
   }

   -- Statusline
   use {
      "feline-nvim/feline.nvim",
      config = function()
         require "modules.configs.feline"
      end,
      requires = {
         {
            "lewis6991/gitsigns.nvim",
            config = function()
               require("modules.configs.gitsigns").config()
            end,
         },
         {
            "kyazdani42/nvim-web-devicons",
            config = function()
               require("modules.configs.icons").config()
            end,
         },
      },
   }

   use {
      "EdenEast/nightfox.nvim",
      config = function()
         require("nightfox").load()
      end,
   }

   -- Colorizer
   local disabled_colorizer = functions.is_plugin_disabled "colorizer"
   use {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
         require("colorizer").setup()
         vim.cmd "ColorizerReloadAllBuffers"
      end,
      disable = disabled_colorizer,
   }

   ------------------------ Language specific ---------------------------

   -- Completion
   use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
         require "modules.configs.cmp"
      end,
      wants = { "LuaSnip" },
      requires = {
         {
            "L3MON4D3/LuaSnip",
            event = "BufReadPre",
            wants = "friendly-snippets",
            config = function()
               require "modules.configs.luasnip"
            end,
         },
         "evol262/friendly-snippets",
         {
            "windwp/nvim-autopairs",
            event = "BufReadPre",
            config = function()
               require "modules.configs.autopairs"
            end,
         },
      },
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "nvim-cmp",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "nvim-cmp",
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
   }

   use {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
      config = function()
         require "modules.configs.diffview"
      end,
   }

   -- Treesitter
   use {
      "nvim-treesitter/nvim-treesitter",
      run = "TSUpdate",
      event = "BufRead",
      config = function()
         require "modules.configs.treesitter"
      end,
   }

   -- LSP
   use {
      "williamboman/nvim-lsp-installer",
      module = "nvim-lsp-installer",
   }

   use {
      "neovim/nvim-lspconfig",
      module = "lspconfig",
      event = "BufRead",
      config = function()
         require "modules.configs.lsp_config"
      end,
   }

   use {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
         require("null-ls").setup {
            sources = {
               require("null-ls").builtins.formatting.stylua,
               require("null-ls").builtins.formatting.rustfmt,
               require("null-ls").builtins.formatting.black,
               require("null-ls").builtins.formatting.black,
               require("null-ls").builtins.formatting.codespell,
               require("null-ls").builtins.formatting.gofmt,
               require("null-ls").builtins.formatting.goimports,
               require("null-ls").builtins.formatting.isort,
               require("null-ls").builtins.formatting.prettier,
               require("null-ls").builtins.formatting.shellharden,
               require("null-ls").builtins.formatting.shfmt,
               require("null-ls").builtins.diagnostics.ansiblelint,
               require("null-ls").builtins.diagnostics.codespell,
               require("null-ls").builtins.diagnostics.mypy,
               require("null-ls").builtins.diagnostics.shellcheck,
            },
            log = {
               use_console = false,
            },
            on_attach = function(client)
               if client.resolved_capabilities.document_formatting then
                  vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
               end
            end,
         }
      end,
      requires = { "nvim-lua/plenary.nvim" },
   }

   use {
      "tami5/lspsaga.nvim",
      cmd = "Lspsaga",
      module = "lspsaga",
   }

   use {
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = function()
         require "modules.configs.lsp_sign"
      end,
   }

   -- Linter
   use {
      "mfussenegger/nvim-lint",
      config = function()
         require "modules.configs.linter"
      end,
      -- module = "lint",
   }

   use {
      "michaelb/sniprun",
      run = "bash install.sh",
      cmd = {
         "SnipRun",
         "SnipClose",
         "SnipTerminate",
         "SnipReset",
         "SnipReplMemoryClean",
      },
   }

   -- Viewer & finder for LSP symbols and tags
   use {
      "simrat39/symbols-outline.nvim",
      config = function()
         require "modules.configs.symbols"
      end,
      cmd = {
         "SymbolsOutline",
         "SymbolsOutlineOpen",
         "SymbolsOutlineClose",
      },
   }

   use {
      "onsails/lspkind-nvim",
      event = "BufRead",
      config = function()
         require("lspkind").init()
      end,
   }

   use {
      "weilbith/nvim-code-action-menu",
      event = "BufRead",
      cmd = "CodeActionMenu",
      requires = {
         "kosayoda/nvim-lightbulb",
         config = function()
            require "modules.configs.lightbulb"
         end,
      },
   }

   use {
      "tversteeg/registers.nvim",
      event = "BufEnter",
   }

   -- Formatter
   local disabled_formatter = functions.is_plugin_disabled "formatter"
   use {
      "mhartington/formatter.nvim",
      config = function()
         require "modules.configs.formatter"
      end,
      event = "BufRead",
      disable = disabled_formatter,
   }

   ------------------------ File manager, Picker, Fuzzy finder ---------------------------

   local disabled_tree = functions.is_plugin_disabled "nvim-tree"
   use {
      "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      config = function()
         require "modules.configs.nvimtree"
      end,
      disable = disabled_tree,
   }

   -- Telescope
   local disabled_telescope = functions.is_plugin_disabled "telescope"
   use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      module = "telescope",
      config = function()
         require "modules.configs.telescope"
      end,
      disable = disabled_telescope,
   }

   use {
      "sudormrfbin/cheatsheet.nvim",

      requires = {
         { "nvim-telescope/telescope.nvim" },
      },
   }

   use {
      "kdheepak/lazygit.nvim",
      cmd = "LazyGit",
      config = function()
         vim.g.lazygit_floating_window_use_plenary = 1
      end,
   }

   ------------------------ Misc Plugins -------------------------

   local disabled_range_highlight = functions.is_plugin_disabled "range-highlight"
   use {
      "winston0410/range-highlight.nvim",
      requires = {
         { "winston0410/cmd-parser.nvim", opt = true, module = "cmd-parser" },
      },
      config = function()
         require("range-highlight").setup()
      end,
      disable = disabled_range_highlight,
      event = "BufRead",
   }

   -- Write / Read files without permissions (e.vim.g. /etc files) without having
   -- to use `sudo nvim /path/to/file`
   local disabled_suda = functions.is_plugin_disabled "suda"
   use {
      "lambdalisue/suda.vim",
      disable = disabled_suda,
      cmd = { "SudaRead", "SudaWrite" },
   }

   local disabled_minimap = functions.is_plugin_disabled "minimap"
   use {
      "rinx/nvim-minimap",
      cmd = {
         "Minimap",
         "MinimapClose",
         "MinimapToggle",
         "MinimapRefresh",
         "MinimapUpdateHighlight",
      },
      disable = disabled_minimap,
   }

   local disabled_orgmode = functions.is_plugin_disabled "orgmode"
   use {
      "kristijanhusak/orgmode.nvim",
      ft = { "org" },
      config = function()
         require("modules.configs.orgmode").config()
      end,
      disable = disabled_orgmode,
   }

   use {
      "akinsho/org-bullets.nvim",
      after = "orgmode.nvim",
      config = function()
         require("modules.configs.orgmode").bullets()
      end,
      disable = disabled_orgmode,
   }

   -- Terminal
   local disabled_terminal = functions.is_plugin_disabled "terminal"
   use {
      "akinsho/nvim-toggleterm.lua",
      config = function()
         require "modules.configs.toggleterm"
      end,
      disable = disabled_terminal,
      module = { "toggleterm", "toggleterm.terminal" },
      cmd = { "ToggleTerm", "TermExec" },
      keys = { "n", "<space>t" },
   }

   -- WhichKey
   local disabled_whichkey = functions.is_plugin_disabled "which-key"
   use {
      "folke/which-key.nvim",
      keys = "<space>",
      config = function()
         require "modules.configs.whichkey"
      end,
      disable = disabled_whichkey,
   }

   -- Matching parens
   use { "andymass/vim-matchup", event = "CursorMoved" }

   -- Commentary
   local disabled_commentary = functions.is_plugin_disabled "commentary"
   use {
      "terrortylor/nvim-comment",
      cmd = "CommentToggle",
      config = function()
         require("nvim_comment").setup()
      end,
      disable = disabled_commentary,
   }

   -- Dashboard
   local disabled_dashboard = functions.is_plugin_disabled "dashboard"
   use {
      "glepnir/dashboard-nvim",
      config = function()
         require "modules.configs.dashboard"
      end,
      event = "BufWinEnter",
      disable = disabled_dashboard,
   }

   use {
      "jdhao/better-escape.vim",
      event = "InsertEnter",
      config = function()
         vim.g.better_escape_interval = 300
         vim.g.better_escape_shortcut = { "jk" }
      end,
   }

   -- Smooth Scroll
   local disabled_neoscroll = functions.is_plugin_disabled "neoscroll"
   use {
      "karb94/neoscroll.nvim",
      event = "WinScrolled",
      config = function()
         require("neoscroll").setup()
      end,
      disable = disabled_neoscroll,
   }

   -- Zen Mode
   local disabled_zen = functions.is_plugin_disabled "zen"
   use {
      "Pocco81/TrueZen.nvim",
      cmd = { "TZAtaraxis", "TZMinimalist", "TZFocus" },
      config = function()
         require "modules.configs.zenmode"
      end,
      disable = disabled_zen,
   }

   -- Indent lines
   local disabled_indent_lines = functions.is_plugin_disabled "indentlines"
   use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      setup = function()
         require "modules.configs.blankline"
      end,
      disable = disabled_indent_lines,
   }

   for _, plugin in pairs(Sv.user_plugins) do
      packer.use(plugin)
   end
end)
