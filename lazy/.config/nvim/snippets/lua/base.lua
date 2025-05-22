local snip = [[
  { prefix = "$1", body = "$2", description = "${3:description}" }
]]
return {
  { prefix = "sn", body = snip, description = "snippet setup" },
}
