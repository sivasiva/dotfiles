local csvConfig = [[

  NimbleCSV.define(CSVParser, escape: "\"")
  
  # for TSV files
  # NimbleCSV.define(CSVParser, separator: "\t", escape: "\"")
]]

local heexSigil = [[
~H"""
 $1 
"""
]]

local inspector = [[
  IO.inspect($1, label: ">>>>>>>>>>>>>>>>> ${2:$1}")
]]

return {
  { prefix = "csv", body = csvConfig, desc = "NimbleCSV config" },
  { prefix = "h", body = heexSigil, description = "HEEX block" },
  { prefix = "hx", body = heexSigil, description = "HEEX block" },
  { prefix = "inspect", body = inspector, description = "HEEX IO.inspect block" },
  { prefix = "sleep", body = ":timer.sleep(3000)", description = "sleep for n ms" },
}
