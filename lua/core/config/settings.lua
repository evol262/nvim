local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.hlsearch = true
opt.ignorecase = false
opt.termguicolors = true
opt.scrolloff = 5
opt.timeoutlen = 200
opt.cmdheight = 1
opt.guifont = "JetBrains Mono:11"
opt.spell = false
opt.spelllang = "en"
opt.pumheight = 20
opt.undofile = true
opt.swapfile = false
opt.ruler = false
opt.hidden = true
opt.splitbelow = true
opt.splitright = true
opt.cul = true
opt.updatetime = 250 -- update interval for gitsigns
opt.mouse = "a" -- enable mouse in neovim
opt.signcolumn = "yes"
opt.clipboard = "unnamed"
opt.background = "dark"

opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
opt.shortmess:append "sI"
vim.cmd "let &fcs='eob: '"

opt.whichwrap:append "<>hl"

-- for indentline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 4
vim.g.mapleader = " "
