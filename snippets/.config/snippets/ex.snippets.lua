-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
-- local i = ls.insert_node
-- local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
-- local extras = require("luasnip.extras")
-- local t = ls.text_node
-- local rep = extras.rep
-- local l = extras.lambda
-- local c = ls.choice_node
--
local csvTmpl = [[
  alias NimbleCSV.RFC4180, as: CSVParser
  alias CSV, as: CSV

  # Uncomment for TSV files
  # NimbleCSV.define(CSVParser, separator: "\t", escape: "\"")
]]

ls.add_snippets("elixir", {
	s("csv", fmt(csvTmpl, {})),
})
