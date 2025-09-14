local lume = require("user.lume")
local snippets = require("user.my_snippets")

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

local react = {
  { prefix = "callback", body = callback, description = "react :: `callback` " },
  -- { prefix = "cg", body = consoleGroup, description = "console.group" },
  -- { prefix = "cl", body = log, description = "console.log" },
  { prefix = "ctx", body = "const $1 = useContext($2)$0", description = "useContext" },
  { prefix = "eff", body = eff, description = "useEffect" },
  { prefix = "effrn", body = effRn, description = "useEffect with return" },
  { prefix = "ignore", body = "// @ts-ignore", description = "Ignore the following line" },
  { prefix = "memo", body = memo, description = "react :: `memo` " },
  { prefix = "ref", body = "const ${1:elName}El = useRef(null)$0", description = "useRef" },
  { prefix = "ust", body = ust, description = "useState" },
}

return lume.merge(react, snippets.ts_common)
