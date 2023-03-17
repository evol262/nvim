return {
   -- Lua Libraries
   { "nvim-lua/popup.nvim" },
   { "nvim-lua/plenary.nvim" },

   ------------------------ UI ---------------------------

   -- Bufferline
   {
      "akinsho/nvim-bufferline.lua",
      branch = "main",
      config = function()
         require("modules.configs.bufferline").config()
      end,
      event = "BufWinEnter",
   },

   {
      "lewis6991/gitsigns.nvim",
      branch = "main",
      config = function()
         require("modules.configs.gitsigns").config()
      end,
      event = "BufWinEnter",
   },

   -- Statusline
   {
      "feline-nvim/feline.nvim",
      config = function()
         require "modules.configs.feline"
      end,
      event = "BufWinEnter",
      dependencies = {
         {
            "kyazdani42/nvim-web-devicons",
            config = function()
               require("modules.configs.icons").config()
            end,
         },
      },
   },

   {
      "EdenEast/nightfox.nvim",
      lazy = false,
      priority = 1000,
      config = function()
         vim.cmd [[colorscheme nightfox]]
      end,
   },

   -- Colorizer
   {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
         require("colorizer").setup()
         vim.cmd "ColorizerReloadAllBuffers"
      end,
   },

   ------------------------ Language specific ---------------------------

   -- Completion
   {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
         require "modules.configs.cmp"
      end,
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "saadparwaiz1/cmp_luasnip",
         {
            "L3MON4D3/LuaSnip",
            event = "BufReadPre",
            config = function()
               require "modules.configs.luasnip"
            end,
         },
         "rafamadriz/friendly-snippets",
         {
            "windwp/nvim-autopairs",
            event = "BufReadPre",
            config = function()
               require "modules.configs.autopairs"
            end,
         },
      },
   },

   {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
      config = function()
         require "modules.configs.diffview"
      end,
   },

   -- Treesitter
   {
      event = "BufReadPre",
      "nvim-treesitter/nvim-treesitter",
      config = function()
         require "modules.configs.treesitter"
      end,
   },

   {
      "p00f/nvim-ts-rainbow",
      dependencies = "nvim-treesitter/nvim-treesitter",
      event = "InsertEnter",
   },

   {
      "danymat/neogen",
      config = function()
         require("neogen").setup {}
      end,
      dependencies = "nvim-treesitter/nvim-treesitter",
   },

   {
      "williamboman/mason.nvim",
      lazy = "false",
      config = function()
         require "modules.configs.mason"
      end,
   },
   {
      "williamboman/mason-lspconfig.nvim",
      event = "BufReadPre",
      config = function()
         require "modules.configs.mason-lspconfig"
         require "modules.configs.lsp_config"
      end,
      dependencies = "williamboman/mason.nvim",
   },
   {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      event = "BufReadPre",
      lazy = "false",
      config = function()
         require "modules.configs.mason-tool-installer"
      end,
      dependencies = "williamboman/mason.nvim",
   },

   -- LSP
   {
      "neovim/nvim-lspconfig",
      version = false,
   },

   {
      "jose-elias-alvarez/null-ls.nvim",
      event = "BufEnter",
      dependencies = { "nvim-lua/plenary.nvim", "mason.nvim" },
      config = function()
         require("null-ls").setup {
            sources = {
               require("null-ls").builtins.formatting.stylua,
               require("null-ls").builtins.formatting.rustfmt,
               require("null-ls").builtins.formatting.black,
               require("null-ls").builtins.formatting.codespell,
               require("null-ls").builtins.formatting.gofmt,
               require("null-ls").builtins.formatting.goimports,
               require("null-ls").builtins.formatting.isort,
               require("null-ls").builtins.formatting.prettier,
               require("null-ls").builtins.formatting.shellharden,
               require("null-ls").builtins.formatting.shfmt,
               require("null-ls").builtins.diagnostics.codespell,
               require("null-ls").builtins.diagnostics.mypy,
               require("null-ls").builtins.diagnostics.shellcheck,
            },
            log_level = "off",
            on_attach = function(client)
               if client.server_capabilities.documentFormattingProvider then
                  vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.format()"
               end
            end,
         }
      end,
   },

   {
      "tami5/lspsaga.nvim",
      event = "InsertEnter",
      cmd = "Lspsaga",
   },

   {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      event = "BufEnter",
      version = false,
      config = function()
         require("lsp_lines").setup()
         vim.diagnostic.config {
            virtual_text = false,
         }
      end,
   },

   {
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = function()
         require "modules.configs.lsp_sign"
      end,
   },

   {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
      dependencies = "kyazdani42/nvim-web-devicons",
      config = function()
         require("trouble").setup {}
      end,
   },

   -- Linter
   {
      "mfussenegger/nvim-lint",
      config = function()
         require "modules.configs.linter"
      end,
   },

   {
      "michaelb/sniprun",
      build = "bash install.sh",
      cmd = {
         "SnipRun",
         "SnipClose",
         "SnipTerminate",
         "SnipReset",
         "SnipReplMemoryClean",
      },
   },

   -- Viewer & finder for LSP symbols and tags
   {
      "simrat39/symbols-outline.nvim",
      config = function()
         require "modules.configs.symbols"
      end,
      cmd = {
         "SymbolsOutline",
         "SymbolsOutlineOpen",
         "SymbolsOutlineClose",
      },
   },

   {
      "onsails/lspkind-nvim",
      event = "BufRead",
      config = function()
         require("lspkind").init()
      end,
   },

   {
      "weilbith/nvim-code-action-menu",
      event = "BufRead",
      cmd = "CodeActionMenu",
      dependencies = {
         "kosayoda/nvim-lightbulb",
         config = function()
            require "modules.configs.lightbulb"
         end,
      },
   },

   {
      "tversteeg/registers.nvim",
      event = "BufEnter",
   },

   -- Formatter
   {
      "mhartington/formatter.nvim",
      config = function()
         require "modules.configs.formatter"
      end,
      event = "BufRead",
   },

   ------------------------ File manager, Picker, Fuzzy finder ---------------------------
   {
      "nvim-neo-tree/neo-tree.nvim",
      cmd = "Neotree",
      config = function()
         require "modules.configs.neotree"
      end,
      dependencies = {
         "nvim-lua/plenary.nvim",
         "MunifTanjim/nui.nvim",
         {
            "s1n7ax/nvim-window-picker",
            version = "1.x.x",
            config = function()
               require("window-picker").setup {
                  autoselect_one = true,
                  include_current = false,
                  filter_rules = {
                     bo = {
                        filetype = { "neo-tree", "neo-tree-popup", "notify" },
                        buftype = { "terminal", "quickfix" },
                     },
                  },
                  other_win_hl_color = "#e35e4f",
               }
            end,
         },
      },
   },

   -- Telescope
   {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      config = function()
         require "modules.configs.telescope"
      end,
   },

   {
      "sudormrfbin/cheatsheet.nvim",
      cmd = "Cheatsheet",
      dependencies = {
         { "nvim-telescope/telescope.nvim" },
      },
   },

   ------------------------ Misc Plugins -------------------------

   -- WhichKey
   {
      "folke/which-key.nvim",
      keys = "<space>",
      config = function()
         require "modules.configs.whichkey"
      end,
   },

   -- Commentary
   {
      "terrortylor/nvim-comment",
      cmd = "CommentToggle",
      config = function()
         require("nvim_comment").setup()
      end,
   },

   -- Dashboard
   {
      "glepnir/dashboard-nvim",
      config = function()
         require "modules.configs.dashboard"
      end,
      event = "BufWinEnter",
   },

   {
      "jdhao/better-escape.vim",
      event = "InsertEnter",
      config = function()
         vim.g.better_escape_interval = 300
         vim.g.better_escape_shortcut = { "jk" }
      end,
   },

   -- Indent lines
   {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      setup = function()
         require "modules.configs.blankline"
      end,
   },
}
