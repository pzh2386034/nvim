local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- forbiden wrap
opt.wrap = false

-- cursor line
opt.cursorline = true

--启动鼠标
-- opt.mouse:append('a')

--系统粘贴板
opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.ignorecase = true
opt.smartcase = true

--外观
opt.termguicolors = true
opt.signcolumn = "yes"
vim.cmd[[colorscheme tokyonight-moon]]

vim.opt.title = false
vim.opt.titlestring = ""

