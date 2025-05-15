require('neo-tree').setup({
  enable_diagnostics = false,
  enable_git_status = false,
  filesystem = {
    hide_dotfiles = true,
    hide_gitignored = true,
    hide_by_name = {
      ".DS_Store",
      "thumbs.db",
      --"node_modules",
    },
    hide_by_pattern = {
      --"*.meta",
      --"*/src/*/tsconfig.json",
    },
    commands = {
      avante_add_files = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local relative_path = require('avante.utils').relative_path(filepath)

        local sidebar = require('avante').get()

        local open = sidebar:is_open()
        -- ensure avante sidebar is open
        if not open then
          require('avante.api').ask()
          sidebar = require('avante').get()
        end

        sidebar.file_selector:add_selected_file(relative_path)

        -- remove neo tree buffer
        if not open then
          sidebar.file_selector:remove_selected_file('neo-tree filesystem [1]')
        end
      end,
    },
    window = {
      mappings = {
        ['oa'] = 'avante_add_files',
        ["<F5>"] = "refresh",
        -- ["o"] = "open",
         ["i"] = {
           function(state)
             local node = state.tree:get_node()
             print(node.path)
           end,
           desc = "print path",
         },
        ["l"] = "focus_preview",
         -- ["<C-s>"] = {"vertical_split"},
        ["P"] = {
          "toggle_preview",
          config = {
            use_float = false,
            -- use_image_nvim = true,
            -- title = 'Neo-tree Preview',
          },
        },
      },
    },
  }
})
-- vim.keymap.set('n', '<leader>g', ":Neotree<CR>")

vim.keymap.set('n', '-', function()
  local reveal_file = vim.fn.expand('%:p')
  if (reveal_file == '') then
    reveal_file = vim.fn.getcwd()
  else
    local f = io.open(reveal_file, "r")
    if (f) then
      f.close(f)
    else
      reveal_file = vim.fn.getcwd()
    end
  end
  require('neo-tree.command').execute({
    action = "focus",          -- OPTIONAL, this is the default value
    source = "filesystem",     -- OPTIONAL, this is the default value
    position = "left",         -- OPTIONAL, this is the default value
    reveal_file = reveal_file, -- path to file or folder to reveal
    reveal_force_cwd = true,   -- change cwd without asking if needed
  })
  end,
  { desc = "Open neo-tree at current file or working directory" }
);
