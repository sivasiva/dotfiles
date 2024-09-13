return {
  {
    -- REF: https://www.reddit.com/r/neovim/comments/1bceiw2/comment/kuhmdp9/
    "echasnovski/mini.files",
    keys = {
      {
        "-",
        function()
          require("mini.files").open()
        end,
        desc = "Explore project files",
      },
    },

    config = function()
      require("mini.files").setup({
        mappings = {
          synchronize = "w",
          go_in_plus = "<CR>",
        },
      })

      local show_dotfiles = true

      local filter_show = function(_)
        return true
      end

      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local gio_open = function()
        local fs_entry = require("mini.files").get_fs_entry()
        vim.notify(vim.inspect(fs_entry))
        vim.fn.system(string.format("gio open '%s'", fs_entry.path))
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh({
          content = {
            filter = new_filter,
          },
        })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set("n", "g.", toggle_dotfiles, {
            buffer = buf_id,
          })
          vim.keymap.set("n", "-", require("mini.files").close, {
            buffer = buf_id,
          })
          vim.keymap.set("n", "<esc>", require("mini.files").close, {
            buffer = buf_id,
          })
          vim.keymap.set("n", "o", gio_open, {
            buffer = buf_id,
          })
        end,
      })
    end,

    lazy = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "\\",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        { desc = "Explore files" },
      },
    },
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/353#discussioncomment-5637248
    opts = {
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function()
            --   local filish = vim.bo.filetype
            --   local result = ""
            --   for key, val in pairs(e) do
            --     result = result .. "|" .. key .. "=" .. tostring(val)
            --     -- if val.global_local == false and val.scope == "win" then
            --     --   result = result .. "|" .. key .. "=" .. tostring(v[key] or "<not set>")
            --     -- end
            --   end
            --   print("NEOTREE enter", filish, result)
          end,
          -- id = "neotree-entered",
        },
      },
      filesystem = {
        window = {
          mappings = {
            ["\\"] = "close_window",
          },
        },
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = { ".git", "node_modules", ".elixir_ls", ".elixir-tools", ".lexical", "_build", "deps" },
          never_show = {
            ".git",
            ".history",
            ".DS_Store",
            "thumbs.db",
            ".idea",
            ".history",
            -- hide files from these folders, when searching within Neo-Tree explorer
            "_build",
            "deps",
            ".elixir_ls",
            "dialyzer*",
            "node_modules*",
          },
        },
      },
    },
  },
  -- { "nanotee/zoxide.vim", cmd = "Z" },
  {
    "nanotee/zoxide.vim",
    event = "VeryLazy",
    dependencies = {
      "junegunn/fzf",
    },
  },
  { -- REF: https://github.com/andrewthauer/dotfiles/blob/5cb699738f37b5f4247526e189dfa0bd30ea7e19/modules/neovim/.config/nvim/lua/plugins/session.lua#L5
    "coffebar/neovim-project",
    lazy = false,
    priority = 100,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      { "Shatur/neovim-session-manager" },
    },
    keys = {
      { "<leader>fp", ":Telescope neovim-project discover<cr>", desc = "Find project" },
      { "<leader>fP", ":NeovimProjectLoadRecent<cr>", desc = "Open last project" },
    },
    opts = {
      projects = { -- define project roots
        "~/projects/*",
        "~/ref/*",
        "~/dev/*",
        "~/sandbox/*",
        "~/projects/notes/*",
        "~/work/*",
        "~/notion/*",
        "~/work/dm23/*",
        "~/work/dm2024/*",
        "~/work/e/*",
        "~/.config/*",
        "~/dotter",
      },
      dashboard_mode = true,
      session_manager_opts = {
        autosave_last_session = true,
        autosave_only_in_session = false,
        autosave_ignore_not_normal = false,
      },
    },
    last_session_on_startup = false,
    init = function()
      -- enable saving the state of plugins in the session
      -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
      vim.opt.sessionoptions:append("globals")
    end,
  },
}
