local beforeLoad = [[
, beforeLoad: async({ context }) => {
  $0
},
]]

return {
  -- ----------------------------------
  -- Router
  -- ----------------------------------
  { prefix = "bl", body = beforeLoad, description = "tanstack :: router :: beforeLoad" },

  -- ----------------------------------
  -- Query
  -- ----------------------------------
}
