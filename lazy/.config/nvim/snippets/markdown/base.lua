local link = [[
- [${1:|Code,Repo,GOLD!,Very Nice!,Step-by-step,Series|} - $2]($3)
]]

-- local code = [[
-- \`\`\`${1:elixir}
-- $2
-- \`\`\`
-- ]]

return {
  { prefix = "li", body = link, description = "link" },
  { prefix = "-", body = link, description = "link" },
  -- { prefix = "code", body = code, description = "code block" }, # Friendly Snippets already provides this
}
