function Findroot(echo)
  local bufname = vim.api.nvim_buf_get_name(0)
  local buftype = vim.api.nvim_buf_get_option(0, 'buftype')

  -- 检查无效缓冲区类型
  if buftype ~= "" or bufname == "" or string.find(bufname, "://") then
    return ""
  end

  -- 获取文件所在目录并标准化路径
  local dir = vim.fn.fnamemodify(bufname, ":p:h")
  dir = string.gsub(dir, "\\", "/")
  dir = string.gsub(dir, "//", "/")

  -- 获取根目录匹配模式（支持全局变量覆盖）
  local patterns = vim.g.findroot_patterns or {
    '.git/',
    'manifest.json',
    '.root'
  }

  -- 向上搜索根目录
  local root_dir = ""
  local current = dir
  while current ~= "" and current ~= "/" do
    for _, pattern in ipairs(patterns) do
      local target = current .. "/" .. pattern
      if vim.fn.isdirectory(target) == 1 or vim.fn.filereadable(target) == 1 then
        root_dir = current
        break
      end
    end

    if root_dir ~= "" then break end
    current = vim.fn.fnamemodify(current, ":h")
  end

  if root_dir == "" then
    return ""
  end

  -- 检查子目录限制
  local not_for_subdir = vim.g.findroot_not_for_subdir or 1
  if not_for_subdir == 1 then
    local cwd = string.gsub(vim.fn.getcwd(), "\\", "/")
    cwd = string.gsub(cwd, "//", "/")
    if string.find(string.lower(cwd), string.lower(root_dir)) == 1 then
      return ""
    end
  end

  -- 显示根目录（如果需要）
  if echo then
    print("Project root: " .. root_dir)
  end

  return root_dir
end

function Bitbake_compile()
  local command_fmt = 'bitbake %s'
  local initial_command = Findroot(true) or ""

  if initial_command == "" then
    vim.notify("No project root found!", vim.log.levels.WARN)
    return ""
  end

  local module_name = vim.fn.fnamemodify(initial_command, ':t')
  module_name = vim.fn.escape(module_name, ' ')

  return string.format(command_fmt, module_name)
end

function CompileRunGcc()
  -- 获取环境变量 BBPATH
  local bb = os.getenv('BBPATH')

  -- 获取当前文件类型
  local filetype = vim.bo.filetype

  -- 获取当前文件名和基名
  local filename = vim.fn.expand('%')
  local basename = vim.fn.expand('%:r')
  -- 调试信息（可选）
  vim.notify("=================e", vim.log.levels.INFO)

  -- 根据文件类型处理
  if filetype == 'c' or filetype == 'cpp' then
    if bb == nil then
      vim.cmd('!g++ ' .. filename .. ' -o ' .. basename)
      vim.cmd('!time ./' .. basename)
    else
      local cmd = 'AsyncRun ' .. Bitbake_compile()
      vim.cmd(cmd)
    end
  elseif filetype == 'sh' then
    vim.cmd('!time bash ' .. filename)
  elseif filetype == 'python' then
    vim.cmd('AsyncRun -mode=term -pos=bottom python3 ' .. filename)
  else
    vim.notify("Unknown filetype: " .. filetype, vim.log.levels.WARN)
  end
end

-- 设置按键映射
vim.keymap.set('n', 'cc', CompileRunGcc, {
  noremap = true,
  silent = false,
  desc = "Compile and run current file"
})

-- 映射2: cp - 复制构建产物
vim.keymap.set('n', 'cp', function()
  local root_dir = Findroot(false) -- 不显示通知
  if root_dir ~= "" then
    local base_cmd = "!sshpass -p root scp " .. root_dir .. "/oe-workdir/package/usr"
    vim.api.nvim_feedkeys(":" .. base_cmd, "n", false)
  end
end, {
  noremap = true,
  silent = false, -- 显示命令输出
  desc = "SCP build artifacts from project"
})
