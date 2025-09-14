local M = {}

local log = [[
  console.log("== $1", {$2})
  ]]

local consoleGroup = [[
console.group("------------ $1")
console.log($2)
console.groupEnd()
]]

local desc = [[
describe("$1", () => {
  $0
}
]]

local dit = [[
describe("$1", () => {
  it("$2", () => {
    $0
  }
}
]]

local tit = [[
it('should $1', () => {
    $0
  })
]]

local tita = [[
it('should $1', async () => {
  $0
}
]]

M.ts_common = {
  { prefix = "cg", body = consoleGroup, description = "console.group" },
  { prefix = "cl", body = log, description = "console.log" },
  { prefix = "desc", body = desc, description = "Testing :: describe block" },
  { prefix = "dit", body = dit, description = "Testing :: describe + `it` block" },
  { prefix = "log", body = log, description = "console.log" },
  { prefix = "it", body = tit, description = "Testing :: `it` block" },
  { prefix = "ita", body = tita, description = "Testing :: async `it` block" },
}

return M
