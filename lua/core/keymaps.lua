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

vim.opt.incsearch = false
