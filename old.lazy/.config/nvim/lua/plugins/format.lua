return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ruby = { "rubyfmt", "rubocop" },
        sql = { "pg_format" },
        plpgsql = { "pg_format" },
      },
    },
  },
}
