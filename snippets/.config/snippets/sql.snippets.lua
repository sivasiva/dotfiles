local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep
local f = ls.function_node

local gooseMigration = [[
-- +goose Up
-- +goose StatementBegin

{}

---- create above / drop below ----
-- +goose StatementEnd



-- +goose Down

]]
local fnSnip = [[
create or replace function {}({}) returns jsonb as
$$
declare
  -- variables
  _res jsonb;
begin
  return _res;
end;
$$ language plpgsql;
]]

local fnWithTypeSnip = [[
drop type if exists {}_form;
create type {}_form as
(
  name text
);

create or replace function {}({}_form) returns jsonb as
$$
declare
  -- variables
  _res jsonb;
begin
  return _res;
end;
$$ language plpgsql;
]]

ls.add_snippets("sql", {
	s("mig", fmt(gooseMigration, { i(1) })),
	s("idx", fmt("create index if not exists {}_idx on {} using btree ({});", { i(1), rep(1), i(2) })),
	s("fn", fmt(fnSnip, { i(1), i(2) })),
	s("fnt", fmt(fnWithTypeSnip, { i(1), rep(1), rep(1), rep(1) })),
})
