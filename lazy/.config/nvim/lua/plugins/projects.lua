return {
  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        "~/lab/*",
        "~/projects/*",
        "~/gokrazy/*",
        "~/projects/gB4/*",
        "~/projects/r4g/*",
        "~/projects/dm/*",
        "~/.config/*",
      },
      picker = {
        type = "fzf-lua", -- or "fzf-lua"
        -- type = "telescope", -- or "fzf-lua"
      },
      dashboard_mode = true,
      session_manager_opts = {
        autosave_ignore_dirs = {
          vim.fn.expand("~"), -- don't create a session for $HOME/
          "/tmp",
        },
        autosave_ignore_filetypes = {
          -- All buffers of these file types will be closed before the session is saved
          "ccc-ui",
          "gitcommit",
          "gitrebase",
          "qf",
          "toggleterm",
        },
        autosave_last_session = true,
        autosave_only_in_session = false,
        autosave_ignore_not_normal = false,
      },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- optional picker
      -- { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      -- optional picker
      { "ibhagwan/fzf-lua" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },
}
