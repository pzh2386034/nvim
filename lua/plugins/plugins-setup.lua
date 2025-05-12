local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 保存此文件自动更新安装插件
-- 注意PackerCompile改成PackerSync
-- plugins.lua改成plugins-setup.lua 适应本地文件名
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim' -- 主题
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'nvim-treesitter/nvim-treesitter' -- 语法高亮
  use 'p00f/nvim-ts-rainbow' -- 配合treesitter，不同括号颜色区分
  use {
    'nvim-tree/nvim-tree.lua',  -- 文档树
    requires = {
      'nvim-tree/nvim-web-devicons', -- 文档树图标
    }
  }

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",  -- 这个相当于mason.nvim和lspconfig的桥梁
    "neovim/nvim-lspconfig"
  }
    -- 自动补全
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "L3MON4D3/LuaSnip" -- snippets引擎，不装这个自动补全会出问题
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"
  use "hrsh7th/cmp-path" -- 文件路径

  use "numToStr/Comment.nvim" -- gcc和gc注释
  use "windwp/nvim-autopairs" -- 自动补全括号

  -- use "akinsho/bufferline.nvim" -- buffer分割线
  use "lewis6991/gitsigns.nvim" -- 左则git提示
  use "nvim-telescope/telescope-fzy-native.nvim"


  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',  -- 文件检索
    requires = { {'nvim-lua/plenary.nvim'}, {'stevearc/aerial.nvim' } },
  }

  use {
    'ludovicchabant/vim-gutentags',
    config = function()
      -- 基础配置
      vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/nvim/tags/')
      vim.g.gutentags_file_list_command = 'rg --files'  -- 使用 ripgrep 加速
    end
  }

  use{ 'anuvyklack/pretty-fold.nvim',
  }

  use({
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup()
    end,
  })

  use {"ibhagwan/fzf-lua",
    requires = { {"nvim-tree/nvim-web-devicons"} },
  }

  use({
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!:).
    run = "make install_jsregexp"
  })

  -- Packer.nvim 配置
  use {
    'NeogitOrg/neogit',
    requires = {
      'nvim-lua/plenary.nvim', -- 必须依赖
      'sindrets/diffview.nvim', -- 可选：增强 diff 功能
      'ibhagwan/fzf-lua',              -- optional
    },
  }

  use "folke/which-key.nvim"

  if packer_bootstrap then
    require('packer').sync()
  end
end)
