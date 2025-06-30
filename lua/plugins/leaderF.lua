vim.g.findroot_not_for_subdir = 0
vim.g.Lf_ShortcutF = '<c-p>'

vim.g.Lf_ShowRelativePath = 0 -- 优化文件搜索<c-p>显示
vim.g.Lf_HideHelp = 1
vim.g.Lf_StlColorscheme = 'powerline'
vim.g.Lf_PreviewResult = { Function = 0, BufTag = 0 }
vim.g.Lf_StlSeparator = { left = '', right = '', font = '' }
vim.g.Lf_RootMarkers = { '.project', '.root', '.svn', '.git' }
vim.g.Lf_WorkingDirectoryMode = 'Ac'
-- 创建通用搜索函数
local function leaderf_rg_template(pattern, path)
  local word = vim.fn.expand('<cword>')
  local cmd = pattern
  local actual_path = path
  -- 处理路径函数
  if type(path) == "function" then
    actual_path = path()
  end

  -- 构建命令
  if actual_path then
    cmd = string.format(pattern, word, actual_path)
  else
    cmd = string.format(pattern, word)
  end

  -- 在命令行显示并允许用户编辑
  local modified_cmd = vim.fn.input("Leaderf command: ", cmd)

  -- 用户确认后执行（按 Enter）
  if modified_cmd ~= "" then
    vim.cmd(modified_cmd)
  end
end
-- 设置快捷键
local maps = {
  { ',r', '<cmd>LeaderfMru<CR>' },
  { ',f', '<cmd>LeaderfFunction<CR>' },
  { ',b', '<cmd>LeaderfBuffer<CR>' },
  -- { ',t', '<cmd>LeaderfTag<CR>' },
  -- { ',s', '<cmd>LeaderfLine<CR>' },
  { ',c', function() leaderf_rg_template("Leaderf! rg -S -e %s -i") end },
  -- { ',a', function() leaderf_rg_template("Leaderf! rg -S -e %s %s", vim.fn.Findroot(1)) end },
  { ',o', function() leaderf_rg_template("Leaderf! rg -S ~/org -e %s") end },
}

for _, map in ipairs(maps) do
  vim.keymap.set('n', map[1], map[2], { noremap = true })
end
