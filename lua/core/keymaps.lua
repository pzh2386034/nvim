vim.g.mapleader = ","

local keymap = vim.keymap

------视觉模式-------
-- 单行或多行移动

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

------正常模式
--窗口分割
-- keymap.set("n", "<leader>sv", "<C-w>v") --水平新增窗口
--keymap.set("n", "<leader>sh", "<C-w>s") --水平新增窗口
--toggle 高亮
keymap.set("n", "<leader>e", ":nohl<CR>")

-- 保存光标位置并执行搜索
local function smart_search(forward)
  -- 保存当前光标位置
  vim.cmd('keepjumps normal! m`')

  -- 执行搜索命令
  if forward then
    vim.cmd('normal! *')
  else
    vim.cmd('normal! #')
  end

  -- 恢复原始光标位置
  vim.cmd('normal! ``')
end

-- 设置映射
vim.keymap.set('n', '*', function() smart_search(true) end, { desc = "Search word under cursor forward" })
vim.keymap.set('n', '#', function() smart_search(false) end, { desc = "Search word under cursor backward" })
