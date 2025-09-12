local log = [[
console.log("$1", {$2})
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

local memo = [[
const ${1:memoizedValue} = React.memo(() => 
  ${2:computeExpensiveValue}(${3:a}, ${4:b}
  ), [${5:a}, ${6:b}])

$0"
]]

local callback = [[
const ${1:memoizedCallback} = useCallback(() => {
  ${2:doSomething}(${3:a}, ${4:b})
}, [${5:a}, ${6:b}])

$0

]]

local effRn = [[
useEffect(() => {
  $1

  return () => {,
    $2,
  },
}, [${3:dependencies}])

$0
]]
local eff = [[
useEffect(() => {
  $1

}, [${2:dependencies}])

$0
]]

local ust = [[
const [$1, set$1] = useState<$2>($3)
]]

return {
  { prefix = "ignore", body = "// @ts-ignore", description = "Ignore the following line" },
  { prefix = "cl", body = log, description = "console.log" },
  { prefix = "cg", body = consoleGroup, description = "console.group" },
  { prefix = "tita", body = tita, description = "Testing :: async `it` block" },
  { prefix = "desc", body = desc, description = "Testing :: describe block" },
  { prefix = "dit", body = dit, description = "Testing :: describe + `it` block" },
  { prefix = "tit", body = tit, description = "Testing :: `it` block" },
  { prefix = "memo", body = memo, description = "react :: `memo` " },
  { prefix = "callback", body = callback, description = "react :: `callback` " },
  { prefix = "ref", body = "const ${1:elName}El = useRef(null)$0", description = "useRef" },
  { prefix = "ctx", body = "const $1 = useContext($2)$0", description = "useContext" },
  { prefix = "eff", body = eff, description = "useEffect" },
  { prefix = "effrn", body = effRn, description = "useEffect with return" },
  { prefix = "ust", body = ust, description = "useState" },
}
