local rfc = [[
type Props = {}

export default function $1({}: Props) {
  return <div>$1</div>
}
]]

return {
  { prefix = "fc", body = rfc, description = "react :: FC" },
}
