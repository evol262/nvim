require("mason-tool-installer").setup {
   ensure_installed = {
      "black",
      "codespell",
      "gopls",
      "isort",
      "mypy",
      "shellcheck",
      "shfmt",
   },
}
