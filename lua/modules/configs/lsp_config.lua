local lsp_installer = require "nvim-lsp-installer"
local lsp_servers = {
   "bashls",
   "clangd",
   "dockerls",
   "gopls",
   "jsonls",
   "tsserver",
   "pyright",
   "sumneko_lua",
   "rust_analyzer",
   "solargraph",
   "yamlls",
}

for _, name in ipairs(lsp_servers) do
   local ok, server = require("nvim-lsp-installer.servers").get_server(name)

   if ok and not server:is_installed() then
      print("Installing LSP server " .. name)
      server:install()
   end
end

local function on_attach(client, bufnr)
   vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

   local opts = { noremap = true, silent = true }

   local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end

   if client.server_capabilities.documentFormattingProvider then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
   elseif client.server_capabilities.documentRangeFormattingProvider then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
   end
   buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
   buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
   buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
   buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
   buf_set_keymap("v", "<space>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
   buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
   buf_set_keymap("n", "<space>d", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
   buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
   buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
end

-- local capabilities = require("cmp-nvim-lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = { "documentation", "detail", "additionalTextEdits" },
}
capabilities.textDocument.codeAction = {
   dynamicRegistration = false,
   codeActionLiteralSupport = {
      codeActionKind = {
         valueSet = {
            "",
            "quickfix",
            "refactor",
            "refactor.extract",
            "refactor.inline",
            "refactor.rewrite",
            "source",
            "source.organizeImports",
         },
      },
   },
}

local null_ls_formatting = function(client)
   client.server_capabilities.documentFormattingProvider = false
   client.server_capabilities.documentRangeFormattingProvider = false
end

local servers = {
   tsserver = {
      on_attach = function(client, bufnr)
         null_ls_formatting(client)
         on_attach(client, bufnr)
      end,
      init_options = {
         lint = true,
      },
   },
   rust_analyzer = {
      on_attach = function(client, bufnr)
         null_ls_formatting(client)
         on_attach(client, bufnr)
      end,
   },
   pyright = {
      on_attach = function(client, bufnr)
         null_ls_formatting(client)
         on_attach(client, bufnr)
      end,
   },
   gopls = {
      on_attach = function(client, bufnr)
         null_ls_formatting(client)
         on_attach(client, bufnr)
      end,
   },
   sumneko_lua = {
      settings = {
         Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            diagnostics = { globals = { "vim" } },
            workspace = {
               library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
               },
            },
         },
      },
   },
}

local set_server_option = function(server, opt, opts)
   if servers[server] ~= nil and servers[server][opt] ~= nil then
      opts[opt] = servers[server][opt]
   end
end

lsp_installer.settings {
   ui = {
      icons = {
         server_installed = "✓",
         server_pending = "➜",
         server_uninstalled = "✗",
      },
   },
}

lsp_installer.on_server_ready(function(server)
   local opts = {}
   opts.capabilities = capabilities
   opts.on_attach = on_attach
   for _, opt in ipairs { "settings", "on_attach", "root_dir", "init_options" } do
      set_server_option(server.name, opt, opts)
   end

   server:setup(opts)
end)

vim.fn.sign_define("LspDiagnosticsSignError", { text = "", numhl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", numhl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", numhl = "LspDiagnosticsDefaultHint" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = {
      prefix = "",
      spacing = 0,
   },
   signs = true,
   underline = true,

   -- set this to true if you want diagnostics to show in insert mode
   update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
   border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
   border = "single",
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
   if msg:match "exit code" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end
