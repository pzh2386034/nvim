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

--------------------- sync vim key mapping--------------------------
-- 将 ,h 映射为向左切换分屏
vim.keymap.set('n', ',h', '<C-w>h', { noremap = true, silent = true, desc = "向左切换窗口" })
-- 将 ,l 映射为向右切换分屏
vim.keymap.set('n', ',l', '<C-w>l', { noremap = true, silent = true, desc = "向右切换窗口" })
vim.keymap.set('n', ',k', '<C-w>k', { noremap = true, silent = true, desc = "向右切换窗口" })
vim.keymap.set('n', ',j', '<C-w>j', { noremap = true, silent = true, desc = "向右切换窗口" })

vim.keymap.set('n', 'cw', ':w<CR>', { noremap = true, silent = true, desc = "Save changes" })
vim.keymap.set('n', 'ce', ':wq<CR>', { noremap = true, silent = true, desc = "Save changes and exit" })
vim.keymap.set('n', 'ci', ':only<CR>', { noremap = true, silent = true, desc = "Exit all other buffers" })
vim.keymap.set('n', '<C-g>', ":echo expand('%:p')<CR>", { noremap = true, silent = true, desc = "Display full dirpath" })

vim.keymap.set('n', 'rl', ':vertical resize -10<CR>', { noremap = true, silent = true, desc = "" })
vim.keymap.set('n', 'rh', ':vertical resize +10<CR>', { noremap = true, silent = true, desc = "" })
vim.keymap.set('n', 'rk', ':resize +10<CR>', { noremap = true, silent = true, desc = "" })
vim.keymap.set('n', 'rj', ':resize -10<CR>', { noremap = true, silent = true, desc = "" })


-- 定义切换 Quickfix 窗口的函数（高度 6 行）
local function toggle_quickfix()
  if vim.fn.getqflist({ winid = 1 }).winid ~= 0 then
    vim.cmd("cclose")
  else
    vim.cmd("botright copen 6")  -- 底部打开高度 6
  end
end

-- 映射快捷键
vim.keymap.set('n', 'co', toggle_quickfix, {
  noremap = true,
  silent = true,
  desc = "Toggle Quickfix (height 6)"
})
--------------------------------end-----------------------------------
---
---
---------------------------   fold begin  ----------------------------------
-- 启用折叠
vim.opt.foldenable = true
-- 设置默认折叠方法（推荐 indent 或 syntax）
vim.opt.foldmethod = "indent"
-- 设置折叠级别（0=全折叠，99=全展开）
vim.opt.foldlevel = 1
-- 折叠栏宽度
vim.opt.foldcolumn = "1"
-- 保存折叠状态
vim.opt.viewoptions:append("folds")
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"  -- 需安装 nvim-treesitter
-- 文件打开时自动展开到指定层级
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  command = "normal zR"
})
vim.opt.foldtext = "v:lua.vim.fn.printf('%s ▸ %d lines', getline(v:foldstart), v:foldend - v:foldstart + 1)"
-------------------------   fold end  ---------------------------------------

--------------------------------- 异步生成 tags (需要 plenary.nvim) ----------------------------------------
local async = require('plenary.job')

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*',
  callback = function()
    async:new({
      command = 'ctags',
      args = {
        '-R', '-f', '.git/tags',
        '--exclude=node_modules',
        '--exclude=.git',
        '--exclude=dist',
        '.'
      },
      cwd = vim.fn.getcwd(),
      on_exit = function(_, return_val)
        if return_val == 0 then
          print('Tags updated successfully')
        end
      end
    }):start()
  end
})
