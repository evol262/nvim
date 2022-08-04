require("mason-tool-installer").setup {
   ensure_installed = {
      "black",
      "codespell",
      "gopls",
      "mypy",
      "shellcheck",
      "shfmt",
   },
}
