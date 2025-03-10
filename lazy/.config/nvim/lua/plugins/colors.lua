-- REF: https://github.com/johnsci911/nvim-ide
return {
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
}
