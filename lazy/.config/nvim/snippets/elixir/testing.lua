local sivaCheck = [[

res = $1
assert res == "siva"
]]

return {
  { prefix = "siva", body = sivaCheck, description = "check value quickly" },
}
