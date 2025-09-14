local log = [[
console.log("$1", {$2})
]]

local consoleGroup = [[
console.group("------------ $1")
console.log($2)
console.groupEnd()
]]

return {
  { prefix = "cl", body = log, description = "console.log" },
  { prefix = "cg", body = consoleGroup, description = "console.group" },
}
