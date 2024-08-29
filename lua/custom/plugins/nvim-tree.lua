return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "JMarkin/nvim-tree.lua-float-preview",
      lazy = true,
      config = function()
        local HEIGHT_RATIO = 0.8 -- You can change this
        local WIDTH_RATIO = 0.4  -- You can change this too
        require('float-preview').setup({
          window = {
            wrap = false,
            trim_height = false,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w / 2) + (window_w_int / 50)
              local center_y = ((vim.opt.lines:get() - window_h) / 2)
                  - vim.opt.cmdheight:get()
              return {
                style = "minimal",
                relative = "editor",
                border = "single",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end
          }
        })
      end
    }
  },
  config = function()
    local HEIGHT_RATIO = 0.8 -- You can change this
    local WIDTH_RATIO = 0.4  -- You can change this too
    local function my_on_attach(bufnr)
      local api = require('nvim-tree.api')


      api.config.mappings.default_on_attach(bufnr)


      local FloatPreview = require("float-preview")
      FloatPreview.attach_nvimtree(bufnr)
    end

    -- custom keymaps
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    vim.keymap.set('n', '<leader>f', require('nvim-tree.api').tree.toggle, opts("toggle"))

    require("nvim-tree").setup {
      on_attach = my_on_attach,
      hijack_cursor = false,
      auto_reload_on_write = true,
      disable_netrw = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      select_prompts = false,
      sort = {
        sorter = "name",
        folders_first = true,
        files_first = false,
      },
      view = {
        relativenumber = true,
        float = {
          quit_on_focus_loss = false,
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w / 2) - (window_w_int + (window_w_int / 50))
            local center_y = ((vim.opt.lines:get() - window_h) / 2)
                - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        full_name = false,
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
        highlight_git = true,
        highlight_diagnostics = true,
        highlight_opened_files = "none",
        highlight_modified = "none",
        highlight_clipboard = "name",
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = false,
              color = true,
            },
          },
          git_placement = "before",
          diagnostics_placement = "signcolumn",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            diagnostics = true,
            modified = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = true,
        update_root = false,
        ignore_list = {},
      },
      system_open = {
        cmd = "",
        args = {},
      },
      git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
      },
      diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      modified = {
        enable = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      filters = {
        git_ignored = true,
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {},
        exclude = {},
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          eject = true,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
        absolute_path = true,
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },
      experimental = {},
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    }
  end,
}
