local log = [[
console.log("$1", {$2})
]]
return {
  { prefix = "ignore", body = "// @ts-ignore", description = "Ignore the following line" },
  { prefix = "cl", body = log, description = "console.log" },
}
