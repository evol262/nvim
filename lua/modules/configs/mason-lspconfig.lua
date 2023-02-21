require("mason-lspconfig").setup {
   ensure_installed = {
      bashls,
      clangd,
      dockerls,
      gopls,
      jsonls,
      tsserver,
      pyright,
      rust_analyzer,
      solargraph,
      lua_ls,
      yamlls,
   },
}
