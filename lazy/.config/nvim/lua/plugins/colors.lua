-- REF: https://github.com/johnsci911/nvim-ide
return {
  -- { "nvim-mini/mini.statusline", version = false },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin",
  --   },
  -- },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "VeryLazy" },
    opts = {
      -- also foreground or first_column
      render = "background",
      enable_named_colors = true,
      enable_tailwind = true,
      -- css = options;
      -- scss = options;
      -- html = {
      -- mode = "foreground";
      -- },
    },
  },
  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      {
        "gK",
        "<cmd>TWValues<cr>",
        desc = "Show tailwind CSS values",
      },
    },
    opts = {
      border = "rounded",
      show_unknown_classes = true,
      focus_preview = true,
    },
  },
  -- {
  --   "mechatroner/rainbow_csv",
  -- },
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      -- One handed keymap recommended, you will be using the mouse
      {
        "<leader>v",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = "Color pick under cursor",
      },
    },
    ---@type oklch.Opts
    opts = {},
  },
}
