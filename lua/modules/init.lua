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
   },

   -- Statusline
   {
      "feline-nvim/feline.nvim",
      config = function()
         require "modules.configs.feline"
      end,
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
      "saadparwaiz1/cmp_luasnip",
   },

   {
      "hrsh7th/cmp-nvim-lua",
   },

   {
      "hrsh7th/cmp-nvim-lsp",
   },

   {
      "hrsh7th/cmp-buffer",
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
      "nvim-treesitter/nvim-treesitter",
      build = "TSUpdate",
      config = function()
         require "modules.configs.treesitter"
      end,
   },

   {
      "p00f/nvim-ts-rainbow",
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
      event = "BufReadPre",
      cmd = "Mason",
      lazy = "false",
      config = function()
         require "modules.configs.mason"
      end,
      dependencies = {
         {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            lazy = "false",
            config = function()
               require "modules.configs.mason-tool-installer"
            end,
         },
         {

            "williamboman/mason-lspconfig.nvim",
            lazy = "false",
            config = function()
               require "modules.configs.mason-lspconfig"
               require "modules.configs.lsp_config"
            end,
         },
      },
   },

   {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function()
         require "modules.configs.mason-tool-installer"
      end,
   },

   -- LSP
   {
      "williamboman/nvim-lsp-installer",
   },

   {
      "neovim/nvim-lspconfig",
   },

   {
      "williamboman/mason-lspconfig.nvim",
      config = function()
         require "modules.configs.mason-lspconfig"
         require "modules.configs.lsp_config"
      end,
   },

   {
      "jose-elias-alvarez/null-ls.nvim",
      event = "BufEnter",
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
      dependencies = { "nvim-lua/plenary.nvim" },
   },

   {
      "tami5/lspsaga.nvim",
      cmd = "Lspsaga",
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
      "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      config = function()
         require "modules.configs.nvimtree"
      end,
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
