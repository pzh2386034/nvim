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

-- 将 ,h 映射为向左切换分屏
vim.keymap.set('n', ',h', '<C-w>h', { noremap = true, silent = true, desc = "向左切换窗口" })
-- 将 ,l 映射为向右切换分屏
vim.keymap.set('n', ',l', '<C-w>l', { noremap = true, silent = true, desc = "向右切换窗口" })
vim.keymap.set('n', ',k', '<C-w>k', { noremap = true, silent = true, desc = "向右切换窗口" })
vim.keymap.set('n', ',j', '<C-w>j', { noremap = true, silent = true, desc = "向右切换窗口" })
