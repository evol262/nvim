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
  use {
    "akinsho/nvim-bufferline.lua",
    branch = "main",
    config = function()
      require("modules.configs.bufferline").config()
    end,
    event = "BufWinEnter",
  }

  use {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    config = function()
      require("modules.configs.gitsigns").config()
    end,
    event = { "BufRead", "BufNewFile" },
  }

  -- Statusline
  use {
    "feline-nvim/feline.nvim",
    config = function()
      require "modules.configs.feline"
    end,
    requires = {
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
      vim.cmd [[colorscheme nightfox]]
    end,
  }

  -- Colorizer
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup()
      vim.cmd "ColorizerReloadAllBuffers"
    end,
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
      "rafamadriz/friendly-snippets",
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
    "hrsh7th/cmp-nvim-lsp",
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
    config = function()
      require "modules.configs.treesitter"
    end,
  }

  use {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  }

  use {
    "danymat/neogen",
    config = function()
      require("neogen").setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  }

  use {
    "williamboman/mason.nvim",
    config = function()
      require "modules.configs.mason"
    end,
  }

  use {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    after = "mason.nvim",
    config = function()
      require "modules.configs.mason-tool-installer"
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
  }

  use {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require "modules.configs.mason-lspconfig"
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
        log = {
          use_console = false,
        },
        on_attach = function(client)
          if client.server_capabilities.documentFormattingProvider then
            vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.format()"
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
  use {
    "mhartington/formatter.nvim",
    config = function()
      require "modules.configs.formatter"
    end,
    event = "BufRead",
  }

  ------------------------ File manager, Picker, Fuzzy finder ---------------------------

  use {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      require "modules.configs.nvimtree"
    end,
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    module = "telescope",
    config = function()
      require "modules.configs.telescope"
    end,
  }

  use {
    "sudormrfbin/cheatsheet.nvim",

    requires = {
      { "nvim-telescope/telescope.nvim" },
    },
  }

  ------------------------ Misc Plugins -------------------------

  -- WhichKey
  use {
    "folke/which-key.nvim",
    keys = "<space>",
    config = function()
      require "modules.configs.whichkey"
    end,
  }

  -- Matching parens
  use { "andymass/vim-matchup", event = "CursorMoved" }

  -- Commentary
  use {
    "terrortylor/nvim-comment",
    cmd = "CommentToggle",
    config = function()
      require("nvim_comment").setup()
    end,
  }

  -- Dashboard
  use {
    "glepnir/dashboard-nvim",
    config = function()
      require "modules.configs.dashboard"
    end,
    event = "BufWinEnter",
  }

  use {
    "jdhao/better-escape.vim",
    event = "InsertEnter",
    config = function()
      vim.g.better_escape_interval = 300
      vim.g.better_escape_shortcut = { "jk" }
    end,
  }

  -- Indent lines
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      require "modules.configs.blankline"
    end,
  }
end)
