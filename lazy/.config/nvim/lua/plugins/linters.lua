return {
  -- https://www.reddit.com/r/neovim/comments/19ceuoq/comment/kuna12d/
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { markdown = { "markdownlint" } },
    },
    config = function()
      local markdownlint = require("lint").linters.markdownlint
      markdownlint.args = {
        "--disable",
        "MD013",
        "MD007",
        "--", -- Required
      }
    end,
  },
}
